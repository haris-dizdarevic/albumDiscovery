import RealmSwift

class DBArtist: Object {
    @objc dynamic var mbid: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var listeners: String?

    init(mbid: String, name: String, url: String, listeners: String?) {
        self.mbid = mbid
        self.name = name
        self.url = url
        self.listeners = listeners
    }

    required init() {}
}
