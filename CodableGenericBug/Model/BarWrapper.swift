import Foundation

struct BarWrapper<T: Codable>: Codable {
    struct GenericWrapperData: Codable {
        let type: String
        let attributes: Bar
    }
    let data: GenericWrapperData
}

