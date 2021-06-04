import Foundation

class ConfigurationService {
    
    private let configurationUrl: String
    
    init(url configurationUrl: String) {
        self.configurationUrl = configurationUrl
    }
    
    public func getConfiguration(onCompleteHandler: @escaping (_ response: ConfigurationResponse) -> Void) {
        let url = URL(string: configurationUrl)!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else {
                onCompleteHandler(ConfigurationResponse())
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                onCompleteHandler(ConfigurationResponse())
            }
            
            do {
                let result = try JSONDecoder().decode(ConfigurationResponse.self, from: data)
                onCompleteHandler(result)
            } catch _ {
                onCompleteHandler(ConfigurationResponse())
            }
            }.resume()
    }
}
