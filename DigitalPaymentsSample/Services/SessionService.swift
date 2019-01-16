import Foundation

class SessionService {
    
    private let sessionUrl: String
    
    init(url sessionUrl: String) {
        self.sessionUrl = sessionUrl
    }
    
    public func generateSessionId(onCompleteHandler: @escaping (_ response: SessionCreateResponse) -> Void) {
        let url = URL(string: sessionUrl)!
        var request = URLRequest(url: url)
        request.httpMethod="GET"
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                let result = SessionCreateResponse(errorDescription: String(describing: error))
                DispatchQueue.main.async {
                    onCompleteHandler(result)
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let result = SessionCreateResponse(errorDescription: "statusCode should be 200, but is \(httpStatus.statusCode)")
                DispatchQueue.main.async {
                    onCompleteHandler(result)
                }
            }
            
            do {
                let result = try JSONDecoder().decode(SessionCreateResponse.self, from: data)
                DispatchQueue.main.async {
                    onCompleteHandler(result)
                }
            } catch let error {
                let result = SessionCreateResponse(errorDescription: error.localizedDescription)
                DispatchQueue.main.async {
                    onCompleteHandler(result)
                }
            }
        }.resume()
    }
}
