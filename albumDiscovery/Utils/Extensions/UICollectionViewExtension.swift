import UIKit

extension UICollectionView {
    func registerCellFromNib(with identifier: String) {
        let cell = UINib(nibName: identifier, bundle: nil)
        register(cell, forCellWithReuseIdentifier: identifier)
    }
}
