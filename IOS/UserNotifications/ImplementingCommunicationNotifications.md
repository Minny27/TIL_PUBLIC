# Implementing Communication Notifications
`Intent`를 사용하여 앱의 커뮤니케이션 알림을 구성하고 표시하는 방법  
커뮤니케이션 알림은 메시지, 통화처럼 사람 간 직접 커뮤니케이션을 나타내는 알림이다.

> ### Overview
- 커뮤니케이션 알림은 일반 알림보다 풍부한 UI를 제공한다.
- 알림에 발신자 아바타, 그룹 이름 같은 커뮤니케이션 맥락을 더 잘 보여줄 수 있다.
- 기본적으로 예약된 알림 요약을 통과할 수 있고, 조건에 따라 Focus도 통과할 수 있다.
- 앱은 커뮤니케이션 참여자를 `INPerson`으로 만들고, 메시지 또는 통화 intent를 구성한 뒤, `INInteraction`을 donate한다.
- donation 이후 받은 알림 콘텐츠를 업데이트하면 시스템이 커뮤니케이션 알림 형태로 표시한다.

> ### 설정
* **Communication Notifications Capability 활성화**
    - 앱 target에서 Communication Notifications capability를 활성화한다.

* **Info.plist 설정**
    - 앱이 지원하는 intent class 이름을 `NSUserActivityTypes` 배열에 추가한다.
    - 메시지 donation을 지원하려면 `INSendMessageIntent` 문자열을 포함한다.

```xml
<key>NSUserActivityTypes</key>
<array>
    <string>INSendMessageIntent</string>
</array>
```

* **Notification Service Extension**
    - 앱이 백그라운드에 있을 때 수신 알림 내용을 수정하려면 Notification Service Extension에서 처리한다.
    - 커뮤니케이션 알림으로 표시하려면 수신한 `UNNotificationContent`를 intent 기반으로 업데이트해야 한다.

> ### 구현 흐름
1. 커뮤니케이션에 참여한 사람을 `INPerson`으로 만든다.
2. 메시지는 `INSendMessageIntent`, 통화는 `INStartCallIntent`를 구성한다.
3. intent로 `INInteraction`을 생성한다.
4. 수신 커뮤니케이션이면 `interaction.direction = .incoming`으로 설정한다.
5. `interaction.donate()`를 호출한다.
6. donation이 성공하면 `UNNotificationContent.updating(from:)`으로 알림 내용을 갱신한다.
7. 갱신한 content를 `contentHandler`에 전달해 알림을 표시한다.

> ### 참여자 식별
* **INPerson**
    - 커뮤니케이션에 관련된 사람마다 `INPerson` 객체를 만든다.
    - 수신 알림에서 현재 사용자는 항상 recipient로 추론되므로 intent donation에 현재 사용자를 직접 포함하지 않는다.

* **연락처와 매칭되는 사람**
    - 주소록의 연락처와 매칭할 수 있다면 `contactIdentifier`를 제공한다.
    - 이메일 또는 전화번호를 알고 있다면 `INPersonHandle`의 타입을 `.emailAddress` 또는 `.phoneNumber`로 지정하고, suggestion type은 `.none`으로 설정한다.

* **앱 내부 사용자**
    - 연락처와 정확히 매칭할 정보가 없다면 앱 전용 `INPersonHandle`을 만든다.
    - 가장 가까운 `INPersonSuggestionType`을 지정하면 시스템이 연락처 제안을 제공할 수 있다.

> ### Message Intent
메시지를 받으면 `INSendMessageIntent`를 만든다.

- 메시지 intent는 하나의 `sender`와 하나 이상의 `recipients`를 가진다.
- 수신 메시지에서는 현재 사용자가 recipient로 자동 포함되므로 직접 넣지 않는다.
- 같은 대화의 메시지는 동일한 `conversationIdentifier`를 사용한다.
- 발신자의 `image`는 알림 아바타로 사용된다.
- 그룹 메시지에서는 현재 사용자와 발신자를 제외한 다른 참여자를 `recipients`에 넣는다.
- 그룹 이름이 있다면 `speakableGroupName`을 제공할 수 있다.
- 그룹 아바타는 intent에 이미지를 설정해 제공하며, interaction을 donate하기 전에 설정해야 한다.

```swift
let handle = INPersonHandle(value: "unique-user-id-1", type: .unknown)
let avatar = INImage(named: "profilepicture.png")
let sender = INPerson(
    personHandle: handle,
    nameComponents: nil,
    displayName: "Example",
    image: avatar,
    contactIdentifier: nil,
    customIdentifier: nil
)

let intent = INSendMessageIntent(
    recipients: nil,
    outgoingMessageType: .outgoingMessageText,
    content: "Message content",
    speakableGroupName: nil,
    conversationIdentifier: "unique-conversation-id-1",
    serviceName: nil,
    sender: sender,
    attachments: nil
)
```

> ### Call Intent
통화를 받으면 `INStartCallIntent`를 만든다.

- 통화 intent는 통화 참여자 배열인 `contacts`를 가진다.
- 수신 통화에서도 현재 사용자는 자동 포함되므로 `contacts`에 넣지 않는다.
- 부재중 통화에서 다시 걸기 등에 사용할 callback record 같은 가능한 정보를 정확히 제공한다.
- 발신자의 `image`는 알림 아바타로 사용된다.
- 그룹 통화에서는 현재 사용자를 제외한 다른 참여자들을 `contacts`에 넣는다.

```swift
let handle = INPersonHandle(value: "unique-user-id-1", type: .unknown)
let avatar = INImage(named: "profilepicture.png")
let caller = INPerson(
    personHandle: handle,
    nameComponents: nil,
    displayName: "Example",
    image: avatar,
    contactIdentifier: nil,
    customIdentifier: nil
)

let intent = INStartCallIntent(
    callRecordFilter: nil,
    callRecordToCallBack: callRecordToCallBack,
    audioRoute: .bluetoothAudioRoute,
    destinationType: .normal,
    contacts: [caller],
    callCapability: .audioCall
)
```

> ### Donate 후 알림 업데이트
intent를 구성한 뒤 `INInteraction`으로 donate하고, 성공하면 알림 content를 업데이트한다.

```swift
func didReceive(
    _ request: UNNotificationRequest,
    withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
) async {
    let intent: INSendMessageIntent = sendMessageIntent()
    let interaction = INInteraction(intent: intent, response: nil)
    interaction.direction = .incoming

    do {
        try await interaction.donate()
    } catch {
        return
    }

    do {
        let updatedContent = try request.content.updating(from: intent)
        contentHandler(updatedContent)
    } catch {
        contentHandler(request.content)
    }
}
```

> ### Outgoing Interaction
- 발신 interaction도 올바른 Focus 통과 동작과 Siri 제안 품질에 중요하다.
- 사용자가 직접 보낸 메시지나 시작한 통화는 `interaction.direction = .outgoing`으로 설정한다.
- 발신 메시지의 경우 현재 사용자가 sender가 되므로 `INSendMessageIntent`의 `sender`는 `nil`로 두고 recipients와 메타데이터를 제공한다.

> ### 추가 Donation Metadata
`INSendMessageIntentDonationMetadata`를 사용하면 메시지 donation 동작을 더 구체적으로 제어할 수 있다.

- 전체 수신자 목록이 너무 크면 일부 recipient만 제공하고 전체 수신자 수를 metadata에 지정할 수 있다.
- 이때 전체 수신자 수는 `recipientCount`로 지정한다.
- 사용자를 직접 멘션한 메시지는 `mentionsCurrentUser`를 설정할 수 있다.
- 현재 사용자에게 답장한 메시지는 `isReplyToCurrentUser`를 설정할 수 있다.
- 발신자가 Focus 상태에서도 알리기를 명시적으로 선택한 경우 `notifyRecipientAnyway`를 사용할 수 있다.
- Focus 상태 접근이 필요한 기능은 사용자 권한이 필요하며, `INFocusStatusCenter.requestAuthorization`을 사용한다.

> ### 주의할 점
- 수신 커뮤니케이션 donation에는 현재 사용자를 직접 참여자로 넣지 않는다.
- 그룹 대화에서는 같은 대화를 나타내는 안정적인 `conversationIdentifier`를 유지한다.
- 아바타 이미지는 interaction donation 전에 intent에 설정한다.
- donation 실패와 content 업데이트 실패를 모두 처리해야 한다.
- Focus를 통과하는 동작은 사용자가 기대할 수 있는 명시적인 상황에서만 사용한다.

> 참고 출처
- [Apple Developer Documentation - Implementing Communication Notifications](https://developer.apple.com/documentation/usernotifications/implementing-communication-notifications)
