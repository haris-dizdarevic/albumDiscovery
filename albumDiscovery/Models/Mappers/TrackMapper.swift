class TrackMapper: ModelMapper<Track, DBTrack> {
    override func toApi(dbModel: DBTrack) -> Track? {
        return Track(name: dbModel.name, url: dbModel.url, duration: dbModel.duration)
    }

    override func toDatabase(apiModel: Track) -> DBTrack? {
        return DBTrack(name: apiModel.name, url: apiModel.url, duration: apiModel.duration)
    }
}
