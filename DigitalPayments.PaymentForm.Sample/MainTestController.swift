import UIKit
import UserNotifications

class MainTestController: UIViewController {
    
    fileprivate func setDefaultSettingsIfNeeded() {
        let genericModalUrl = UserDefaults.standard.string(forKey: "genericModalUrl")
        if (genericModalUrl?.isEmpty != false) {
            UserDefaults.standard.set("http://localhost", forKey: "genericModalUrl")
        }
        
        let genericModalSessionUrl = UserDefaults.standard.string(forKey: "genericModalSessionUrl")
        if (genericModalSessionUrl?.isEmpty != false) {
            UserDefaults.standard.set("http://localhost/DigitalPaymentsBackendSample/api/Session/Create", forKey: "genericModalSessionUrl")
        }
        
        let portaloneApiSessionUrl = UserDefaults.standard.string(forKey: "portaloneApiSessionUrl")
        if (portaloneApiSessionUrl?.isEmpty != false) {
            UserDefaults.standard.set("http://localhost/DigitalPaymentsBackendSample/api/PortalOneApiSession/Create", forKey: "portaloneApiSessionUrl")
        }
        
        let portaloneApiUrl = UserDefaults.standard.string(forKey: "portaloneApiUrl")
        if (portaloneApiUrl?.isEmpty != false) {
            UserDefaults.standard.set("http://localhost/PortalOneApi", forKey: "portaloneApiUrl")
        }
        
        let baseHost = UserDefaults.standard.string(forKey: "baseHost")
        if (baseHost?.isEmpty != false) {
            UserDefaults.standard.set("http://localhost", forKey: "baseHost")
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
