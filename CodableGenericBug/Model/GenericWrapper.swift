import Foundation

struct GenericWrapper<T: Codable>: Codable {
    struct GenericWrapperData: Codable {
        let type: String
        let attributes: T
    }
    let data: GenericWrapperData
}
