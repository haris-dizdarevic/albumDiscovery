import ReactiveKit

class AlbumsViewModel: AppViewModel {
    // MARK: - Properties
    let albums = Property<[Album]>([])
    let repository: AlbumRepository
    let navigator: AppNavigator
    let artistName: String

    // MARK: - Initialization
    init(repository: AlbumRepository, navigator: AppNavigator, artistName: String) {
        self.repository = repository
        self.navigator = navigator
        self.artistName = artistName
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading(true)
        repository.albumsCallback = { [weak self] albums, error in
            self?.albumsCallback(albums, error)
        }
        repository.fetchTopAlbums(for: artistName)
    }

    // MARK: - Public methods
    func albumTapped(on indexPath: IndexPath) {
        let album = albums.value[indexPath.row]
        navigator.goToAlbumDetails(with: album)
    }

    // MARK: - Private methods
    private func albumsCallback(_ data: [Album]?, _ error: ApiError?) {
        isLoading(false)
        if let data = data {
            albums.value = data
            return
        }
        if let error = error {
            defaultErrorHandler(error)
        }
    }
}
