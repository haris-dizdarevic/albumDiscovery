import ReactiveKit

class AlbumDetailsViewModel: AppViewModel {
    // MARK: - Properties
    let album: Property<Album>
    let tracks: Property<[Track]>
    let saveButtonIsEnabled = Property<Bool>(true)
    let deleteButtonIsEnabled = Property<Bool>(false)
    let databaseErrorMessage = Property<String?>(nil)

    let repository: AlbumDetailsRepository

    // MARK: - Initialization
    init(repository: AlbumDetailsRepository = AlbumDetailsRepository(), album: Album) {
        self.repository = repository
        self.album = Property<Album>(album)
        self.tracks = Property<[Track]>(album.tracks ?? [])
        super.init()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        let albumStored = album.value.stored!
        saveButtonIsEnabled.value = !albumStored
        deleteButtonIsEnabled.value = albumStored

        repository.getAlbumDetails(album: album.value, callback: { [weak self] data, error in
            self?.albumInfoCallback(data, error)
        })
    }

    // MARK: - Public methods
    func saveTapped() {
        if repository.storeAlbum(album: album.value) {
            changeButtonsState(to: true)
        } else {
            databaseErrorMessage.value = "Something went wrong while saving \(album.value.name)"
        }
    }

    func deleteTapped() {
        if repository.deleteAlbum(album: album.value) {
            changeButtonsState(to: false)
        } else {
            databaseErrorMessage.value = "Something went wrong while deleting \(album.value.name)"
        }
    }

    // MARK: - Private methods
    private func albumInfoCallback(_ data: AlbumWrapper?, _ error: ApiError?) {
        if let album = data?.album, let tracks = album.tracks {
            self.album.value.tracks = tracks.track
            self.tracks.value = tracks.track
            return
        }
        if let error = error {
            defaultErrorHandler(error)
        }
    }

    private func changeButtonsState(to isEnabled: Bool) {
        saveButtonIsEnabled.value = !isEnabled
        deleteButtonIsEnabled.value = isEnabled
    }
}
