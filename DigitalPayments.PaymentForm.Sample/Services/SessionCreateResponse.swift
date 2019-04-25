import Foundation

public class SessionCreateResponse : Codable {
    var isSuccessful: Bool? = false
    var sessionKey: String? = ""
    var portalOneSessionKey: String? = ""
    var errorDescription: String? = ""
    var responseCode: String? = ""
    var responseMessage: String? = ""
    
    init() {
        
    }
    
    init(errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
