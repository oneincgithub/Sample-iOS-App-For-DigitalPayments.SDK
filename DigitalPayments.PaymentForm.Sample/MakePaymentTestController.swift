import UIKit
import DigitalPayments_PaymentForm_SDK

class MakePaymentTestController : BaseTestController {
    
    var digitalPaymentForm: DigitalPaymentForm!
    
    var minAmountDue: UITextField!
    var accountBalance: UITextField!
    var accountGroupCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        minAmountDue = initializeField("Min Amount Due")
        accountBalance = initializeField("Account Balance")
        accountGroupCode = initializeField("Account Group Code")
        
        fieldsStackView.addArrangedSubview(policyHolderName)
        fieldsStackView.addArrangedSubview(amountContext)
        fieldsStackView.addArrangedSubview(paymentCategory)
        fieldsStackView.addArrangedSubview(feeContext)
        fieldsStackView.addArrangedSubview(billingAddressStreet)
        fieldsStackView.addArrangedSubview(billingZip)
        fieldsStackView.addArrangedSubview(accountGroupCode)
        fieldsStackView.addArrangedSubview(minAmountDue)
        fieldsStackView.addArrangedSubview(accountBalance)
        fieldsStackView.addArrangedSubview(clientReferenceData1)
        fieldsStackView.addArrangedSubview(clientReferenceData2)
        fieldsStackView.addArrangedSubview(clientReferenceData3)
        fieldsStackView.addArrangedSubview(clientReferenceData4)
        fieldsStackView.addArrangedSubview(clientReferenceData5)
        fieldsStackView.addArrangedSubview(themeType)
        
        let count = CGFloat(integerLiteral: fieldsStackView.arrangedSubviews.count)
        let stackHeight = count * 30 + (count-1) * fieldsStackView.spacing
        fieldsStackViewHeight.constant = stackHeight
        view.layoutIfNeeded()
        
        policyHolderName.text = "Carl Holman"
        minAmountDue.text = "25"
        accountBalance.text = "130"
        clientReferenceData1.text = "123457"
    }
    
    private func getPaymentRequest() -> MakePaymentRequest {
        let minAmount = Decimal(string: minAmountDue.text ?? "");
        let balance = Decimal(string: accountBalance.text ?? "");
        
        return MakePaymentRequest(
            paymentCategory: PaymentCategory(rawValue: paymentCategory.text ?? "") ?? PaymentCategory.userSelect,
            feeContext: FeeContext(rawValue: feeContext.text ?? "") ?? FeeContext.paymentWithFee,
            amountContext: AmountContext(rawValue: amountContext.text ?? "") ?? AmountContext.selectOrEnterAmountConstrained,
            minAmountDue: minAmount,
            accountBalance: balance,
            policyHolderName: policyHolderName.text,
            billingAddressStreet: billingAddressStreet.text,
            billingZip: billingZip.text,
            accountGroupCode: accountGroupCode.text,
            clientReferenceData1: clientReferenceData1.text,
            clientReferenceData2: clientReferenceData2.text,
            clientReferenceData3: clientReferenceData3.text,
            clientReferenceData4: clientReferenceData4.text,
            clientReferenceData5: clientReferenceData5.text
        )
    }
    
    @IBAction func onOpenNativeButtonClick(_ sender: UIButton) {
        let request = getPaymentRequest()
        
        openNativeButton.isEnabled = false
        getPortalOneApiSession(button: openNativeButton) { (sessionKey: String, baseUrl: String) -> Void in
            self.digitalPaymentForm = DPMakePayment
                .initialize(sessionKey: sessionKey, url: baseUrl)
                .makePayment(request: request)
                .onLoad(do: {
                    self.sendNotification(title: "onLoad", body: nil)
                })
                .onPaymentComplete(do: {(response: PaymentInfo) -> Void in
                    self.sendNotification(title: "onPaymentComplete", body: response.toJSONString())
                })
                .onPaymentCanceled(do: {
                    self.sendNotification(title: "onPaymentCanceled", body: nil)
                })
                .onError(do: {(error: ErrorResponse) -> Void in
                    self.sendNotification(title: "onError", body: error.toJSONString())
                    if (error.description?.contains("InternalServerError") ?? false) {
                        self.digitalPaymentForm.close()
                    }
                })
                .onClose(do: {
                    self.sendNotification(title: "onClose", body: nil)
                })
                .setTheme(theme: self.getTheme())
                .start(hostViewController: self)
        }
    }
    
    @IBAction func onOpenDialogButtonClick(_ sender: UIButton) {
        let request = getPaymentRequest()

        openDialogButton.isEnabled = false
        getGenericModalSession(button: openDialogButton) { (sessionKey: String, baseUrl: String) -> Void in
            self.digitalPaymentForm = DPMakePayment
                .initialize(sessionKey: sessionKey, url: baseUrl)
                .makePayment(request: request)
                .onLoad(do: {
                    self.sendNotification(title: "onLoad", body: nil)
                })
                .onPaymentComplete(do: {(response: PaymentInfo) -> Void in
                    self.sendNotification(title: "onPaymentComplete", body: response.toJSONString())
                })
                .onPaymentCanceled(do: {
                    self.sendNotification(title: "onPaymentCanceled", body: nil)
                })
                .onError(do: {(error: ErrorResponse) -> Void in
                    self.sendNotification(title: "onError", body: error.toJSONString())
                    if (error.description?.contains("InternalServerError") ?? false) {
                        self.digitalPaymentForm.close()
                    }
                })
                .onClose(do: {
                    self.sendNotification(title: "onClose", body: nil)
                })
                .setTheme(theme: self.getTheme())
                .startWebView(hostViewController: self)
        }
    }
}
