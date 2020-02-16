import Alamofire

class ApiClient {
    static let sessionManager: SessionManager = {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Content-Type"] = "application/json"
        defaultHeaders["Accept"] = "application/json"

        // Move to xconfig
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.timeoutIntervalForRequest = 15

        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        let adapter = AuthHandler()
        sessionManager.adapter = adapter
        return sessionManager
    }()

    func buildUrl(_ path: String) -> String {
        let url = "https://ws.audioscrobbler.com/2.0/" + path
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }

    func callApi<ApiModel: Codable>(
        using method: HTTPMethod,
        with parameters: [String: Any]?,
        for path: String,
        callback: @escaping (_ data: ApiModel?, _ error: ApiError?) -> Void
    ) {
        ApiClient.sessionManager.request(
            buildUrl(path),
            method: method,
            parameters: parameters
        ).validate().responseData { (response) in
            guard let data = response.data else {
                callback(nil, ApiError.fromDataResponse(response: response))
                return
            }

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(ApiModel.self, from: data)
                callback(value, nil)
            } catch let error {
                print(error)
            }
        }
    }

}
