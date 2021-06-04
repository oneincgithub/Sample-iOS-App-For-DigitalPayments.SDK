import Foundation

public class ConfigurationResponse : Codable {
    var webViewRelativeSessionUrl: String? = ""
    var webViewAppUrl: String? = ""
    var nativeViewRelativeSessionUrl: String? = ""
    var nativeViewAppUrl: String? = ""
    
    init() {        
    }
}
