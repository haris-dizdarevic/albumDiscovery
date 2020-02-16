import ReactiveKit

class HomescreenViewModel: AppViewModel {
    let navigator: AppNavigator
    let repository: AlbumRepository
    let albums = Property<[Album]>([])

    init(navigator: AppNavigator, repository: AlbumRepository = AlbumRepository()) {
        self.navigator = navigator
        self.repository = repository
    }

    override func viewWillAppear() {
        albums.value = repository.storedAlbums
    }

    func albumTapped(on indexPath: IndexPath) {
        let album = albums.value[indexPath.row]
        navigator.goToAlbumDetails(with: album)
    }

    func searchTapped() {
        navigator.goToSearch()
    }
}
