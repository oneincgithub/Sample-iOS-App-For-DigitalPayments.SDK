import UIKit

class SettingController : UIViewController{
    
    @IBOutlet weak var sessionUrl: UITextField!
    @IBOutlet weak var genericModalUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionUrl.text = UserDefaults.standard.string(forKey: "sessionUrl")
        genericModalUrl.text = UserDefaults.standard.string(forKey: "genericModalUrl")
        
        addToolBar(textField: sessionUrl)
        addToolBar(textField: genericModalUrl)
    }
    
    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        UserDefaults.standard.set(sessionUrl.text, forKey: "sessionUrl")
        UserDefaults.standard.set(genericModalUrl.text, forKey: "genericModalUrl")
        self.navigationController?.popToRootViewController(animated: true)
    }
}
