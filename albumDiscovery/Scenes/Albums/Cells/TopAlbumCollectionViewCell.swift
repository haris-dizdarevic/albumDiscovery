import UIKit

class TopAlbumCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var roundView: UIView! {
        didSet {
            roundView.layer.cornerRadius = 10
            roundView.backgroundColor = .green
        }
    }
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }

    // MARK: - Public methods
    func configureCell(with title: String, subtitle: String, stored: Bool, andImageUrl imageUrl: URL?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        roundView.isHidden = !stored

        if let imageUrl = imageUrl {
            imageView.af_setImage(withURL: imageUrl)
        }
    }

}
