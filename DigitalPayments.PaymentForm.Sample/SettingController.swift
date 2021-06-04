import Foundation
import UIKit

class SettingController : UIViewController{
    
    @IBOutlet weak var genericModalSessionUrl: UITextField!
    @IBOutlet weak var genericModalUrl: UITextField!
    @IBOutlet weak var portaloneApiSessionUrl: UITextField!
    @IBOutlet weak var portaloneApiUrl: UITextField!
    
    @IBOutlet weak var getConfigurationUrl: UITextField!
    @IBAction func onHostApplyButtonClick(_ sender: Any) {
        let baseUrl = getConfigurationUrl.text!
        
        let configurationService = ConfigurationService(url: baseUrl)
        configurationService.getConfiguration() {(result: ConfigurationResponse) -> Void in
            DispatchQueue.main.async {
                self.genericModalSessionUrl.text = baseUrl + result.webViewRelativeSessionUrl!
                self.genericModalUrl.text = result.webViewAppUrl!
                self.portaloneApiSessionUrl.text = baseUrl + result.nativeViewRelativeSessionUrl!
                self.portaloneApiUrl.text = result.nativeViewAppUrl!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        getConfigurationUrl.text = UserDefaults.standard.string(forKey: "getConfigurationUrl")
        genericModalSessionUrl.text = UserDefaults.standard.string(forKey: "genericModalSessionUrl")
        genericModalUrl.text = UserDefaults.standard.string(forKey: "genericModalUrl")
        portaloneApiSessionUrl.text = UserDefaults.standard.string(forKey: "portaloneApiSessionUrl")
        portaloneApiUrl.text = UserDefaults.standard.string(forKey: "portaloneApiUrl")
        
        addToolBar(textField: getConfigurationUrl)        
        addToolBar(textField: genericModalSessionUrl)
        addToolBar(textField: genericModalUrl)
        addToolBar(textField: portaloneApiSessionUrl)
        addToolBar(textField: portaloneApiUrl)
    }
    
    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        UserDefaults.standard.set(getConfigurationUrl.text, forKey: "getConfigurationUrl")
        
        UserDefaults.standard.set(genericModalSessionUrl.text, forKey: "genericModalSessionUrl")
        UserDefaults.standard.set(genericModalUrl.text, forKey: "genericModalUrl")
        UserDefaults.standard.set(portaloneApiSessionUrl.text, forKey: "portaloneApiSessionUrl")
        UserDefaults.standard.set(portaloneApiUrl.text, forKey: "portaloneApiUrl")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onResetButtonClick(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "getConfigurationUrl")
        UserDefaults.standard.set(nil, forKey: "genericModalSessionUrl")
        UserDefaults.standard.set(nil, forKey: "genericModalUrl")
        UserDefaults.standard.set(nil, forKey: "portaloneApiSessionUrl")
        UserDefaults.standard.set(nil, forKey: "portaloneApiUrl")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
