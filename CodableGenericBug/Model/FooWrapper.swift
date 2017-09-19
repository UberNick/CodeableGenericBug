import Foundation

struct FooWrapper<S: Codable>: Codable {
    struct GenericWrapperData<T: Codable>: Codable {
        let type: String
        let attributes: Foo
    }
    let data: GenericWrapperData<S>
}
