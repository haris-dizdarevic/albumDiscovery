import ReactiveKit

class AppViewModel {
    // MARK: - Properties
    let isLoading = Property<Bool>(false)
    let error = Property<AppError?>(nil)

    let disposeBag = DisposeBag()

    // MARK: - Initialization
    init() {}

    // MARK: - Public methods
    func isLoading(_ isLoading: Bool) {
        self.isLoading.value = isLoading
    }

    func defaultErrorHandler(_ error: AppError) {
        self.error.value = error
    }

    func viewDidLoad() {}

    func viewWillAppear() {}
}
