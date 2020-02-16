import RealmSwift

class DBTrack: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var duration: String = ""

    init(name: String, url: String, duration: String) {
        self.name = name
        self.url = url
        self.duration = duration
    }

    required init() {}
}

class DBTracks: Object {
    dynamic var tracks: List<DBTrack> = List<DBTrack>()

    init(tracks: List<DBTrack>) {
        self.tracks = tracks
    }

    required init() {}
}
