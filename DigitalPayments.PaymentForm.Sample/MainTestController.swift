import UIKit
import UserNotifications

class MainTestController: UIViewController {
    
    fileprivate func setDefaultSettingsIfNeeded() {
        let genericModalUrl = UserDefaults.standard.string(forKey: "genericModalUrl")
        if (genericModalUrl?.isEmpty != false) {
            UserDefaults.standard.set("https://localhost", forKey: "genericModalUrl")
        }
        
        let genericModalSessionUrl = UserDefaults.standard.string(forKey: "genericModalSessionUrl")
        if (genericModalSessionUrl?.isEmpty != false) {
            UserDefaults.standard.set("https://localhost/MobileSDKBackendSample/api/WebViewSession/Create", forKey: "genericModalSessionUrl")
        }
        
        let portaloneApiSessionUrl = UserDefaults.standard.string(forKey: "portaloneApiSessionUrl")
        if (portaloneApiSessionUrl?.isEmpty != false) {
            UserDefaults.standard.set("https://localhost/MobileSDKBackendSample/api/NativeViewSession/Create", forKey: "portaloneApiSessionUrl")
        }
        
        let portaloneApiUrl = UserDefaults.standard.string(forKey: "portaloneApiUrl")
        if (portaloneApiUrl?.isEmpty != false) {
            UserDefaults.standard.set("https://localhost/PortalOneApi", forKey: "portaloneApiUrl")
        }
        
        let getConfigurationUrl = UserDefaults.standard.string(forKey: "getConfigurationUrl")
        if (getConfigurationUrl?.isEmpty != false) {
            UserDefaults.standard.set("https://localhost/MobileSDKBackendSample", forKey: "getConfigurationUrl")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDefaultSettingsIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSavePaymentMethodButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSavePaymentMethodPage", sender:self);
    }
    
    @IBAction func onMakePaymentButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowMakePaymentPage", sender:self);
    }
    
    @IBAction func onSettingButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSettingsPage", sender: self);
    }
}
