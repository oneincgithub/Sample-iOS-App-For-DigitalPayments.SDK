import UIKit

class MainTestController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genericModalUrl = UserDefaults.standard.string(forKey: "genericModalUrl")
        if (genericModalUrl == nil || genericModalUrl == "") {
            UserDefaults.standard.set("http://localhost", forKey: "genericModalUrl")
        }
        
        let sessionServiceUrl = UserDefaults.standard.string(forKey: "sessionUrl")
        if (sessionServiceUrl == nil || sessionServiceUrl == "") {
            UserDefaults.standard.set("http://localhost/DigitalPaymentsBackendSample/api/Session/Create", forKey: "sessionUrl")
        }
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
