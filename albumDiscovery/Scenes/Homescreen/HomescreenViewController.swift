import UIKit

class HomescreenViewController: AppViewController<HomescreenViewModel> {
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
        setupNavigation()
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
                subtitle: album.artistName,
                stored: true,
                andImageUrl: smallImageUrl
            )

            return cell
        }
    }

    private func setupNavigation() {
        title = "Album Discovery"
        let search = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchTapped)
        )
        navigationItem.rightBarButtonItem = search
    }

    @objc private func searchTapped() {
        viewModel.searchTapped()
    }
}


// MARK: - CollectionView delegates
extension HomescreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width, height: 80)
    }
}

extension HomescreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.albumTapped(on: indexPath)
    }
}
