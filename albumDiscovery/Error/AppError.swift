import Alamofire

class AppError: Error {
    let code: Int
    let message: String

    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

class ApiError: AppError {

    /// The URL request sent to the server.
    let request: URLRequest?

    /// The server's response to the URL request.
    let response: HTTPURLResponse?

    /// The data returned by the server.
    let data: Data?

    /// Returns the associated error
    var error: Error?

    init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?
    ) {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        super.init(code: 1, message: "Network error!")
    }

    init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?,
        errorMessage: String
    ) {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        super.init(code: 1, message: errorMessage)
    }

    static func fromDataResponse<T>(response: DataResponse<T>) -> ApiError? {
        if response.result.isFailure {
            return ApiError(request: response.request,
                            response: response.response,
                            data: response.data,
                            error: response.error)
        }
        return nil
    }

}
