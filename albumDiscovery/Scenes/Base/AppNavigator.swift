import UIKit

class AppNavigator {
    // MARK: - Properties
    private weak var navigationController: UINavigationController?

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public methods
    func goToHomescreen() {
        let vc = HomescreenViewController.instantiateFromAppStoryboard(appStoryboard: .home)
        vc.viewModel = HomescreenViewModel(navigator: self)
        navigationController?.pushViewController(vc, animated: true)
    }

    func goToSearch() {
        let vc = SearchViewController.instantiateFromAppStoryboard(appStoryboard: .home)
        vc.viewModel = SearchViewModel(navigator: self)
        navigationController?.pushViewController(vc, animated: true)
    }

    func goToAlbums(with artistName: String) {
        let vc = AlbumsViewController.instantiateFromAppStoryboard(appStoryboard: .home)
        vc.viewModel = AlbumsViewModel(repository: AlbumRepository(), navigator: self, artistName: artistName)
        navigationController?.pushViewController(vc, animated: true)
    }

    func goToAlbumDetails(with album: Album) {
        let vc = AlbumDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .home)
        vc.viewModel = AlbumDetailsViewModel(album: album)
        navigationController?.pushViewController(vc, animated: true)
    }
}
