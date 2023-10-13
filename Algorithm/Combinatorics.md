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

    // 순서를 고려하지 않기 때문에 index에서 n까지 반복
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

    // 순서를 고려하기 때문에 0에서 n까지 반복
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

> ### 중복조합(Combinations with Repetition)
- 서로 다른 n개 중 순서를 고려하지 않고 중복을 허용해서 r개를 뽑는 경우의 수(n+r-1Cr)

<p align=center>
<img src="https://github.com/Minny27/TIL_PUBLIC/assets/68800789/4f4df466-75ba-43ac-b681-68f27f8d3c88" width=40%>
</p>

- 구현 코드
```swift
func combinateWithRepetition<T>(elements: [T], length: Int) -> [[T]] {
    var result: [[T]] = []
    
    func backtrack(current: [T], index: Int) {
        if current.count == length {
            result.append(current)
            return
        }

        for i in index..<elements.count {
            var newCurrent = current
            newCurrent.append(elements[i])
            backtrack(current: newCurrent, index: i)
        }
    }
    
    backtrack(current: [], index: 0)
    return result
}

let elements = [1, 2, 3]
let length = 2
let combinations = combinateWithRepetition(elements: elements, length: length)
for combi in combinations {
    print(combi)
}

// 결과
// [1, 1]
// [1, 2]
// [1, 3]
// [2, 2]
// [2, 3]
// [3, 3]
```

<br>

> ### 중복순열(Permutations with Repetition)
- 서로 다른 n개 중 **중복을 허용해서 r개를 순서를 고려해서** 뽑는 경우의 수(n^r)

<p align=center>
<img src="https://github.com/Minny27/TIL_PUBLIC/assets/68800789/d8ec6980-7c8e-4126-b7e4-ca072a3656d5" width=40%>
</p>

- 구현 코드
```swift
func permuteWithRepetition<T>(elements: [T], length: Int) -> [[T]] {
    var result: [[T]] = []
    
    func backtrack(current: [T]) {
        if current.count == length {
            result.append(current)
            return
        }

        // 중복을 허용하기 때문에 visited가 없고 0부터 n까지 반복
        for element in elements {
            var newCurrent = current
            newCurrent.append(element)
            backtrack(current: newCurrent)
        }
    }
    
    backtrack(current: [])
    return result
}

let elements = [1, 2, 3]
let length = 2
let permutations = permuteWithRepetition(elements: elements, length: length)
for permutation in permutations {
    print(permutation)
}

// 결과
// [1, 1]
// [1, 2]
// [1, 3]
// [2, 1]
// [2, 2]
// [2, 3]
// [3, 1]
// [3, 2]
// [3, 3]
```

> 참고 출처
- [코딩팩토리](https://coding-factory.tistory.com/606)
- [코딩팩토리](https://coding-factory.tistory.com/607)
