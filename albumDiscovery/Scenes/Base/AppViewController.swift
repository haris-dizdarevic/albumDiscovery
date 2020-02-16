import UIKit
import ReactiveKit

class AppViewController<ViewModel: AppViewModel>: UIViewController {
    var viewModel: ViewModel!
    var loadingFrame: CGRect {
        return view.frame
    }

    // MARK: VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    // MARK: - Public methods
    func bindViewModel() {
        viewModel.error.observeNext { [weak self] error in
            self?.showError(error: error)
        }.dispose(in: bag)

        viewModel.isLoading.observeNext { [weak self] isLoading in
            if isLoading {
                LoadingOverlay.shared.showOverlay(frame: self?.loadingFrame)
                return
            }
            LoadingOverlay.shared.hideOverlayView()
        }.dispose(in: bag)
    }

    func showError(error: AppError?) {
        guard let error = error else {
            return
        }
        showAlert(with: error.message)
    }

    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
