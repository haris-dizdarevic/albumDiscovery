struct Image: Codable {
    var url: String
    var size: String

    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
}

struct Images: Codable {
    var image: [Image]
}
