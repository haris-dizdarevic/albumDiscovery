import RealmSwift

class DBAlbum: Object {
    @objc dynamic var mbid: String?
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var artist: DBArtist?
    @objc dynamic var smallImageUrl: String?
    @objc dynamic var largeImageUrl: String?
    @objc dynamic var tracks: DBTracks?

    var artistName: String? {
        return artist?.name
    }

    override class func primaryKey() -> String? {
        return "name"
    }

    init(
        mbid: String?,
        name: String,
        url: String,
        artist: DBArtist?,
        smallImageUrl: String?,
        largeImageUrl: String?,
        tracks: DBTracks
    ) {
        self.mbid = mbid
        self.name = name
        self.url = url
        self.artist = artist
        self.smallImageUrl = smallImageUrl
        self.largeImageUrl = largeImageUrl
        self.tracks = tracks
    }

    required init() {}
}
