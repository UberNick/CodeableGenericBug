import Foundation

struct WorkingGenericWrapper<S: Codable>: Codable {
    
    let data: GenericWrapperData<S>
}

struct GenericWrapperData<T: Codable>: Codable {
    let type: String
    let attributes: T
}

