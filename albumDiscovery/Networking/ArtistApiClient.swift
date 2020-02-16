typealias ArtistSearchCallback = (_ data: ArtistsSearchResult?, _ error: ApiError?) -> Void
typealias TopAlbumsCallback = (_ data: TopAlbums?, _ error: ApiError?) -> Void

class ArtistApiClient: ApiClient {
    func searchArtistBy(name: String, callback: @escaping ArtistSearchCallback) {
        callApi(
            using: .get,
            with: nil,
            for: "?method=artist.search&artist=\(name)",
            callback: callback
        )
    }

    func albums(for artist: String, callback: @escaping TopAlbumsCallback) {
        callApi(
            using: .get,
            with: nil,
            for: "?method=artist.gettopalbums&artist=\(artist)",
            callback: callback
        )
    }
}
