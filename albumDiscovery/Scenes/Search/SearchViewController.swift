import UIKit
import Bond

class SearchViewController: AppViewController<SearchViewModel> {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties
    override var loadingFrame: CGRect {
        return collectionView.frame
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Search"
    }

    override func bindViewModel() {
        super.bindViewModel()
        bindCollectionView()
    }

    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.registerCellFromNib(with: ArtistCollectionViewCell.identifier)
        collectionView.delegate = self
    }

    private func bindCollectionView() {
        viewModel.artists.bind(to: collectionView) { array, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ArtistCollectionViewCell.identifier,
                for: indexPath
            ) as! ArtistCollectionViewCell
            let artist = array[indexPath.item]

            cell.setupCell(with: artist.name, andSubtitle: artist.url)

            return cell
        }
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }
}

// MARK: - Collection view delegates
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width, height: 64)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.artistTapped(on: indexPath)
    }
}

// MARK: - Search bar delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchTapped()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
