# DP(Dynamic Programming)
**DP(동적 계획법)는 큰 문제를 작은 문제로 나누어 문제를 해결하는 방법입니다.** 이것은 **부분 문제 반복과 최적 부분 구조를 가지고 있는 알고리즘**을 일반적인 방법에 비해 더욱 적은 시간 내에 풀 때 사용합니다.

<br>

> ### 메모이제이션(Memoization)
- 부분 문제 반복를 반복할 경우, **한 번 계산된 결과를 저장해 두었다가 활용하는 방식**으로 중복 계산을 줄이는 것을 메모이제이션(Memoization)이라고 합니다.

<br>

### Top-Down
- **큰 문제를 해결하기 위해 작은 문제를 호출하는 방식(하향식)**
- 그래프에서 루트 노드에서 리프 노드로 탐색하는 방식
- 예시 코드
    - 피보나치 수열(Top-Down)
    ```swift
    var dp = Array(repeating: 0, count: 11)

    func fibo(_ n: Int) -> Int {
        if n <= 2 {
            dp[n] = 1
            return dp[n]
        }
        
        // 이미 계산한 값이 있으면 그 값을 리턴
        if dp[n] != 0 { return dp[n] }
        
        // 메모이제이션
        dp[n] = fibo(n - 1) + fibo(n - 2)
        return dp[n]
    }

    fibo(10)
    print(dp)

    // 결과
    // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    ```

<br>

### Bottom-Up
- **가장 작은 문제들부터 답을 구해가며 전체 문제의 답을 찾는 방식(상향식)**
- 재귀 호출을 하지 않기 때문에 시간과 메모리 사용량을 줄일 수 있는 장점이 있다.
- 그래프에서 리프 노드에서 루트 노드로 탐색하는 방식
- 예시 코드
    - 피보나치 수열(Bottom-Up)
    ```swift
    var dp = Array(repeating: 0, count: 11)
    dp[1] = 1; dp[2] = 1

    for i in 3..<11 {
        dp[i] = dp[i - 1] + dp[i - 2]
    }
    print(dp)

    // 결과
    // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    ```

<br>

> ### 시간 복잡도
- 인접 행렬을 DFS로 해결하는 시간복잡도 O(N^2)을 O(N)으로 개선시켜줍니다.

<br>

> 참고 출처
- [chelsea](https://velog.io/@chelsea/1-%EB%8F%99%EC%A0%81-%EA%B3%84%ED%9A%8D%EB%B2%95Dynamic-Programming-DP)
- [hongjw1938](https://hongjw1938.tistory.com/47)
- [kimdukbae](https://velog.io/@kimdukbae/%EB%8B%A4%EC%9D%B4%EB%82%98%EB%AF%B9-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D-Dynamic-Programming)
- 위키백과