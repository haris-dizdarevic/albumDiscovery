class AlbumRepository {
    // MARK: - Properties
    private let albumDAO: AlbumDAO
    private let apiClient: ArtistApiClient
    private let albumMapper: AlbumMapper
    private var albums: [Album] = []
    
    var storedAlbums: [Album] {
        let dbAlbums = Array(albumDAO.loadAll())
        return albumMapper.toApiArray(dbModels: dbAlbums)
    }

    var albumsCallback: ((_ albums: [Album]?, _ error: ApiError?) -> Void)?

    // MARK: - Initialization
    init(
        albumDAO: AlbumDAO = AlbumDAO(),
        apiClient: ArtistApiClient = ArtistApiClient(),
        albumMapper: AlbumMapper = AlbumMapper()
    ) {
        self.albumDAO = albumDAO
        self.apiClient = apiClient
        self.albumMapper = albumMapper
    }

    // MARK: - Public methods
    func fetchTopAlbums(for artist: String) {
        apiClient.albums(for: artist, callback: topAlbumsCallback)
    }

    //MARK: - Private methods
    private func topAlbumsCallback(_ data: TopAlbums?, _ error: ApiError?) {
        if let data = data?.topalbums {
            albums = data.albums
            let names = storedAlbums.map { $0.name }
            for index in 0..<albums.count {
                if names.contains(albums[index].name) {
                    albums[index].stored = true
                }
            }

            albumsCallback?(albums, error)
            return
        }
        albumsCallback?(nil, error)
    }
}
