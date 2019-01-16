import Foundation

public class SessionCreateResponse : Codable {
    var isSuccessful: Bool = false
    var sessionKey: String = ""
    var errorDescription: String?
    
    init(errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
