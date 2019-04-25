import UIKit
import UserNotifications
import DigitalPayments_PaymentForm_SDK

class BaseTestController : UIViewController {
    
    @IBOutlet weak var fieldsStackView: UIStackView!
    @IBOutlet weak var fieldsStackViewHeight: NSLayoutConstraint!
    
    var policyHolderName: UITextField!
    var paymentCategory: UITextField!
    
    var billingZip: UITextField!
    var billingAddressStreet: UITextField!
    
    var clientReferenceData1: UITextField!
    var clientReferenceData2: UITextField!
    var clientReferenceData3: UITextField!
    var clientReferenceData4: UITextField!
    var clientReferenceData5: UITextField!
    var themeType: UITextField!
    
    var feeContext: UITextField!
    var amountContext: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorLabel: UILabel!
    @IBOutlet weak var openDialogButton: UIButton!
    @IBOutlet weak var openNativeButton: UIButton!
    
    var themeTypes = [ "Dark", "Light" ]
    var themeTypeValues = [ Theme.darkTheme, .lightTheme ]
    var paymentCategories = PaymentCategory.allCases
    var feeContexts = FeeContext.allCases
    var amountContexts = [ AmountContext.selectOrEnterAmount, .selectOrEnterAmountConstrained, .amountDueOnly, .selectAmount ]
    
    func sendNotification(title: String, body: String?){
        print("Event \(title)! Body: \"\(body ?? "")\"")
        
        if #available(iOS 10.0, *) {
            //Setting content of the notification
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body ?? ""
            content.badge = 1
            
            //Setting time for notification trigger
            let date = Date(timeIntervalSinceNow: 3)
            let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
            //Adding Request
            let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    public func getGenericModalSession(button: UIButton, onCompleteHandler: @escaping (_ sessionKey: String, _ baseUrl: String) -> Void) {
        let genericModalSessionUrl = UserDefaults.standard.string(forKey: "genericModalSessionUrl")
        let genericModalUrl = UserDefaults.standard.string(forKey: "genericModalUrl")
        
        let sessionService = SessionService(url: genericModalSessionUrl!)
        activityIndicator.startAnimating()
        activityIndicatorLabel.isHidden = false
        sessionService.generateSessionId() {(result: SessionCreateResponse) -> Void in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicatorLabel.isHidden = true
                button.isEnabled = true
                if (result.isSuccessful == true || result.responseCode == "Success"){
                    onCompleteHandler(result.sessionKey!, genericModalUrl!)
                } else {
                    print("Session Service is failed: \(result.errorDescription!)")
                }
            }
        }
    }
    
    public func getPortalOneApiSession(button: UIButton, onCompleteHandler: @escaping (_ sessionKey: String, _ baseUrl: String) -> Void) {
        let portaloneApiSessionUrl = UserDefaults.standard.string(forKey: "portaloneApiSessionUrl")
        let portaloneApiUrl = UserDefaults.standard.string(forKey: "portaloneApiUrl")
        
        let sessionService = SessionService(url: portaloneApiSessionUrl!)
        activityIndicator.startAnimating()
        activityIndicatorLabel.isHidden = false
        sessionService.generateSessionId() {(result: SessionCreateResponse) -> Void in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicatorLabel.isHidden = true
                button.isEnabled = true
                if (result.isSuccessful == true || result.responseCode == "Success"){
                    onCompleteHandler(result.portalOneSessionKey!, portaloneApiUrl!)
                } else {
                    print("Session Service is failed: \(result.errorDescription!)")
                }
            }
        }
    }
    
    private func getPickerView(tag: Int) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.tag = tag
        return picker
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorLabel.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        policyHolderName = initializeField("Policy Holder Name")
        paymentCategory = initializeField("Payment Category")
        paymentCategory.inputView = getPickerView(tag: 1)
        billingAddressStreet = initializeField("Billing Address Street")
        billingZip = initializeField("Billing Zip")
        clientReferenceData1 = initializeField("Client Reference Data 1")
        clientReferenceData2 = initializeField("Client Reference Data 2")
        clientReferenceData3 = initializeField("Client Reference Data 3")
        clientReferenceData4 = initializeField("Client Reference Data 4")
        clientReferenceData5 = initializeField("Client Reference Data 5")
        themeType = initializeField("Theme Type")
        themeType.inputView = getPickerView(tag: 3)
        
        feeContext = initializeField("Fee Context")
        feeContext.inputView = getPickerView(tag: 2)
        
        amountContext = initializeField("Amount Context")
        amountContext.inputView = getPickerView(tag: 4)
        
        requestPermissions()
    }
    
    public func getTheme() -> Theme {
        let index = themeTypes.index(of: themeType.text!)
        if (index != nil) {
            return themeTypeValues[index!]
        } else {
            return .lightTheme
        }
    }
    
    func requestPermissions() {
        if #available(iOS 10.0, *) {
            //iOS 10.0 and greater
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    else {
                    }
                }
            })
        }
        else {
            //iOS 9
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }

    }
    
    func initializeField(_ placeholder: String) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        field.widthAnchor.constraint(equalToConstant: fieldsStackView.frame.width).isActive = true
        field.borderStyle = .roundedRect
        addToolBar(textField: field)
        return field
    }
}


extension BaseTestController: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

extension BaseTestController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return paymentCategories.count
        }
        if pickerView.tag == 2 {
            return feeContexts.count
        }
        if pickerView.tag == 3 {
            return themeTypes.count
        }
        if pickerView.tag == 4 {
            return amountContexts.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return paymentCategories[row].rawValue
        }
        if pickerView.tag == 2 {
            return feeContexts[row].rawValue
        }
        if pickerView.tag == 3 {
            return themeTypes[row]
        }
        if pickerView.tag == 4 {
            return amountContexts[row].rawValue
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.paymentCategory.text = self.paymentCategories[row].rawValue
        }
        if pickerView.tag == 2 {
            self.feeContext.text = self.feeContexts[row].rawValue
        }
        if pickerView.tag == 3 {
            self.themeType.text = self.themeTypes[row]
        }
        if pickerView.tag == 4 {
            self.amountContext.text = self.amountContexts[row].rawValue
        }
    }
}
