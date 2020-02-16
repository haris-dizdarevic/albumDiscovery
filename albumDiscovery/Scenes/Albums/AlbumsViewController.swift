import UIKit

class AlbumsViewController: AppViewController<AlbumsViewModel> {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func bindViewModel() {
        super.bindViewModel()
        bindCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Albums"
    }

    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.registerCellFromNib(with: TopAlbumCollectionViewCell.identifier)
        collectionView.delegate = self
    }

    private func bindCollectionView() {
        viewModel.albums.bind(to: collectionView) { array, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopAlbumCollectionViewCell.identifier,
                for: indexPath
            ) as! TopAlbumCollectionViewCell
            let album = array[indexPath.item]

            let smallImageUrl = URL(string: album.smallImageUrl ?? "")
            cell.configureCell(
                with: album.name,
                subtitle: album.artist.name,
                stored: album.stored!,
                andImageUrl: smallImageUrl
            )

            return cell
        }
    }
}


// MARK: - CollectionView delegates
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width, height: 80)
    }
}

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.albumTapped(on: indexPath)
    }
}
