# 분리 집합(Disjoint Set)
**교집합이 존재하지 않는 둘 이상의 집합입니다.**  
최소 스패닝 트리 구현을 위한 크루스칼 알고리즘, 자식 노드에서 최상위 부모 노드를 찾을 때 사용합니다.

<br>

> ### Union
- 두 집합을 하나의 집합으로 합치는 연산(한 집합의 root를 다른 한 집합의 자식으로 만듦)
- 시간복잡도: O(n)

<br>

> ### Find
- 해당 노드가 속한 집합의 최상위 부모 노드(root)를 찾는 연산
- 시간 복잡도: O(n)

<br>

<p align=center>
<img src="https://media.vlpt.us/images/mu1616/post/a6b20f43-6c17-4be6-accf-2f1be5c5fd4f/image.png" width=60%>
</p>

<p align=center>
출처: <a href="https://velog.io/@mu1616/%EB%B6%84%EB%A6%AC%EC%A7%91%ED%95%A9Disjoint-set">mu1616</a>
</p>

<br>

> ### 예시 코드
* **[백준 16562 - 친구비](https://www.acmicpc.net/problem/16562)**
    ```swift
    let data = readLine()!.split(separator: " ").map { Int(String($0))!}
    let (n, m, k) = (data[0], data[1], data[2])
    let costArray = [0] + readLine()!.split(separator: " ").map { Int(String($0))! }
    var parent = Array(Range(0...n))
    var parentList = Set<Int>()
    var answer = ""

    func find(_ a: Int) -> Int {
        if a == parent[a] {
            return a
        }
        return find(parent[a])
    }

    func union(_ a: Int, _ b: Int) {
        let a = find(a)
        let b = find(b)
        
        if a == b { return }
        
        if costArray[a] < costArray[b] {
            parent[b] = a
        } else {
            parent[a] = b
        }
    }

    func solution() {
        for _ in 0..<m {
            let edgeData = readLine()!.split(separator: " ").map { Int(String($0))! }
            let (start, end) = (edgeData[0], edgeData[1])
            
            union(start, end)
        }

        for i in 1...n {
            let root = find(parent[i])
            parentList.insert(root)
        }
        
        var sum = 0
        parentList.forEach {
            sum += costArray[$0]
        }
        
        answer = sum > k ? "Oh no" : "\(sum)"
        print(answer)
    }

    solution()
    ```