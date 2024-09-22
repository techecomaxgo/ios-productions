
import Foundation



struct Plans : Codable {
    
    let fULLTT : [FULLTT]?
    let tOPUP : [TOPUP]?
    let dATA : [DATA]?
    let sMS : String?
    let rATE_CUTTER : String?
    let twoG : String?
    let romaing : [Romaing]?
    let cOMBO : String?
    let fRC : [FRC]?
    let jioPhone : [JioPhone]?
    //let sTV : String?
    let sTV : [STV]?
    
    enum CodingKeys: String, CodingKey {

        case fULLTT = "FULLTT"
        case tOPUP = "TOPUP"
        case dATA = "DATA"
        case sMS = "SMS"
        case rATE_CUTTER = "RATE_CUTTER"
        case twoG = "TwoG"
        case romaing = "Romaing"
        case cOMBO = "COMBO"
        case fRC = "FRC"
        case jioPhone = "JioPhone"
        case sTV = "STV"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fULLTT = try values.decodeIfPresent([FULLTT].self, forKey: .fULLTT)
        tOPUP = try values.decodeIfPresent([TOPUP].self, forKey: .tOPUP)
        dATA = try values.decodeIfPresent([DATA].self, forKey: .dATA)
        sMS = try values.decodeIfPresent(String.self, forKey: .sMS)
        rATE_CUTTER = try values.decodeIfPresent(String.self, forKey: .rATE_CUTTER)
        twoG = try values.decodeIfPresent(String.self, forKey: .twoG)
        romaing = try values.decodeIfPresent([Romaing].self, forKey: .romaing)
        cOMBO = try values.decodeIfPresent(String.self, forKey: .cOMBO)
        fRC = try values.decodeIfPresent([FRC].self, forKey: .fRC)
        jioPhone = try values.decodeIfPresent([JioPhone].self, forKey: .jioPhone)
        //sTV = try values.decodeIfPresent(String.self, forKey: .sTV)
        sTV = try values.decodeIfPresent([STV].self, forKey: .sTV)

    }

}

