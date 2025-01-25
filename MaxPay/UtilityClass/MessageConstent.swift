

import Foundation
import UIKit
let ALERT_HEADER = "Warnning"
let ALERT_BLANK_EMAIL = "Please enter your email address"
let ALERT_INVALID_EMAIL = "Please enter a valid email address!"
let ALERT_BLANK_PHONE = "Please enter your mobile number"
let ALERT_INVALID_PHONE = "Please enter a valid mobile number!"
let ALERT_BLANK_NAME = "Please enter your name"
let ALERT_BLANK_PASSWORD = "Please set your password"
let ALERT_OTP_NOT_MATCH = "Otp not matched"


let ALERT_BLANK_EMAIL_MOBILE = "Please enter valid email or mobile number!"
let ALERT_BLANK_LOGIN_PASSWORD = "Please enter your password!"

let ALERT_ITEM_ADDED = "Item added successfully"

let ALERT_LOGOUT_MESSAGE = "Are you sure you want to log out from Pharma Store"
let ALERT_BLANK_ADDRESS = "Please add address"
let ALERT_BLANK_INSERT = "All field mandetory"
let ALERT_BLANK_ITEM = "Please add item"

func showAlertMessageWithActionButton(title: String, message: String, actionButtonText: String,cancelActionButtonText: String, vc: UIViewController, complitionHandeler: @escaping(_ status: Int)-> (Void)){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //alert.view.backgroundColor = APP_THEAM_COLOUR
    alert.addAction(UIAlertAction(title: cancelActionButtonText , style: .default, handler: { (action) in
        
    }))
    alert.addAction(UIAlertAction(title: actionButtonText,
                                  style: .destructive,
                                  handler: {(_: UIAlertAction!) in
        complitionHandeler(1)
    }))
    DispatchQueue.main.async {
        vc.present(alert, animated: true, completion: nil)
    }
}


func showAlertMessage(title: String, message: String,  vc: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK" , style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}


func showAlertMessageWithOkAction(title: String, message: String, vc: UIViewController, complitionHandeler: @escaping(_ status: Int)-> (Void)){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK",
                                  style: .destructive,
                                  handler: {(_: UIAlertAction!) in
                                    complitionHandeler(1)
    }))
    vc.present(alert, animated: true, completion: nil)
}

func showAlertMessageWithActionButtonAndCancelButton(title: String, message: String, actionButtonText: String,cancelActionButtonText: String, vc: UIViewController, complitionHandeler: @escaping(_ status: Int)-> (Void)){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //alert.view.backgroundColor = APP_THEAM_COLOUR
    alert.addAction(UIAlertAction(title: cancelActionButtonText,
                                  style: .destructive,
                                  handler: {(_: UIAlertAction!) in
        complitionHandeler(1)
    }))
    alert.addAction(UIAlertAction(title: actionButtonText, style: .default, handler: { (action) in
        complitionHandeler(0)
    }))
    DispatchQueue.main.async {
        vc.present(alert, animated: true, completion: nil)
    }
}
