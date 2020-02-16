import Alamofire

class AuthHandler: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let params: Parameters = ["api_key": "51485e5216a594db2641ad8c089da008", "format": "json"]
        return try URLEncoding.default.encode(urlRequest, with: params)
    }
}
