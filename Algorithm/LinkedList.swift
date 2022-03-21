class Node<T> {
    var data: T
    var next: Node?
    
    init(data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

class LinkedList<T: Equatable> {
    var head: Node<T>? // 첫 번째 노드를 가리키는 포인터
    
    // 노드를 리스트의 가장 마지막에 추가하는 메서드
    func append(data: T) {
        if head == nil {
            head = Node(data: data)
            return
        }
        
        // 현재 헤드에서 다음 노드를 가리키는 next가 값이 nil일 때까지(마지막 노드까지) node를 다음 노드로 갱신
        var node = head
        while node?.next != nil {
            node = node?.next // 노드의 연결된 다음 노드가 nil 아니기 때문에 강제 언래핑
        }
        
        // 마지막 노드일때, 해당 노드가 가리키는 다음 노드에 data 넣기
        node?.next = Node(data: data)
    }
    
    // 특정 위치에 노드 삽입
    func insert(data: T, at index: Int) {
        if head == nil {
            head = Node(data: data)
            return
        }
        
        // 0번 째에 노드를 삽입하면, head를 변경
        if index == 0 {
            let nextNode = head
            head = Node(data: data)
            head?.next = Node(data: nextNode!.data, next: nextNode?.next) // head가 nil인 경우는 이미 처리했기 때문에 강제 언래핑
            
            return
        }
        
        // 특정 위치(인덱스)로 노드를 삽입하는 경우, 특정 위치 이전 노드와 특정 위치 노드를 알야합니다.
        // 특정 노드 위치(node.next)를 알기 위해서는 특정 노드의 이전 노드(node)를 알아야합니다.
        var node = head
        for _ in 0..<index-1 {
            if node?.next == nil { break }
            node = node?.next
        }
        
        if node?.next == nil {
            print("insert하려는 위치가 너무 큽니다!")
            return
        }
        
        let nextNode = node?.next // 특정 위치(인덱스) 노드
        node?.next = Node(data: data, next: nextNode) // 특정 위치(인덱스) 이전 노드에서 새로운 노드를 연결
    }
    
    // 특정 위치 노드 삭제
    func remove(at index: Int) {
        if head == nil { return } // 노드가 아예 없는 경우는 리턴
        
        // 0번 째 노드를 삭제하면, head를 변경
        if index == 0 {
            head = head?.next
            return
        }
        
        // 특정 위치(인덱스) 노드를 제거하기 위해서는
        // 특정 위치 이전 노드를 특정 위치(인덱스) 노드 다음에 연결된 노드로 연결해주기
        var node = head
        for _ in 0..<index-1 {
            node = node?.next
        }
        
        // 인덱스가 유효한지 판별
        if node?.next == nil {
            print("삭제하려는 위치가 너무 큽니다!")
            return
        }
        
        // 특정 위치(인덱스) 이전 노드를 다음 다음 노드와 연결
        node?.next = node?.next?.next
    }
    
    func removeLast() {
        // 노드가 없으면 리턴
        if head == nil { return }
        
        // head를 삭제하는 경우
        if head?.next == nil {
            head = nil
            return
        }
        
        // 다음 노드가 3개 이상일 경우, 헤드를 옮기기
        var node = head
        while node?.next?.next != nil {
            node = node?.next
        }
        
        // 다음 노드가 2개 이하일 경우, 마지막 노드를 nil로 처리
        node?.next = node?.next?.next
    }
    
    func searchNode(element value: T) -> Int? {
        if head == nil { return nil }
        
        var countIndex = 0
        var node = head
        while node != nil {
            if node?.data == value { return countIndex }
            countIndex += 1
            node = node?.next
        }

        return nil
    }
}

func printLinkedList(linkedList: LinkedList<Int>) {
    var node = linkedList.head
    while node != nil {
        print(node!.data)
        node = node?.next
    }
}

let linkedList = LinkedList<Int>()
linkedList.append(data: 10) // 10
linkedList.append(data: 20) // 10 20
linkedList.append(data: 30) // 10 20 30
linkedList.insert(data: 40, at: 0) // 40 10 20 30
linkedList.insert(data: 50, at: 3) // 40 10 20 50 30
linkedList.remove(at: 0) // 10 20 50 30
linkedList.removeLast() // 10 20 50
if let index = linkedList.searchNode(element: 20) {
    print(index) // 1
}
printLinkedList(linkedList: linkedList)