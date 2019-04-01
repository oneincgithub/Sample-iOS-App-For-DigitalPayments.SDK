import UIKit
import DigitalPaymentsSDK

class MakePaymentTestController : BaseTestController {
    
    var digitalPaymentForm: DigitalPaymentForm! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func onOpenDialogButtonClick(_ sender: UIButton) {
        let minAmount = Decimal(string: minAmountDue.text ?? "");
        let balance = Decimal(string: accountBalance.text ?? "");

        let request = MakePaymentRequest(
            paymentCategory: PaymentCategory(rawValue: paymentCategory.text ?? "") ?? PaymentCategory.userSelect,
            feeContext: FeeContext(rawValue: feeContext.text ?? "") ?? FeeContext.paymentWithFee,
            minAmountDue: minAmount,
            accountBalance: balance,
            policyHolderName: policyHolderName.text,
            clientReferenceData1: clientReferenceData1.text
        )

        digitalPaymentForm = DPMakePaymentViewController
            .initialize(sessionKey: sessionKey!, url: genericModalUrl)
            .makePayment(request: request)
            .onLoad(do: {print("Make payment controller: onLoad")})
            .onPaymentComplete(do: {(response: PaymentInfo) -> Void in print("Make payment controller: onPaymentComplete \(response) \(response.toJSONString())")})
            .onPaymentCanceled(do: {print("Make payment controller: onPaymentCanceled")})
            .onError(do: {(error: ErrorResponse) -> Void in self.onErrorMessage(response: error) })
            .onClose(do: {print("Make payment controller: onClose")})
            .startWebView(hostViewController: self)
    }
    
    private func onErrorMessage(response: ErrorResponse){
        print("Make payment controller: onError \(response.toJSONString())")
        if (response.description?.contains("InternalServerError") ?? false) {
            digitalPaymentForm.close()
        }
    }
}
