// Max Heap 구현
struct MaxHeap<T: Comparable> {
    var heap: Array<T> = [] // 비교가 가능한 타입의 배열 형태의 힙
    
    // heap에 값이 없는지 체크
    var isEmpty: Bool {
        return heap.count < 1 ? true : false
    }
        
    // 배열을 입력으로 받고 array의 원소를 heap에 insert
    init(array: Array<T>) {
        array.forEach { element in
            insert(element)
        }
    }
    
    // 왼쪽 자식 노드 인덱스 리턴
    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }
    
    // 오른쪽 자식 노드 인덱스 리턴
    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
    
    // 부모 노드 인덱스 리턴
    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }
    
    // 왼쪽 자식 노드가 있는지 체크
    private func hasLeftChild(_ index: Int) -> Bool {
        return heap.count > getLeftChildIndex(index)
    }
    
    // 오른쪽 자식 노드가 있는지 체크
    private func hasRightChild(_ index: Int) -> Bool {
        return heap.count > getRightChildIndex(index)
    }
    
    // 부모 노드가 있는지 체크
    private func hasParent(_ index: Int) -> Bool {
        return getParentIndex(index) >= 0
    }
    
    // 위로 스왑 메서드
    mutating private func siftUp() {
        var index = heap.count - 1 // insert된 새로운 리프 노드의 인덱스
        
        // 부모 노드가 존재하고, 부모보다 자식의 값이 더 클 때 부모와 자식 노드를 스왑하기
        while hasParent(index) && heap[getParentIndex(index)] < heap[index] {
            let parentIndex = getParentIndex(index)
            heap.swapAt(parentIndex, index)
            index = parentIndex
        }
    }
    
    // 힙에 값을 append하고 siftUp 메서드 실행
    mutating func insert(_ element: T) {
        heap.append(element)
        siftUp()
    }
    
    // 아래로 스왑 메서드
    mutating private func siftDown() {
        var index = 0 // 바뀐 새로운 루트 노드 인덱스
        
        // 왼쪽 자식 노드가 있으면 스왑을 시도
        while hasLeftChild(index) {
            let leftChildIndex = getLeftChildIndex(index) // 왼쪽 자식 노드 인덱스
            let rightChildIndex = getRightChildIndex(index) // 오른쪽 자식 노드 인덱스

            // 왼쪽 노드가 없으면 오른쪽 노드도 없기 때문에 왼쪽 노드 인덱스를 디폴트로 설정
            var biggerChildIndex = leftChildIndex // 왼쪽과 오른쪽 자식 노드의 값 중 큰 값 인덱스
            
            if hasRightChild(index) && heap[leftChildIndex] < heap[rightChildIndex] {
                biggerChildIndex = rightChildIndex
            }
            
            // 자식 노드의 값보다 부모 노드의 값이 더 크면 반복을 종료
            if heap[index] > heap[biggerChildIndex] { break }
            
            // 스왑 후, index를 스왑한 자식 인덱스로 업데이트
            heap.swapAt(index, biggerChildIndex)
            index = biggerChildIndex
        }
    }
    
    mutating func remove() {
        // 힙에 값이 없으면 리턴
        if isEmpty { return }
        
        let lastChildIndex = heap.count - 1 // 마지막 자식 노드 인덱스
        heap.swapAt(0, lastChildIndex) // 마지막 자식 노드와 루트 노드를 스왑
        heap.removeLast() // 마지막 자식 노드 삭제
        siftDown() // 새로운 루트 노드를 아래로 스왑하기
    }
}

func printHeap(heap: [Int]) {
    heap.forEach { element in
        print(element, terminator: " ")
    }
    print()
}

var array = [30, 20, 18, 9, 6, 50]
var heapObject = MaxHeap.init(array: array)
printHeap(heap: heapObject.heap)
// 50 20 30 9 6 18

//              50
//      20              30
//  9       6       18

heapObject.insert(90)
printHeap(heap: heapObject.heap)
// 90 20 50 9 6 18 30

//              90
//      20              50
//  9       6       18      30

heapObject.remove()
printHeap(heap: heapObject.heap)
// 50 20 30 9 6 18

//              50
//      20              30
//  9       6       18

let stringArray = ["apple", "bear"]
var defaultHeapObject = MaxHeap.init(array: stringArray)
print(defaultHeapObject.heap)
// bear, apple
