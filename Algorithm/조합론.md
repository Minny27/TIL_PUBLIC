# 조합론(Combinatorics)
조합론(組合論, 영어: combinatorics) 또는 조합수학(組合數學)은 유한하거나 가산적인 구조들에 대하여, 어떤 주어진 성질을 만족시키는 것들의 가짓수나 어떤 주어진 성질을 극대화하는 것을 연구하는 수학 분야입니다.(위키백과)

<br>

> ### 조합(Combination)
- 서로 다른 n개 중 r개를 **순서를 고려하지 않고** 뽑는 경우의 수

<p align=center>
<img src=https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fc9ewJ5%2FbtqHA40YSlj%2F3pRTEpXIOLJr0UWitdQEt1%2Fimg.png width=40%>
</p>

- 구현 코드
    ```swift
    let n = 4, m = 2
    let array = [1,2,3,4]
    var visited = Array(repeating: false, count: n)
    var result = [[Int]]()

    func combination(_ subArray: [Int], _ index: Int, _ count: Int, _ totalCount: Int) {
        if count == totalCount {
            result.append(subArray)
            return
        }
        
        for i in stride(from: index, to: n, by: 1) {
            if visited[i] { continue }
            
            var subArray = subArray
            subArray.append(array[i])
            
            visited[i] = true
            combination(subArray, i, count + 1, totalCount)
            visited[i] = false
        }
    }

    func printResult() {
        for i in result {
            for j in i {
                print(j, terminator: " ")
            }
            print()
        }
    }

    func solution() {
        combination([], 0, 0, m)
        printResult()
    }

    solution()

    // 결과
    // 1 2
    // 1 3
    // 1 4
    // 2 3
    // 2 4
    // 3 4 
    ```

<br>

> ### 순열(Permutation)
- 서로 다른 n개 중 r개를 **순서를 고려해서** 뽑는 경우의 수

<p align=center>
<img src=https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcR3YOt%2FbtqHBTdPGBn%2FX3nvQO9sWOnvKiaF79HtVK%2Fimg.png width=40%>
</p>

- 구현 코드
    ```swift
    let n = 4, m = 2
    let array = [1,2,3,4]
    var visited = Array(repeating: false, count: n)
    var result = [[Int]]()

    func permutation(_ subArray: [Int], _ count: Int, _ totalCount: Int) {
        if count == totalCount {
            result.append(subArray)
            return
        }
        
        for i in 0..<n {
            if visited[i] { continue }
            
            var subArray = subArray
            subArray.append(array[i])
            
            visited[i] = true
            permutation(subArray, count + 1, totalCount)
            visited[i] = false
        }
    }

    func printResult() {
        for i in result {
            for j in i {
                print(j, terminator: " ")
            }
            print()
        }
    }

    func solution() {
        permutation([], 0, m)
        printResult()
    }

    solution()

    // 결과
    // 1 2
    // 1 3
    // 1 4
    // 2 1
    // 2 3
    // 2 4
    // 3 1
    // 3 2
    // 3 4
    // 4 1
    // 4 2
    // 4 3 
    ```

<br>

> 참고 출처
- [코딩팩토리](https://coding-factory.tistory.com/606)
- [코딩팩토리](https://coding-factory.tistory.com/607)