import UIKit
import DigitalPaymentsSDK

class SavePaymentMethodTestController : BaseTestController {   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onOpenDialogButtonClick(_ sender: UIButton) {
        let request = SavePaymentMethodRequest(
            paymentCategory: PaymentCategory(rawValue: paymentCategory.text ?? "") ?? PaymentCategory.userSelect,
            policyHolderName: policyHolderName.text,
            clientReferenceData1: clientReferenceData1.text
        )
        
        DPSavePaymentMethodViewController
            .initialize(sessionKey: sessionKey!, url: genericModalUrl)
            .savePaymentMethod(request: request)
            .onSaveComplete(do: {(response: SavePaymentMethodResponse) -> Void in print("Save payment method controller: onSaveComplete \(response.toJSONString())")})
            .onSaveCanceled(do: {print("Save payment method controller: onPaymentCanceled")})
            .onError(do: {(error: ErrorResponse) -> Void in print("Save payment method controller: onError \(error.toJSONString())")})
            .onClose(do: {print("Save payment method controller: onClose")})
            .startWebView(hostViewController: self)
    }
}
