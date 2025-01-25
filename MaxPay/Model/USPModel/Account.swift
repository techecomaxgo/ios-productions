//
//  Account.swift
//  MaxPay
//
//  Created by india on 15/12/23.
//

import Foundation

struct PayerInfo: Codable {
    
    var accountnumber: String?
    var mcc: String?
    var name: String?
    var payervpa: String?
    
    init(accountnumber: String? = nil, mcc: String? = nil, name: String? = nil, payervpa: String? = nil) {
        self.accountnumber = accountnumber
        self.mcc = mcc
        self.name = name
        self.payervpa = payervpa
    }
    
}

struct CustomerBankAccounts : Codable {
    
}

struct Banks {
    var colourCode: String?
    var ifsc: String?
    var iin: String?
    var logo: String?
    var name: String?
    
    init(colourCode: String?, ifsc: String?, iin: String?, logo: String?, name: String?) {
        self.colourCode = colourCode
        self.ifsc = ifsc
        self.iin = iin
        self.logo = logo
        self.name = name
    }
    
    init?(json: [String: Any]) {
        guard let ifsc = json["ifsc"] as? String,
              let iin = json["iin"] as? String,
              let name = json["name"] as? String else {
            return nil
        }
        
        self.colourCode = json["colourcode"] as? String
        self.ifsc = ifsc
        self.iin = iin
        self.logo = json["logo"] as? String
        self.name = name
    }
}

struct MyAccounts: Codable {
    
    var accounts: [AccountDetailsOnIIN]
    var bankCode: String?
    var bankName: String?
    var input: String?
    
    enum CodingKeys: CodingKey {
        case accounts
        case bankCode
        case bankName
        case input
    }
    
}











struct AccountDetailsOnIIN: Codable {
    var bankName: String?
    var bankLogo: String?
    var accRefNumber: String?
    var aeba: String? //
    var atmpinFormat: String?
    var atmpinLength: String?
    var balTime: String?
    var balance: String?
    var bankId: String?
    var dLength: String? //
    var dType: String?
    var ifsc: String?
    var iin: String?
    var input: String?
    var maskedAccnumber: String?
    var mbeba: String? //
    var mmid: String? //
    var name: String? //
    var otpFormat: String? //
    var otpLength: String? //
//    var partyId: String? - NA
    var status: String? //
    var type: String?
//    var uidnum: String? - NA
    var vpa: String?
//    var vpas: String? - NA

    enum CodingKeys: String, CodingKey {

        case bankName = "bankName"
        case bankLogo = "bankLogo"
        case accRefNumber = "accRefNumber"
        case aeba = "aeba"
        case atmpinFormat = "atmpinFormat"
        case atmpinLength = "atmpinLength"
        case balTime = "balTime"
        case balance = "balance"
        case bankId = "bankId"
        case dLength = "dLength"
        case dType = "dType"
        case ifsc = "ifsc"
        case iin = "iin"
        case input = "input"
        case maskedAccnumber = "maskedAccnumber"
        case mbeba = "mbeba"
        case mmid = "mmid"
        case name = "name"
        case otpFormat = "otpFormat"
        case otpLength = "otpLength"
        case status = "status"
        case type = "type"
        case vpa = "vpa"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
        bankLogo = try values.decodeIfPresent(String.self, forKey: .bankLogo)
        accRefNumber = try values.decodeIfPresent(String.self, forKey: .accRefNumber)
        aeba = try values.decodeIfPresent(String.self, forKey: .aeba)
        atmpinFormat = try values.decodeIfPresent(String.self, forKey: .atmpinFormat)
        atmpinLength = try values.decodeIfPresent(String.self, forKey: .atmpinLength)
        balTime = try values.decodeIfPresent(String.self, forKey: .balTime)
        balance = try values.decodeIfPresent(String.self, forKey: .balance)
        bankId = try values.decodeIfPresent(String.self, forKey: .bankId)
        dLength = try values.decodeIfPresent(String.self, forKey: .dLength)
        dType = try values.decodeIfPresent(String.self, forKey: .dType)
        ifsc = try values.decodeIfPresent(String.self, forKey: .ifsc)
        iin = try values.decodeIfPresent(String.self, forKey: .iin)
        input = try values.decodeIfPresent(String.self, forKey: .input)
        maskedAccnumber = try values.decodeIfPresent(String.self, forKey: .maskedAccnumber)
        mbeba = try values.decodeIfPresent(String.self, forKey: .mbeba)
        mmid = try values.decodeIfPresent(String.self, forKey: .mmid)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        otpFormat = try values.decodeIfPresent(String.self, forKey: .otpFormat)
        otpLength = try values.decodeIfPresent(String.self, forKey: .otpLength)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        vpa = try values.decodeIfPresent(String.self, forKey: .vpa)
        
    }

    
}


struct AccountDetails: Codable {
    var name: String
    var aeba: String //
    var mbeba: String //
    var accRefNumber: String //
    var ifsc: String //
    var maskedAccnumber: String //
    var status: String
    var type: String
    var vpa: String
    var dLength: String //
    var dType: String //
    var balance: String //
    var balTime: String //
    var atmpinFormat: String //
    var atmpinLength: String //
    var iin: String //
    var internationlActive: String //
    var otpFormat: String

    enum CodingKeys: String, CodingKey {
        case name, /*mmid,*/ aeba, mbeba, accRefNumber, ifsc, maskedAccnumber, status, type, vpa, dLength, dType, balance, balTime, atmpinFormat, atmpinLength, iin, internationlActive, otpFormat
    }
}

struct AccountPay: Codable {
    var name: String
    var mmid: String
    var aeba: String
    var mbeba: String
    var accRefNumber: String
    var ifsc: String
    var maskedAccnumber: String
    var status: String
    var type: String
    var vpa: String
    var dLength: String
    var dType: String
    var balance: String
    var balTime: String
    var accountIfsc: String
    var iin: String //
//    var atmpinFormat: String //
//    var atmpinLength: String // Int
//    var iin: String //
//    var internationlActive: String //
//    var otpFormat: String //
//    var bankName: String //
//    var defaultAccount: String //
//    var maskedAadhaarNumber: String //
//    var otpLength: String // Int

    enum CodingKeys: String, CodingKey {
        case name, mmid, aeba, mbeba, accRefNumber, ifsc, maskedAccnumber, status, type, vpa, dLength, dType, balance, balTime,accountIfsc,iin /*, atmpinFormat, atmpinLength, iin, internationlActive, otpFormat, bankName, defaultAccount, maskedAadhaarNumber, otpLength*/
    }
}
struct BeneVpa: Codable {
    
    var name: String
    var vpa: String
    var nickName: String
    
    enum CodingKeys: CodingKey {
        case name
        case vpa
        case nickName
    }
}
struct PaymentInput: Codable {
    var amount: String
    var merchantVpa: String
    var merchantId: String
    var submerchantid: String
    var merchantChannelId: String
    var tranType: String // - “P2P”
    var mcc: String // - “P2P”
    var remarks: String
    var initMode: String // “00”
    var purpose: String // “00”
    var refCategory: String // “00”


    enum CodingKeys: CodingKey {
        case amount
        case merchantVpa
        case merchantId
        case submerchantid
        case merchantChannelId
        case tranType
        case mcc
        case remarks
        case initMode
        case purpose
        case refCategory
    }
}


struct SaveBeneVpa: Codable {
    
    var vpa: String
    var name: String
    var nickname: String
    
    enum CodingKeys: CodingKey {
        case vpa
        case name
        case nickname
    }
    
}

struct CollectBeneVpa: Codable {
//        public String name; --
//        public String notes;
//        public String status;
//        public String mobile;
//        public String payerVpa;
//        public String payeeVpa;
//        public String beneName;
//        public String amount;
//        public String expdate;
//        public String refid;
//        public String datetime; --
//        public String merchantflag; --
//        public String invoiceurl; --
//        public String initiatedtime; --
//        public String refCategory; --
//        public String purpose; --
//        public String payeecode; --
    
    
    
    var name: String
    var amount: String
    var beneName: String
    var expdate: String
    var mobile: String
    var notes: String
    var payeeVpa: String
    var payerVpa: String
    var refid: String
    var status: String
    var txnid: String
    var datetime: String
    var merchantflag: String
    var invoiceurl: String
    var initiatedtime: String
    var refCategory: String
    var purpose: String
    var payeecode: String
    
    
    
    enum CodingKeys: CodingKey {
        case name
        case amount
        case beneName
        case expdate
        case mobile
        case notes
        case payeeVpa
        case payerVpa
        case refid
        case status
        case txnid
        case datetime
        case merchantflag
        case invoiceurl
        case initiatedtime
        case refCategory
        case purpose
        case payeecode
        
        
    }
}



struct ResponseObject: Codable {
    var code: String
    var data: [AccountDetails]
    var result: String
}


//struct AccountCheckBalance: Codable {
//    var name: String?
//    var mmid: String?
//    var aeba: String?
//    var mbeba: String?
//    var accRefNumber: String?
//    var ifsc: String?
//    var maskedAccnumber: String?
//    var status: String?
//    var type: String?
//    var vpa: String?
//    var dLength: String?
//    var dType: String?
//    var balance: String?
//    var balTime: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name, mmid, aeba, mbeba, accRefNumber, ifsc, maskedAccnumber, status, type, vpa, dLength, dType, balance, balTime
//    }
//}

struct AccountCheckBalance: Codable {
    var name: String?
    var mmid: String?
    var aeba: String?
    var mbeba: String?
    var accRefNumber: String?
    var ifsc: String?
    var maskedAccnumber: String?
    var status: String?
    var type: String?
    var vpa: String?
    var dLength: String?
    var dType: String?
    var balance: String?
    var balTime: String?

    enum CodingKeys: String, CodingKey {
        case name, mmid, aeba, mbeba, accRefNumber, ifsc, maskedAccnumber, status, type, vpa, dLength, dType, balance, balTime
    }
}



struct UPIGAddress: Codable {
    var customerid: String
    var vpa: String
    var regIdType: String
    var regIdValue: String
    var action: String
    var subtype: String
    var note: String?
    var consent :String
    var mobile: String
//    var geocode: String?
//    var location: String?
//    var ip: String?
//    var type: String?
//    var id: String?
//    var os: String?
//    var app: String?
//    var capability: String?
//    var gcmid: String?
    var telecom: String?
//    var txnId:String?
    

    enum CodingKeys: String, CodingKey {
        case customerid, vpa, regIdType, regIdValue, action, subtype, note, consent, mobile, telecom
        //     geocode, location, ip, type, id, os,app,capability, gcmid, telecom,txnId
    }
}


struct UpiLinkToNumber: Codable {
    var customerid: String
    var vpa: String
    var regIdType: String
    var regIdValue: String
    var status:String
    var operationType: String
    var consent :String
    var note: String
    var prevVpa:String
    var mobile: String
  //  var deviceDetails:String
//    var mobile: String
//    var geocode: String
//    var location: String
//    var ip: String
//    var type: String
//    var id: String
//    var os: String
//    var app: String
//    var capability: String
//    var gcmid: String
//    var telecom: String
    

    enum CodingKeys: String, CodingKey {
        case customerid, vpa, regIdType, regIdValue,status, operationType, note,prevVpa, consent, mobile /* geocode, location, ip, type, id, os,app,capability, gcmid, telecom, deviceDetails*/
    }
}


struct UPIAddressRequest: Codable {
    let customerid: String
    let vpa: String
    let regIdType: String
    let regIdValue: String
    let action: String
    let subType: String
    let consent:String
    let note: String
    let mobile: String
    let geocode: String
    let location: String
    let ip: String
    let type: String
    let id: String
    let os: String
    let app: String
    let capability: String
    let gcmid: String
    let telecom: String
}



struct RegMapper {
    let customerid: String?
    let vpa: String?
    let regIdType: String?
    let regIdValue: String
    let status: String?
    let operationType: String?
    let consent: String?
    let note: String?
    let prevVpa: String?
    let deviceDetails: DeviceDetails
}


struct DeviceDetails {
    let mobile: String?
    let geocode: String?
    let location: String?
    let ip: String?
    let type: String?
    let id: String?
    let os: String?
    let app: String?
    let capability: String?
    let gcmid: String?
    let telecom: String?
}
