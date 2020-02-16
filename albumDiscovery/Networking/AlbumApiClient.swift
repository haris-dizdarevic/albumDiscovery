typealias AlbumInfoCallback = ((_ album: AlbumWrapper?, _ error: ApiError?) -> Void)
class AlbumApiClient: ApiClient {
    func getInfo(for album: String, from artist: String, callback: @escaping AlbumInfoCallback) {
        callApi(
            using: .get,
            with: nil,
            for: "?method=album.getinfo&artist=\(artist)&album=\(album)",
            callback: callback
        )
    }
}
