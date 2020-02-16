class ArtistMapper: ModelMapper<Artist, DBArtist> {
    override func toDatabase(apiModel: Artist) -> DBArtist? {
        return DBArtist(
            mbid: apiModel.mbid,
            name: apiModel.name,
            url: apiModel.url,
            listeners: apiModel.listeners
        )
    }

    override func toApi(dbModel: DBArtist) -> Artist? {
        return Artist(
            mbid: dbModel.mbid,
            name: dbModel.name,
            url: dbModel.url,
            listeners: dbModel.listeners
        )
    }
}
