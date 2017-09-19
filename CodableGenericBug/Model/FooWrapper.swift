import Foundation

struct FooWrapper<T: Codable>: Codable {
    struct GenericWrapperData: Codable {
        let type: String
        let attributes: Foo
    }
    let data: GenericWrapperData
}
