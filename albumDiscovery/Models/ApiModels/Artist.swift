struct Artist: Codable {
    var mbid: String
    var name: String
    var url: String
    var listeners: String?
    var image: [Image]?

    var smallImageUrl: String? {
        let smallImage = image?.first(where: { (image) -> Bool in
            image.size == "large"
        })

        return smallImage?.url
    }
}

struct ArtistsSearchResult: Codable {
    var results: ArtistResult
    var artists: [Artist] {
        return results.artistmatches.artist
    }
}

struct ArtistResult: Codable {
    var artistmatches: ArtistMatches
}

struct ArtistMatches: Codable {
    var artist: [Artist]
}

struct TopAlbums: Codable {
    var topalbums: Albums
}

struct Albums: Codable {
    var albums: [Album]

    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}
