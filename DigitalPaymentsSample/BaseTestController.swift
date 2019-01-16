import UIKit
import DigitalPaymentsSDK

class BaseTestController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var policyHolderName: UITextField!
    @IBOutlet weak var paymentCategory: UITextField!
    @IBOutlet weak var clientReferenceData1: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feeContext: UITextField!
    @IBOutlet weak var minAmountDue: UITextField!
    @IBOutlet weak var accountBalance: UITextField!    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorLabel: UILabel!
    @IBOutlet weak var openDialogButton: UIButton!
    
    var dropDownPaymentCategory: UIPickerView!
    var dropDownFeeContext: UIPickerView!
    
    var paymentCategories = PaymentCategory.allCases
    var feeContexts = FeeContext.allCases
    
    var genericModalUrl: String!
    var sessionUrl: String!
    
    var sessionKey: String!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorLabel.isHidden = false
        openDialogButton.isEnabled = false
        genericModalUrl = UserDefaults.standard.string(forKey: "genericModalUrl") ?? ""
        sessionUrl = UserDefaults.standard.string(forKey: "sessionUrl") ?? ""
        
        dropDownPaymentCategory = UIPickerView()
        dropDownPaymentCategory.delegate = self
        dropDownPaymentCategory.tag = 1
        
        paymentCategory.inputView = dropDownPaymentCategory
        
        addToolBar(textField: policyHolderName)
        addToolBar(textField: clientReferenceData1)
        
        if(minAmountDue != nil)
        {
            addToolBar(textField: minAmountDue)
        }
        
        if(accountBalance != nil)
        {
            addToolBar(textField: accountBalance)
        }
        
        if(feeContext != nil)
        {
            dropDownFeeContext = UIPickerView()
            dropDownFeeContext.delegate = self
            dropDownFeeContext.tag = 2
            
            feeContext.inputView = dropDownFeeContext
        }
        
        let sessionService = SessionService(url: sessionUrl)
        activityIndicator.startAnimating()
        sessionService.generateSessionId(onCompleteHandler: {(result: SessionCreateResponse) -> Void in
            self.activityIndicator.stopAnimating()
            self.activityIndicatorLabel.isHidden = true
            self.openDialogButton.isEnabled = true
            if (result.isSuccessful){
                self.sessionKey = result.sessionKey
            } else {
                print("Session Service is failed: \(result.errorDescription!)")
            }
        })
    }
    
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
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return paymentCategories[row].rawValue
        }
        if pickerView.tag == 2 {
            return feeContexts[row].rawValue
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.paymentCategory.text = self.paymentCategories[row].rawValue
            self.paymentCategory.resignFirstResponder()
        }
        if pickerView.tag == 2 {
            self.feeContext.text = self.feeContexts[row].rawValue
            self.feeContext.resignFirstResponder()
        }
    }
}
