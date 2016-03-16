//
// Created by Daniel  Martinez Muñoz on 14/3/16.
//  Copyright © 2016 Daniel Martínez. All rights reserved.
//

import UIKit

class ScrollableContentViewController : UIViewController {

    var activeField : UITextField?
    var keyboardIsShown = false
    var keyboardHeight : CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTapGesture()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listenNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.activeField?.endEditing(true)
        self.keyboardIsShown = false
        closeNotifications()
    }

    func setUpTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        self.view.addGestureRecognizer(gestureRecognizer)
    }

    func listenNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }

    func closeNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func keyboardWillShow( sender: NSNotification ) {

        let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size

        keyboardHeight = keyboardSize!.height

        var viewFrame = self.view.frame
        viewFrame.size.height = viewFrame.size.height - keyboardHeight - CGFloat(20)

        if let _ = self.activeField {
            if (!self.keyboardIsShown) {
                self.view.frame.origin.y -= keyboardHeight
                self.keyboardIsShown = true
            }
        }

    }

    func keyboardWillHide( sender: NSNotification ) {

        if (self.keyboardIsShown) {
            self.view.frame.origin.y += keyboardHeight
        }
        self.keyboardIsShown = false

    }

}

extension ScrollableContentViewController : UIGestureRecognizerDelegate {

    func handleTap( gestureRecognizer: UIGestureRecognizer ) {
        if let activeField = self.activeField {
            activeField.resignFirstResponder()
        }
    }

}

extension ScrollableContentViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.activeField = nil
        textField.resignFirstResponder()
        return false
    }

    func textFieldDidEndEditing(textField: UITextField) {
        self.activeField = nil
    }

}
