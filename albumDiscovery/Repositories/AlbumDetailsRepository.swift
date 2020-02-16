class AlbumDetailsRepository {
    // MARK: - Properties
    private let apiClient: AlbumApiClient
    private let albumDAO: AlbumDAO
    private let albumMapper: AlbumMapper

    // MARK: - Initialization
    init(
        apiClient: AlbumApiClient = AlbumApiClient(),
        albumDAO: AlbumDAO = AlbumDAO(),
        albumMapper: AlbumMapper = AlbumMapper()
    ) {
        self.apiClient = apiClient
        self.albumDAO = albumDAO
        self.albumMapper = albumMapper
    }

    // MARK: - Public methods
    func storeAlbum(album: Album) -> Bool {
        if let dbAlbum = albumMapper.toDatabase(apiModel: album) {
            albumDAO.insert(object: dbAlbum)
            return true
        }
        return false
    }

    func deleteAlbum(album: Album) -> Bool {
        if let dbAlbum = albumDAO.load(forPrimaryKey: album.name) {
            albumDAO.delete(object: dbAlbum)
            return true
        }
        return false
    }

    func getAlbumDetails(album: Album, callback: @escaping AlbumInfoCallback) {
        apiClient.getInfo(for: album.name, from: album.artist.name, callback: callback)
    }
}
