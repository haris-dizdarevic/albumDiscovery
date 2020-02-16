import RealmSwift

class AlbumMapper: ModelMapper<Album, DBAlbum> {
    override func toDatabase(apiModel: Album) -> DBAlbum? {
        let dbTracks = List<DBTrack>()

        apiModel.tracks?.forEach { track in
            dbTracks.append(DBTrack(name: track.name, url: track.url, duration: track.duration))
        }
        let tracks = DBTracks(tracks: dbTracks)

        return DBAlbum(
            mbid: apiModel.mbid,
            name: apiModel.name,
            url: apiModel.url,
            artist: ArtistMapper().toDatabase(apiModel: apiModel.artist),
            smallImageUrl: apiModel.smallImageUrl,
            largeImageUrl: apiModel.largeIMageUrl,
            tracks: tracks
        )
    }

    override func toApi(dbModel: DBAlbum) -> Album? {
        guard let dbAtist = dbModel.artist else { return nil }
        let artist = ArtistMapper().toApi(dbModel: dbAtist)
        let images = [
            Image(url: dbModel.largeImageUrl ?? "", size: "large"),
            Image(url: dbModel.smallImageUrl ?? "", size: "small")
        ]
        let tracks = dbModel.tracks?.tracks
        var arrayTrack: [Track] = []
        if let tracks = tracks {
            let tmp = Array(tracks)
            arrayTrack = TrackMapper().toApiArray(dbModels: tmp)
        }
        return Album(
            mbid: dbModel.mbid,
            name: dbModel.name,
            url: dbModel.url,
            artist: artist!,
            image: images,
            tracks: arrayTrack,
            stored: true
        )
    }
}
