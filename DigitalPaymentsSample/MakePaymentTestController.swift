import UIKit
import DigitalPaymentsSDK

class MakePaymentTestController : BaseTestController {    
    
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

        DPMakePaymentViewController
            .initialize(sessionKey: sessionKey!, url: genericModalUrl)
            .makePayment(request: request)
            .onPaymentComplete(do: {(response: PaymentInfo) -> Void in print("Make payment controller: onPaymentComplete \(response.toJSONString())")})
            .onPaymentCanceled(do: {print("Make payment controller: onPaymentCanceled")})
            .onError(do: {(error: ErrorResponse) -> Void in print("Make payment controller: onError \(error.toJSONString())")})
            .onClose(do: {print("Make payment controller: onClose")})
            .startWebView(hostViewController: self)
    }
}
