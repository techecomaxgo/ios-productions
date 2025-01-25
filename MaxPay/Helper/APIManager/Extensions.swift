//
//  Extensions.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 22/05/24.
//

import Foundation
import UIKit
import Photos
import SwiftLoader

protocol DesignableBorder {

    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor? { get set }

}
@IBDesignable extension UIView: DesignableBorder {

    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.borderColor = newValue?.cgColor }
    }

}
@IBDesignable class TextViewWithPlaceholder: UITextView {
    
    override var text: String! { // Ensures that the placeholder text is never returned as the field's text
        get {
            if showingPlaceholder {
                return "" // When showing the placeholder, there's no real text to return
            } else { return super.text }
        }
        set { super.text = newValue }
    }
    @IBInspectable var placeholderText: String = ""
    @IBInspectable var placeholderTextColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
    private var showingPlaceholder: Bool = true // Keeps track of whether the field is currently showing a placeholder
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPlaceholderText() // Load up the placeholder text when first appearing, but not if coming back to a view where text was already entered
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        // If the current text is the placeholder, remove it
        if showingPlaceholder {
            text = nil
            textColor = nil // Put the text back to the default, unmodified color
            showingPlaceholder = false
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        // If there's no text, put the placeholder back
        if text.isEmpty {
            showPlaceholderText()
        }
        return super.resignFirstResponder()
    }
    
    private func showPlaceholderText() {
        showingPlaceholder = true
        textColor = placeholderTextColor
        text = placeholderText
    }
}

private var __maxLengths = [UITextField: Int]()

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
        @IBInspectable var maxLength: Int {
            get {
                guard let l = __maxLengths[self] else {
                   return 150 // (default int limit)
                }
                return l
            }
            set {
                __maxLengths[self] = newValue
                addTarget(self, action: #selector(setMaxLength), for: .editingChanged)
            }
        }

        @objc func setMaxLength(textField: UITextField) {
            let t = textField.text
            textField.text = t?.prefix(maxLength).description
        }
}

extension PHAsset {
    func image(targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?) -> UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}

extension UIViewController {
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChild(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParent: self)
    }


    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                    toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                       toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                     toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                      toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)

        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
    
    func removeChild() {
      self.children.forEach {
        $0.willMove(toParent: nil)
        $0.view.removeFromSuperview()
        $0.removeFromParent()
      }
        
    }
    func showProgressBar() {
        DispatchQueue.main.async {
            //self.view.showBlurLoader(frame: self.view.frame)
           // MBProgressHUD.showAdded(to: self.view, animated: true)
            SwiftLoader.show(animated: true)
        }
    }
    
    func hideProgressBar(){
        DispatchQueue.main.async {
            //self.view.removeBluerLoader()
          //  MBProgressHUD.hide(for: self.view, animated: true)
            SwiftLoader.hide()
        }
    }
    
    func displayAlert(message : String){
        let alert = UIAlertController(title: AlertTitle, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: OkButton, style: .default, handler: {_ in })
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension NSMutableData {

func appendString(_ string: String) {
       if let data = string.data(using: String.Encoding.utf8,
          allowLossyConversion: true) {
             append(data)
        }
     }
 }

extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }
}


extension UITextField {

    func setLeftPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension Date {
    func getCurrentDateTime()->String {
        // Get the current date and time
        let currentDate = Date()
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set to UTC
        let isoDateString = isoFormatter.string(from: currentDate)
        return isoDateString
    }

}
