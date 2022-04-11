# DFS+BFS

> ### DFS(Depth First Search)
- 루트 노드에서 시작해서 다음 분기(branch)로 넘어가기 전에 해당 분기를 완벽하게 탐색하는 방식
- **형제보다 자식 노드를 먼저 탐색**
- 재귀(Recursion)를 이용해서 자식 노드로 한 없이 깊이 탐색
- **전위 순회(Pre-Order Traversals)** 를 포함한 다른 형태의 트리 순회는 모두 DFS의 한 종류입니다.
- 그래프 탐색 시, 노드의 방문 체크를 해야합니다. 하지 않으면 무한루프가 발생할 수 있습니다.

<p align=center>
<img src="https://user-images.githubusercontent.com/68800789/162682513-00969ede-c667-4598-a94b-fac8d8cd9f77.gif" width=40%>
</p>

<p align=center>
출처: <a href="https://namu.wiki/w/%EB%84%88%EB%B9%84%20%EC%9A%B0%EC%84%A0%20%ED%83%90%EC%83%89">나무위키</a>
</p>

- 장점
    - **현 경로상의 노드들만을 기억하면 되므로 저장 공간의 수요가 비교적 적습니다.**
    - 목표 노드가 깊은 단계에 있을 경우 해를 빨리 구할 수 있습니다.
- 단점
    - 해가 없는 경로에 깊이 빠질 가능성이 있습니다. 따라서 실제의 경우 미리 지정한 임의의 깊이까지만 탐색하고 목표노드를 발견하지 못하면 다음의 경로를 따라 탐색하는 방법이 유용할 수 있습니다.
    - 얻어진 해가 최단 경로가 된다는 보장을 할 수 없습니다. 이는 목표에 이르는 경로가 다수인 문제에 대해 깊이우선 탐색은 해에 다다르면 탐색을 끝내버리므로, 이때 얻어진 해는 최적이 아닐 수 있다는 의미입니다.
- 예시 코드
    - [백준 2468 - 안전 영역](https://www.acmicpc.net/problem/2468)
    ```swift
    typealias Point = (i: Int, j: Int)

    let n = Int(readLine()!)!
    let ds = [(-1,0),(1,0),(0,-1),(0,1)]
    var board = [[Int]]()
    var visited = Array(repeating: Array(repeating: false, count: n), count: n)
    var visitedCopy = [[Bool]]()
    var answer = 0

    for _ in 0..<n {
        board.append(readLine()!.split(separator: " ").map { Int(String($0))! })
    }

    func isBoundary(_ i: Int, _ j: Int) -> Bool {
        return 0 <= i && i < n && 0 <= j && j < n
    }

    func dfs(_ point: Point, _ k: Int) -> Int {
        if !isBoundary(point.i, point.j) || visitedCopy[point.i][point.j] || board[point.i][point.j] <= k { return 1 }
        
        visitedCopy[point.i][point.j] = true
        
        for d in ds {
            let ni = point.i + d.0
            let nj = point.j + d.1
            
            dfs(Point(ni, nj), k)
        }
        return 1
    }

    func solution() {
        for k in 0...100 {
            visitedCopy = visited
            var result = 0
            for i in 0..<n {
                for j in 0..<n {
                    if visitedCopy[i][j] || board[i][j] <= k { continue }
                    result += dfs(Point(i, j), k)
                }
            }
            answer = max(answer, result)
        }
        print(answer)
    }

    solution()
    ```

<br>

> ### BFS(Breadth First Search)
- 루트 노드에서 시작해서 인접한 모든 정점들을 우선 방문하는 방법
- **자식보다 형제 노드를 먼저 탐색**
- 큐를 이용해서 형제 노드를 탐색 후 레벨 순서대로 순회합니다.
- 그래프 탐색 시, 노드의 방문 체크를 해야합니다. 하지 않으면 무한루프가 발생할 수 있습니다.

<p align=center>
<img src="https://user-images.githubusercontent.com/68800789/162682511-993d05c2-8084-4d7e-8e65-a21965f2e22e.gif" width=40%>
</p>

<p align=center>
출처: <a href="https://namu.wiki/w/%EB%84%88%EB%B9%84%20%EC%9A%B0%EC%84%A0%20%ED%83%90%EC%83%89">나무위키</a>

- 장점
    - **출발노드에서 목표 노드까지의 최단 길이 경로를 보장합니다.**
- 단점
    - 경로가 매우 길 경우에는 탐색 가지가 급격히 증가함에 따라 보다 많은 기억 공간을 필요로 하게 됩니다.
    - 해가 존재하지 않는다면 유한 그래프(finite graph)의 경우에는 모든 그래프를 탐색한 후에 실패로 끝납니다.
    - 무한 그래프(infinite graph)의 경우에는 결코 해를 찾지도 못하고, 끝내지도 못할 수 있습니다.
- 예시 코드
    - [백준 4963 - 섬의 개수](https://www.acmicpc.net/problem/4963)
    ```swift
    typealias Point = (i: Int, j: Int)

    let ds = [(-1,0),(1,0),(0,-1),(0,1),(-1,-1),(-1,1),(1,1),(1,-1)]
    var n = 0, m = 0
    var board = [[Int]]()
    var visited = [[Bool]]()
    var answer = ""

    func isBoundary(_ point: Point) -> Bool {
        return 0 <= point.i && point.i < n && 0 <= point.j && point.j < m
    }

    func bfs(_ point: Point) -> Int {
        var q = [point]
        
        while !q.isEmpty {
            let point = q.removeLast()
            visited[point.i][point.j] = true
            
            for d in ds {
                let ni = point.i + d.0
                let nj = point.j + d.1
                
                if !isBoundary(Point(ni, nj)) || board[ni][nj] == 0 || visited[ni][nj] { continue }
                q.append(Point(ni, nj))
            }
        }
        return 1
    }

    func solution() {
        while true {
            let input = readLine()!.split(separator: " ").map { Int(String($0))! }
            m = input[0]
            n = input[1]
            
            if n == 0 && m == 0 { break }
            
            board = [[Int]]()
            visited = Array(repeating: Array(repeating: false, count: m), count: n)
            var result = 0
            
            for _ in 0..<n {
                board.append(readLine()!.split(separator: " ").map { Int(String($0))! })
            }
            
            for i in 0..<n {
                for j in 0..<m {
                    if visited[i][j] || board[i][j] == 0 { continue }
                    result += bfs(Point(i, j))
                }
            }
            answer += "\(result)\n"
        }
        print(answer)
    }

    solution()
    ```

<br>

> ### 시간복잡도
- N: 노드, E: 간선
- 인접 리스트: O(N + E)
- 인접 행렬: O(N^2)

<br>

> 참고 출처
- [gmlwjd9405](https://gmlwjd9405.github.io/2018/08/14/algorithm-dfs.html)
- [gmlwjd9405](https://gmlwjd9405.github.io/2018/08/15/algorithm-bfs.html)
- [devuna](https://devuna.tistory.com/32)
- 위키백과