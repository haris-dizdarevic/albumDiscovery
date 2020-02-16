import ReactiveKit

class SearchViewModel: AppViewModel {
    // MARK: - Properties
    let artists = Property<[Artist]>([])
    let apiClient: ArtistApiClient
    let navigator: AppNavigator

    var searchText = ""

    // MARK: - Initialization
    init(apiClient: ArtistApiClient = ArtistApiClient(), navigator: AppNavigator) {
        self.apiClient = apiClient
        self.navigator = navigator
        super.init()
    }

    //MARK: - Public methods
    func artistTapped(on indexPath: IndexPath) {
        let artist = artists.value[indexPath.row]
        navigator.goToAlbums(with: artist.name)
    }

    func searchTapped() {
        guard searchText.count >= 3 else { return }
        isLoading(true)
        apiClient.searchArtistBy(name: searchText) { [weak self] artists, error in
            self?.onSearchArtistBy(artists, error)
        }
    }

    // MARK: Private methods
    func onSearchArtistBy(_ data: ArtistsSearchResult?, _ error: ApiError?) {
        isLoading(false)
        if let error = error {
            defaultErrorHandler(error)
            return
        }

        if let data = data {
            self.artists.value = data.artists
        }
    }
}
