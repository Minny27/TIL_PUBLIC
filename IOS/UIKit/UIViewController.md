# UIViewController
UIKit 앱의 view 계층을 관리하는 객체

## Overview
모든 뷰 컨트롤러에서 공통으로 공유된 동작을 정의합니다. UIViewController 클래스의 인스턴스를 직접 생성하는 경우는 거의 없습니다. 대신에, UIViewController를 서브클래스로 만들어서 view controller의 뷰의 계층을 관리하는데 필요한 메서드와 프로퍼티를 추가합니다.

view controller의 주요 책임은 다음을 포함합니다:
- 기본적인 데이터의 변화에 응답해서 view의 콘텐츠를 업데이트합니다.
- 뷰들의 유저 인터렉션에 응답합니다.
- 뷰를 리사이징하고 전반적인 인터페이스의 레이아웃을 관리합니다.
- 다른 앱에 있는 다른 view controller들을 포함하는 다른 객체들을 조정합니다.

view controller는 view controller가 관리하는 view와 밀접하게 연결되어 있고 view controller의 계층에서 이벤트를 처리하는데 참여합니다.
특히, view controller는 UIResponder 객체이고 the responder chain에 삽입됩니다. 특히, 뷰 컨트롤러는 UIResponder 객체이이고 뷰 컨트롤러의 루트 뷰와 일반적으로 다른 뷰 컨트롤러에 속하는 해당 뷰의 슈퍼 뷰 사이의 응답자 체인에 삽입됩니다(?) 뷰 컨트롤러의 뷰가 이벤트를 처리하지 않는 경우, 뷰 컨트롤러는 이벤트를 처리하거나 슈퍼뷰에 전달할 수 있습니다.

view controller는 단독으로 거의 사용되지 않습니다. 대신에, 당신은 자주 앱의 유저 인터페이스의 부분을 가지는 여러 view controller를 사용합니다. 예를 들어, 한 뷰 컨트롤러는 아이템을 테이블로 보여줄 수 있고, 다른 뷰 컨트롤러에서는 테이블에서 선택된 아이템을 보여줄 수 있습니다. 보통 한 개 뷰 컨트롤러에 뷰들이 한 번에 보입니다. 다른 셋의 뷰를 표시하는 다른 뷰 컨트롤러를 present할 수 있고 또는 다른 뷰 컨트롤러의 컨텐츠의 컨테이너 역할을 할 수 있고 필요시 뷰에 애니메이션도 설정할 수 있습니다. 

## Manage views
각 뷰 컨트롤러는 이 클래스의 root 뷰를 할당한 view 프로퍼티의 뷰 계층을 관리합니다. root view는 기본적으로 뷰의 계층의 남은 view 계층을 위한 컨테이너 역할을 합니다. 사이즈와 root view의 부분은 앱이 window 또는 부모 view controller가 가지는 객체로 부터 결정됩니다. 윈도우가 가지는 뷰 컨트롤러가 루트 뷰 컨트롤러이고 그 뷰 컨트롤러의 뷰는 윈도우를 채우도록 크기가 조정됩니다.

뷰 컨트롤러는 뷰를 lazy하게 적재합니다. 처음 view 프로퍼티에 접근하는 것은 뷰 컨트롤러의 뷰를 적재 또는 생성합니다. view controller에 뷰를 지정하는 다양한 방법이 있습니다.
- 앱의 스토리보트에서 뷰 컨트롤러와 그 뷰 컨트롤러의 뷰를 지정합니다. 스토리보드는 뷰들을 지정하는 방식을 선호합니다. 스토리보드에서 뷰를 지정하고 뷰 컨트롤러에 연결합니다. 또한, 뷰 컨트롤러 사이의 관계와 세그를 지정해서 앱의 동작을 보다 쉽게 보고 수정할 수 있습니다.

스토리보드로부터 뷰 컨트롤러를 적재하기 위해서 instantiateViewController(withIdentifier:) 메서드에 적절한 스토리보드 객체를 할당해서 호출합니다.

- nib file을 사용해서 view controller에 뷰를 지정합니다. nib 파일을 사용하여 뷰 컨트롤러에 대한 뷰를 지정합니다. nib 파일을 사용하면 단일 뷰 컨트롤러의 뷰를 지정할 수 있지만 뷰 컨트롤러 간의 segue 또는 관계를 정의할 수는 없습니다. nib 파일을 사용하여 뷰 컨트롤러 객체를 초기화하려면 코드로 뷰 컨트롤러 클래스를 만들고 init(nibName:bundle:) 메서드를 사용하여 초기화합니다.

-  loadView() 메서드를 사용해서 view controller에 view들을 지정합니다. 그 메서드에서 view의 계층구조를 코드적으로 추가하고 view 프로퍼티에 계층 구조를 가지는 root view를 assign합니다. 
