import Foundation

struct WorkingGenericWrapper<S: Codable>: Codable {
    struct GenericWrapperData<T: Codable>: Codable {
        let type: String
        let attributes: T
    }
    let data: GenericWrapperData<S>
}


