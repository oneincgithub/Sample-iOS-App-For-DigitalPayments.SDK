import UIKit
import UserNotifications
import DigitalPayments_PaymentForm_SDK

class SavePaymentMethodTestController : BaseTestController {
    
    var digitalPaymentForm: DigitalPaymentForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        fieldsStackView.addArrangedSubview(policyHolderName)
        fieldsStackView.addArrangedSubview(paymentCategory)
        fieldsStackView.addArrangedSubview(billingAddressStreet)
        fieldsStackView.addArrangedSubview(billingZip)
        fieldsStackView.addArrangedSubview(clientReferenceData1)
        fieldsStackView.addArrangedSubview(clientReferenceData2)
        fieldsStackView.addArrangedSubview(clientReferenceData3)
        fieldsStackView.addArrangedSubview(clientReferenceData4)
        fieldsStackView.addArrangedSubview(clientReferenceData5)
        fieldsStackView.addArrangedSubview(themeType)
        
        policyHolderName.text = "Carl Holman"
        clientReferenceData1.text = "123456"
    }
    
    private func getSavePaymentMethodRequest() -> SavePaymentMethodRequest {
        return SavePaymentMethodRequest(
            paymentCategory: PaymentCategory(rawValue: paymentCategory.text ?? "") ?? PaymentCategory.userSelect,
            policyHolderName: policyHolderName.text,
            billingAddressStreet: billingAddressStreet.text,
            billingZip: billingZip.text,
            clientReferenceData1: clientReferenceData1.text,
            clientReferenceData2: clientReferenceData2.text,
            clientReferenceData3: clientReferenceData3.text,
            clientReferenceData4: clientReferenceData4.text,
            clientReferenceData5: clientReferenceData5.text
        )
    }
    
    @IBAction func onOpenDialogButtonClick(_ sender: UIButton) {
        openDialogButton.isEnabled = false
        getGenericModalSession(button: openDialogButton) { (sessionKey: String, baseUrl: String) -> Void in
            self.digitalPaymentForm = DPSavePaymentMethod
                .initialize(sessionKey: sessionKey, url: baseUrl)
                .savePaymentMethod(request: self.getSavePaymentMethodRequest())
                .onLoad(do: {
                    self.sendNotification(title: "onLoad", body: nil)
                })
                .onSaveComplete(do: {(response: SavePaymentMethodResponse) -> Void in
                    self.sendNotification(title: "onSaveComplete", body: response.toJSONString())
                })
                .onSaveCanceled(do: {
                    self.sendNotification(title: "onSaveCanceled", body: nil)
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
    
    @IBAction func onOpenNativeButtonClick(_ sender: UIButton) {
        openNativeButton.isEnabled = false
        getPortalOneApiSession(button: openNativeButton) { (sessionKey: String, baseUrl: String) -> Void in
            self.digitalPaymentForm = DPSavePaymentMethod
                .initialize(sessionKey: sessionKey, url: baseUrl)
                .savePaymentMethod(request: self.getSavePaymentMethodRequest())
                .onLoad(do: {
                    self.sendNotification(title: "onLoad", body: nil)
                })
                .onSaveComplete(do: {(response: SavePaymentMethodResponse) -> Void in
                    self.sendNotification(title: "onSaveComplete", body: response.toJSONString())
                })
                .onSaveCanceled(do: {
                    self.sendNotification(title: "onSaveCanceled", body: nil)
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
}
