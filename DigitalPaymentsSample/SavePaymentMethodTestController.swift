import UIKit
import DigitalPaymentsSDK

class SavePaymentMethodTestController : BaseTestController {   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var digitalPaymentForm: DigitalPaymentForm! = nil
    
    @IBAction func onOpenDialogButtonClick(_ sender: UIButton) {
        let request = SavePaymentMethodRequest(
            paymentCategory: PaymentCategory(rawValue: paymentCategory.text ?? "") ?? PaymentCategory.userSelect,
            policyHolderName: policyHolderName.text,
            clientReferenceData1: clientReferenceData1.text
        )
        
        digitalPaymentForm = DPSavePaymentMethodViewController
            .initialize(sessionKey: sessionKey!, url: genericModalUrl)
            .savePaymentMethod(request: request)
            .onLoad(do: {print("Save payment method controller: onLoad")})
            .onSaveComplete(do: {(response: SavePaymentMethodResponse) -> Void in print("Save payment method controller: onSaveComplete \(response) \(response.toJSONString())")})
            .onSaveCanceled(do: {print("Save payment method controller: onSaveCanceled")})
            .onError(do: {(error: ErrorResponse) -> Void in self.onErrorMessage(response: error) })
            .onClose(do: {print("Save payment method controller: onClose")})
            .startWebView(hostViewController: self)
    }
    
    private func onErrorMessage(response: ErrorResponse){
        print("Save payment method controller: onError \(response.toJSONString())")
        if (response.description?.contains("InternalServerError") ?? false) {
            digitalPaymentForm.close()
        }
    }
}
