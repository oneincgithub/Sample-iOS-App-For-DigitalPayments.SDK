import UIKit

extension UIViewController: UITextFieldDelegate {
    
    func addToolBar(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = view.tintColor
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(){
        view.endEditing(true)
    }    
    
    @objc func keyboardWasShown(notification: NSNotification){
        let scrollView = self.view.viewWithTag(99) as! UIScrollView
        let userInfo = notification.userInfo!
        let valInfo: NSValue = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardFrame: CGRect = valInfo.cgRectValue
        var contentInsent: UIEdgeInsets = scrollView.contentInset
        contentInsent.bottom = keyboardFrame.size.height + 45
        scrollView.contentInset = contentInsent
        scrollView.scrollIndicatorInsets = contentInsent
    }
    
    @objc func keyboardWasHidden(notification: NSNotification){
        let scrollView = self.view.viewWithTag(99) as! UIScrollView
        let contentInsent: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsent
    }
}
