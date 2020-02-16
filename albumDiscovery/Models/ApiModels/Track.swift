struct Track: Codable {
    var name: String
    var url: String
    var duration: String
}

struct Tracks: Codable {
    var track: [Track]
}
