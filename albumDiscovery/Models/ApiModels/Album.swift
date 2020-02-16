struct Album: Codable {
    var mbid: String?
    var name: String
    var url: String
    var artist: Artist
    var image: [Image]?
    var tracks: [Track]?
    var stored: Bool? = false

    enum CodingKeys: String, CodingKey {
        case mbid, name, url, artist, image, tracks
    }

    var artistName: String {
        return artist.name
    }

    var smallImageUrl: String? {
        let smallImage = image?.first(where: { (image) -> Bool in
            image.size == "small"
        })

        return smallImage?.url
    }

    var largeIMageUrl: String? {
        let largeImage = image?.first(where: { (image) -> Bool in
            image.size == "large"
        })

        return largeImage?.url
    }
}

struct AlbumWrapper: Codable {
    var album: AlbumInfo
}

struct AlbumInfo: Codable {
    var name: String
    var url: String
    var artist: String
    var image: [Image]?
    var tracks: Tracks?
}
