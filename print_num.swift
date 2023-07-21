import Foundation

struct Accumulator {
    static var shared = Accumulator(initialValue: 1)
    var values: [Int32]
    private init(initialValue: Int32) {
        values = [initialValue]
    }

    mutating func add_all(_ numbers: [Int32]) {
        values.append(contentsOf: numbers)
    }

    mutating func add(_ n: Int32) {
        values.append(n)
    }

    var value: Int32 {
        values.reduce(0, +)
    }
}

@_cdecl("print_num")
public func print_num() {
    print("shared value is: \(Accumulator.shared.value)")
}
@_cdecl("print_values")
public func print_values() {
    print("shared values are:\n\(Accumulator.shared.values)")
}

@_cdecl("add_num")
public func add_num(_ n: Int32) {
    Accumulator.shared.add(n)
}

@_cdecl("add_nums")
public func add_nums(_ n: UnsafePointer<Int32>) {
    let numbers = Array(UnsafeBufferPointer(start: n, count: 3))
    Accumulator.shared.add_all(numbers)
}