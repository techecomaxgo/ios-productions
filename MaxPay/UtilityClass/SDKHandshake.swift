//
//  SDKHandshake.swift
//  MaxPay
//
//  Created by india on 15/12/23.
//
/*
 sdkHandShake.emailId = “srikanth.g@olivecrypto.com"
 sdkHandShake.merchId = "Olive001"
 sdkHandShake.merchChanId = "OLIVEAPP"
 sdkHandShake.submerchantid = "674545454"
 sdkHandShake.mcccode = "1520"
 sdkHandShake.unqCustId = "919542244401"
 sdkHandShake.mobileNo = "919542244401"
 sdkHandShake.deviceid =Utils.getDeviceId()
 sdkHandShake.appid = DialogUtils.getAppId()
 sdkHandShake.custname = "Gimka Srikanth"
 sdkHandShake.merchantauthtoken = merchantAuthToken ?? ""
 sdkHandShake.unqTxnId = Utils.generateRandomDigits(13)
 */


private var selectedBank: Int = 0

let AggregtorCode = "ECOMAXGOPROD1234"
let MerchantId = "ECOMAXGOPROD1234"
let MerchChanId = "ECOMAXGOPROD1234"
//let SubMerchantId = "OLIVE"
let SubMerchantId = "ECOMAXGOPROD1234"

let MerchantVpa = "ecomaxgo@maxaxis"
let MCC = "6211"
let appId = "com.maxupi.in.maxpay"
let TranTypeP2P = "P2P"
let TranTypeP2M = "P2M"

private var URI = ""
private var Sign = ""
var subscriptionId: Int = -1

// static func setUri(ac: Account) {
//     URI = "upi://pay?pa=\(ac.vpa)&cu=INR&am=0&pn=\(ac.name)&refUrl=https://www.axisbank.com&OrgId=400005&mode=01&purpose=00"
// }
 
import Foundation

struct SDKHandshake:Codable {
    static let shared = SDKHandshake()
    var emailId = ""
    var subscriptionId = 0
    var merchId = ""
    var merchChanId = ""
    var submerchantid = ""
    var mcccode = ""
    var unqCustId = ""
    var mobileNo = ""
    var deviceid = ""
    var appid = ""
    var custname = ""
    var merchantauthtoken = ""
    var unqTxnId = ""
    
    
    
    func jsonString(_ sdkHandShake:SDKHandshake) ->String{
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON readable
            let jsonData = try jsonEncoder.encode(sdkHandShake)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                // Now jsonString contains the JSON representation of sdkHandShake
                return jsonString
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return ""
        }
        return ""
    }
    
    func generateRandomDigits(_ count: Int) -> String {
        var result = ""
        for _ in 0..<count {
            let digit = Int.random(in: 0...9)
            result += "\(digit)"
        }
        return result
    }

}
