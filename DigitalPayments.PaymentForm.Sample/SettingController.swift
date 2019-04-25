import Foundation
import UIKit

class SettingController : UIViewController{
    
    @IBOutlet weak var genericModalSessionUrl: UITextField!
    @IBOutlet weak var genericModalUrl: UITextField!
    @IBOutlet weak var portaloneApiSessionUrl: UITextField!
    @IBOutlet weak var portaloneApiUrl: UITextField!
    
    @IBOutlet weak var baseHost: UITextField!
    @IBAction func onHostApplyButtonClick(_ sender: Any) {
        let baseUrl = URL(string: baseHost.text!)
        
        genericModalSessionUrl.text = baseUrl?.appendingPathComponent(URL(string: genericModalSessionUrl.text!)!.path).absoluteString
        genericModalUrl.text = baseUrl?.appendingPathComponent(URL(string: genericModalUrl.text!)!.path).absoluteString
        portaloneApiSessionUrl.text = baseUrl?.appendingPathComponent(URL(string: portaloneApiSessionUrl.text!)!.path).absoluteString
        portaloneApiUrl.text = baseUrl?.appendingPathComponent(URL(string: portaloneApiUrl.text!)!.path).absoluteString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        baseHost.text = UserDefaults.standard.string(forKey: "baseHost")
        
        genericModalSessionUrl.text = UserDefaults.standard.string(forKey: "genericModalSessionUrl")
        genericModalUrl.text = UserDefaults.standard.string(forKey: "genericModalUrl")
        portaloneApiSessionUrl.text = UserDefaults.standard.string(forKey: "portaloneApiSessionUrl")
        portaloneApiUrl.text = UserDefaults.standard.string(forKey: "portaloneApiUrl")
        
        addToolBar(textField: baseHost)
        
        addToolBar(textField: genericModalSessionUrl)
        addToolBar(textField: genericModalUrl)
        addToolBar(textField: portaloneApiSessionUrl)
        addToolBar(textField: portaloneApiUrl)
    }
    
    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        UserDefaults.standard.set(baseHost.text, forKey: "baseHost")
        
        UserDefaults.standard.set(genericModalSessionUrl.text, forKey: "genericModalSessionUrl")
        UserDefaults.standard.set(genericModalUrl.text, forKey: "genericModalUrl")
        UserDefaults.standard.set(portaloneApiSessionUrl.text, forKey: "portaloneApiSessionUrl")
        UserDefaults.standard.set(portaloneApiUrl.text, forKey: "portaloneApiUrl")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onResetButtonClick(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "baseHost")
        
        UserDefaults.standard.set(nil, forKey: "genericModalSessionUrl")
        UserDefaults.standard.set(nil, forKey: "genericModalUrl")
        UserDefaults.standard.set(nil, forKey: "portaloneApiSessionUrl")
        UserDefaults.standard.set(nil, forKey: "portaloneApiUrl")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
