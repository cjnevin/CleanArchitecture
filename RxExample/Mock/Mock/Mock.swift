import Foundation
import XCTest

public enum MockError: Error {
    case error
}

public class Mock<T> {
    public enum Count {
        case toBeZero
        case toBeOne
        case toBe(Int)
        
        internal var value: Int {
            switch self {
            case .toBeZero: return 0
            case .toBeOne: return 1
            case let .toBe(n): return n
            }
        }
    }
    
    public private(set) var value: T
    private var executionCount: Int = 0
    
    public init(_ initialValue: T) {
        value = initialValue
    }
    
    public func set(_ value: T) {
        self.value = value
    }
    
    public func execute() -> T {
        executionCount += 1
        return value
    }
    
    public func expect(count: Count, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(executionCount, count.value, file: file, line: line)
    }
}

