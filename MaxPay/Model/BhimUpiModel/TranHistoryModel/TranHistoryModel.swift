//
//  TranHistoryModel.swift
//  MaxPay
//
//  Created by Ios Developer on 30/01/24.
//

import Foundation

struct TranHistoryModel: Codable {
    
    var amount: String?
    var beneficiaryName: String?
    var creditAccount: String?
    var creditBankName: String?
    var creditVpa: String?
    var dateTime: String?
    var debitAccount: String?
    var debitBankName: String?
    var debitVpa: String?
    var expirydateTime: String?
    var initMode: String?
    var input: String?
    var mcc: String?
    var merchantflag: String?
    var mobilenumber: String?
    var purposeCode: String?
    var query: String?
    var queryCloserComment: String?
    var queryStatus: String?
    var querydate: String?
    var queryid: String?
    var refCategory: String?
    var refid: String?
    var refurl: String?
    var remarks: String?
    var remitterName: String?
    var status: String?
    var tranid: String?
    var type: String?
    var disputeStatus: String?

    
    
    enum CodingKeys: CodingKey {
        case amount
        case beneficiaryName
        case creditAccount
        case creditBankName
        case creditVpa
        case dateTime
        case debitAccount
        case disputeStatus
        case debitBankName
        case debitVpa
        case expirydateTime
        case initMode
        case input
        case mcc
        case merchantflag
        case mobilenumber
        case purposeCode
        case query
        case queryCloserComment
        case queryStatus
        case querydate
        case queryid
        case refCategory
        case refid
        case refurl
        case remarks
        case remitterName
        case status
        case tranid
        case type
    }
}





import Foundation

struct RaiseTransactionData: Codable {
    var result: String?
    var code: String?
    var checkSum: String?
    var data: TransactionDataRaise?
}

struct TransactionDataRaise: Codable {
    var amount: String?
    var beneReversalRespCode: String?
    var beneficiaryName: String?
    var creditAccount: String?
    var creditBankName: String?
    var creditVpa: String?
    var creditdebittype: String?
    var dateTime: String?
    var debitAccount: String?
    var debitBankName: String?
    var debitVpa: String?
    var description: String?
    var disputeRc: String?
    var disputeStatus: String?
    var expirydateTime: String?
    var initiatedby: String?
    var initmode: String?
    var input: String?
    var mcc: String?
    var merchantflag: String?
    var mobilenumber: String?
    var purposecode: String?
    var query: String?
    var queryCloserComment: String?
    var queryStatus: String?
    var querydate: String?
    var queryid: String?
    var refCategory: String?
    var refid: Int?
    var refurl: String?
    var remarks: String?
    var remitterName: String?
    var remitterReversalRespCode: String?
    var status: String?
    var subtype: String?
    var tranid: String?
    var type: String?
    var udir: String?
    var umn: String?
}




struct ReqComplientVo: Codable {
    var orgTxnId: String?
    var reqAdjFlag: String?
    var reqAdjCode: String?
    var initiationMode: String?
    var subType: String?
    var type: String?
   
    enum CodingKeys: CodingKey {
        case orgTxnId
        case reqAdjFlag
        case reqAdjCode
        case initiationMode
        case subType
        case type
    }
}







struct MandateListModel: Codable {
    
    
    var amount : String?
    var amountRule : String?
    var amountRuleValue : String?
    var beneName : String?
    var createdate : String?
    var expdate : String?
    var initmode : String?
    var isrevokable : String?
    var mandatetype : String?
    var merchantflag : String?
    var mobile : String?
    var notes : String?
    var payeeVpa : String?
    var payerVpa : String?
    var purposecode : String?
    var recurrencePattern : String?
    var recurrenceruletype : String?
    var recurrencerulevalue : String?
    var refid : String?
    var refurl : String?
    var rule_type : String?
    var rule_value : String?
    var sharewithpayee : String?
    var status : String?
    var txnid : String?
    var umn : String?
    var validity_end : String?
    var validity_start : String?
    
    enum CodingKeys: CodingKey {
        case amount
        case amountRule
        case amountRuleValue
        case beneName
        case createdate
        case expdate
        case initmode
        case isrevokable
        case mandatetype
        case merchantflag
        case mobile
        case notes
        case payeeVpa
        case payerVpa
        case purposecode
        case recurrencePattern
        case recurrenceruletype
        case recurrencerulevalue
        case refid
        case refurl
        case rule_type
        case rule_value
        case sharewithpayee
        case status
        case txnid
        case umn
        case validity_end
        case validity_start
    }
    
}

struct MandateTransactionModel: Codable {
    
    var amount: String?
    var amountRule: String?
    var createdDate: String?
    var mandateName: String?
    var mandateType: String?
    var payeeAccountName: String?
    var payeeAccountType: String?
    var payeeIfsc: String?
    var payeeMobile: String?
    var payeeStatus: String? // S-SUCCESS, F-FAILURE, R-REVOKED, P-PAUSED, C-COMPLETED, D-DECLINED, E-EXPIRED
    var payeeType: String?
    var payeeVpa: String?
    var payeename: String?
    var payerAccountName: String?
    var payerAccountNumber: String?
    var payerAccountType: String?
    var payerIfsc: String?
    var payerMobile: String?
    var payerStatus: String? // S-SUCCESS, F-FAILURE, R-REVOKED, P-PAUSED, C-COMPLETED, D-DECLINED, E-EXPIRED
    var payerType: String?
    var payerVpa: String?
    var payername: String?
    var recurrencePattern: String?
    var recurrenceRuleType: String?
    var refUrl: String?
    var shareToPayee: String?
    var txnid: String?
    var umn: String?
    var updatedDate: String?
    var validity_end : String?
    var validity_start : String?


    enum CodingKeys: CodingKey {
        case amount
        case amountRule
        case createdDate
        case mandateName
        case mandateType
        case payeeAccountName
        case payeeAccountType
        case payeeIfsc
        case payeeMobile
        case payeeStatus
        case payeeType
        case payeeVpa
        case payeename
        case payerAccountName
        case payerAccountNumber
        case payerAccountType
        case payerIfsc
        case payerMobile
        case payerStatus
        case payerType
        case payerVpa
        case payername
        case recurrencePattern
        case recurrenceRuleType
        case refUrl
        case shareToPayee
        case txnid
        case umn
        case updatedDate
        case validity_end
        case validity_start

    }
    
}

struct PauseMandateInput: Codable {
    
    var umn: String?
    var mandatetype:String
    var remark: String?
    var purpose : String?
    var sharetopayee : String?
    var validitystart : String?
    var validityend : String?
    var mandatename : String?
    var revocable: String?
    var amountrule:String?
    var amount: String?
    var recurrence: String?
    var rulevalue: String?
    var ruletype: String?
    
    var executebypayeepsp:String?
    var blockfund:String?
    var monthlylimit:String?
   // var recurrenceValue:String?

    
    var mcc:String?
    var initmode:String?
    var orderid:String?
    var refcategory:String?
    var refurl:String?

    //var txnid: String?
   // var action: String?
    //var merchanttxnid: String?

    enum CodingKeys: CodingKey {
        
        case umn
        case mandatetype
        case remark
        case purpose
        case sharetopayee
        case validitystart
        case validityend
        case mandatename
        case revocable
        case amountrule
        case amount
        case recurrence
        case rulevalue
        case ruletype
        case executebypayeepsp
        case blockfund
        case monthlylimit
       // case recurrenceValue
        case mcc
        case initmode

        case orderid
        case refcategory
        case refurl
        
    }
}


struct CreateMandateInput: Codable {
    var umn: String
    var mandatetype: String
    var remark: String
    //var note : String
    var purpose: String
    var sharetopayee: String
    var validitystart: String
    var validityend: String
    var mandatename: String
    var revocable: String
    var amountrule: String
    var amount: String
    var recurrence: String
    var rulevalue: String
    var ruletype: String
    var executebypayeepsp: String
    var blockfund: String
    var monthlylimit: String
    var recurrenceValue: String
    var mcc: String
    var initmode: String
    var orderid: String
    var refcategory: String
    var refurl: String

    enum CodingKeys: String, CodingKey {
        case umn
        case mandatetype
        case remark
     //   case note
        case purpose
        case sharetopayee
        case validitystart
        case validityend
        case mandatename
        case revocable
        case amountrule
        case amount
        case recurrence
        case rulevalue
        case ruletype
        case executebypayeepsp
        case blockfund
        case monthlylimit
        case recurrenceValue
        case mcc
        case initmode
        case orderid
        case refcategory
        case refurl
    }
}

struct UpdatableMandateInput: Codable {
    
    var umn: String?
    var remarks: String?
    var mcc:String?
    var payermobile:String?
    var purpose : String?
    var sharetopayee : String?
    var validitystart : String?
    var validityend : String?
    var mandatename : String?
    var revocable: String?
    var amountrule:String?
    var amount: String?
    var recurrence: String?
    var rulevalue: String?
    var ruletype: String?
    var initiatedby : String?

    //var txnid: String?
   // var action: String?
    //var merchanttxnid: String?

    enum CodingKeys: CodingKey {
        case umn
        case remarks
        case mcc
        case payermobile
        case purpose
        //case merchanttxnid
        case sharetopayee
        case validitystart
        case validityend
        case mandatename
        case revocable
        //case merchanttxnid
        
        case amountrule
        case amount
        case recurrence
        case rulevalue
        case ruletype
        //case merchanttxnid
        case initiatedby
        
    }
}



struct MandateInput: Codable {
    
    var amount: String?
    var remark: String?
    var txnid: String?
    var umn: String?
    var action: String?
    //var merchanttxnid: String?

    enum CodingKeys: CodingKey {
        case amount
        case remark
        case txnid
        case umn
        case action
        //case merchanttxnid
    }
}


struct CheckStatusInput: Codable {
    
    var mobilenumber: String?
    var tranid: String?
    var initiatedby : String?
    var subtype: String?
    var rrn:String?
    var orderid:String
    var flag :String
    

    enum CodingKeys: CodingKey {
        case mobilenumber
        case tranid
        case initiatedby
        case subtype
        case rrn
        case orderid
        case flag
    }
}




struct baneVpaModel: Codable {
    
   var vpa: String?
    var name: String?

    enum CodingKeys: CodingKey {
        
        case vpa
        case name
    }
}


struct BlockListModel: Codable {
    
    var appid: String?
    var block: String?
    var customerid: String?
    var input: String?
    var reason: String?
    var vpa: String?
    
    enum CodingKeys: CodingKey {
        case appid
        case block
        case customerid
        case input
        case reason
        case vpa
    }
    
}

