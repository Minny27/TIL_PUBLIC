# 백트래킹(Backtracking)
**트리 구조에서 DFS를 이용해서 노드를 탐색할 때 특정 조건에 부합하지 않으면 다시 되돌아가서 순회하는 알고리즘입니다.**  
가치치기를 통해서 특정 서브 트리를 순회를 하지 않아 경우의 수를 줄일 수 있습니다.  
모든 경우의 수 중에서 특정 조건에 부합하는 경우만 순회합니다.

<br>

> ### 예시 코드
* **[백준 15649 - N과 M (1)](https://www.acmicpc.net/problem/15649)**
    ```swift
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let n = input[0], m = input[1]
        var visited = Array(repeating: false, count: n + 1)
        var answer = ""

        func permu(_ result: String, _ count: Int) {
            if count == m {
                answer += result + "\n"
                return
            }
            
            for i in 1...n {
                if !visited[i] {
                    visited[i] = true
                    permu(result + "\(i) ", count + 1)
                    visited[i] = false
                }
            }
        }

        permu("", 0)
        print(answer)
    ```