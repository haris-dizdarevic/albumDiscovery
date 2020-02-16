import UIKit

class AlbumDetailsViewController: AppViewController<AlbumDetailsViewModel> {
    // MARK: - Outletss
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Album Details"
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.saveButtonIsEnabled.bind(to: saveButton.reactive.isEnabled)
        viewModel.deleteButtonIsEnabled.bind(to: deleteButton.reactive.isEnabled)
        viewModel.album.observeNext { [weak self] album in
            guard let url = URL(string: album.largeIMageUrl ?? "") else { return }
            self?.headerImageView.af_setImage(withURL: url)
            self?.albumNameLabel.text = album.name
            self?.artistNameLabel.text = album.artistName
        }.dispose(in: bag)

        viewModel.databaseErrorMessage.observeNext { [weak self] message in
            guard let message = message else { return }
            self?.showAlert(with: message)
        }.dispose(in: bag)

        saveButton.reactive.tap.observeNext { [weak self] in
            self?.viewModel.saveTapped()
        }.dispose(in: bag)

        deleteButton.reactive.tap.observeNext { [weak self] in
            self?.viewModel.deleteTapped()
        }.dispose(in: bag)

        bindCollectionView()
    }

    // MARK: - Private methods
    private func bindCollectionView() {
        viewModel.tracks.bind(to: collectionView) { array, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ArtistCollectionViewCell.identifier,
                for: indexPath
            ) as! ArtistCollectionViewCell
            let track = array[indexPath.item]

            cell.setupCell(with: track.name, andSubtitle: track.url)

            return cell
        }
    }

    private func setupCollectionView() {
        collectionView.registerCellFromNib(with: ArtistCollectionViewCell.identifier)
        collectionView.delegate = self
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width, height: 80)
    }
}
