# Binary Search
이분 탐색(Binary Search)은 정렬된 배열에서 특정 값을 찾는 알고리즘. 이 알고리즘은 배열을 절반씩 분할하여 탐색 범위를 좁혀가며 값을 찾아냄.
기본적으로 Array에 n개의 element가 존재할 때 특정 element를 찾는 시간 복잡도는 O(n).
삽입 삭제가 빈번할 때 비효율적이고 이를 개선하기 위해서 이분 탐색이 고안됨. 이분 탐색의 시간복잡도는 O(logn)

```swift
// 재귀를 이용한 방식
func binarySearch(array: [Int],
                  left: Int,
                  right: Int,
                  target: Int) -> Int? {
    guard left <= right else { return nil }
    
    let mid = (left + right) / 2
    
    if array[mid] == target {
        return mid
    } else if array[mid] < target {
        return binarySearch(array: array, left: mid + 1, right: right, target: target)
    } else {
        return binarySearch(array: array, left: left, right: mid - 1, target: target)
    }
}

let array = [1,3,5,10]
if let index = binarySearch(array: array, left: 0, right: array.count - 1, target: 10) {
    print("10의 위치 - \(index)") // 3
}

// Array 확장을 통한 구현
extension Array where Element: Equatable {
    func binarySearch(_ target: Element,
                      comparator: (Element, Element) -> Bool) -> Int? {
        
        var left = 0
        var right = count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            
            if self[mid] == target {
                return mid
            } else if comparator(self[mid], target) {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}

if let index = array.binarySearch(10, comparator: { $0 < $1 }) {
    print("10의 위치 - \(index)") // 3
}
```
