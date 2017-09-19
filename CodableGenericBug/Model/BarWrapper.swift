import Foundation

struct BarWrapper<S: Codable>: Codable {
    struct GenericWrapperData<T: Codable>: Codable {
        let type: String
        let attributes: Bar
    }
    let data: GenericWrapperData<S>
}

