import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "black-color" asset catalog color resource.
    static let black = DeveloperToolsSupport.ColorResource(name: "black-color", bundle: resourceBundle)

    /// The "card-number" asset catalog color resource.
    static let cardNumber = DeveloperToolsSupport.ColorResource(name: "card-number", bundle: resourceBundle)

    #warning("The \"card-number-color\" color asset name resolves to the symbol \"cardNumber\" which already exists. Try renaming the asset.")

    /// The "grey" asset catalog color resource.
    static let grey = DeveloperToolsSupport.ColorResource(name: "grey", bundle: resourceBundle)

    /// The "grey-chip-color" asset catalog color resource.
    static let greyChip = DeveloperToolsSupport.ColorResource(name: "grey-chip-color", bundle: resourceBundle)

    /// The "grey-line-color" asset catalog color resource.
    static let greyLine = DeveloperToolsSupport.ColorResource(name: "grey-line-color", bundle: resourceBundle)

    /// The "ladies-sit- border-red-color" asset catalog color resource.
    static let ladiesSitBorderRed = DeveloperToolsSupport.ColorResource(name: "ladies-sit- border-red-color", bundle: resourceBundle)

    /// The "miles-logo-red" asset catalog color resource.
    static let milesLogoRed = DeveloperToolsSupport.ColorResource(name: "miles-logo-red", bundle: resourceBundle)

    /// The "pay-card-bg-color" asset catalog color resource.
    static let payCardBg = DeveloperToolsSupport.ColorResource(name: "pay-card-bg-color", bundle: resourceBundle)

    /// The "pink-color" asset catalog color resource.
    static let pink = DeveloperToolsSupport.ColorResource(name: "pink-color", bundle: resourceBundle)

    /// The "primary-green" asset catalog color resource.
    static let primaryGreen = DeveloperToolsSupport.ColorResource(name: "primary-green", bundle: resourceBundle)

    /// The "reload-grey-color" asset catalog color resource.
    static let reloadGrey = DeveloperToolsSupport.ColorResource(name: "reload-grey-color", bundle: resourceBundle)

    /// The "secondary-green" asset catalog color resource.
    static let secondaryGreen = DeveloperToolsSupport.ColorResource(name: "secondary-green", bundle: resourceBundle)

    /// The "status-red-color" asset catalog color resource.
    static let statusRed = DeveloperToolsSupport.ColorResource(name: "status-red-color", bundle: resourceBundle)

    /// The "text-red-color" asset catalog color resource.
    static let textRed = DeveloperToolsSupport.ColorResource(name: "text-red-color", bundle: resourceBundle)

    /// The "theme_green" asset catalog color resource.
    static let themeGreen = DeveloperToolsSupport.ColorResource(name: "theme_green", bundle: resourceBundle)

    /// The "theme_green_light" asset catalog color resource.
    static let themeGreenLight = DeveloperToolsSupport.ColorResource(name: "theme_green_light", bundle: resourceBundle)

    /// The "theme_text_dark" asset catalog color resource.
    static let themeTextDark = DeveloperToolsSupport.ColorResource(name: "theme_text_dark", bundle: resourceBundle)

    /// The "theme_text_dark2" asset catalog color resource.
    static let themeTextDark2 = DeveloperToolsSupport.ColorResource(name: "theme_text_dark2", bundle: resourceBundle)

    /// The "white-color" asset catalog color resource.
    static let white = DeveloperToolsSupport.ColorResource(name: "white-color", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "AC" asset catalog image resource.
    static let AC = DeveloperToolsSupport.ImageResource(name: "AC", bundle: resourceBundle)

    /// The "Beneficiary" asset catalog image resource.
    static let beneficiary = DeveloperToolsSupport.ImageResource(name: "Beneficiary", bundle: resourceBundle)

    /// The "Blanket" asset catalog image resource.
    static let blanket = DeveloperToolsSupport.ImageResource(name: "Blanket", bundle: resourceBundle)

    /// The "Block List" asset catalog image resource.
    static let blockList = DeveloperToolsSupport.ImageResource(name: "Block List", bundle: resourceBundle)

    /// The "Charging-Point" asset catalog image resource.
    static let chargingPoint = DeveloperToolsSupport.ImageResource(name: "Charging-Point", bundle: resourceBundle)

    /// The "DeRegister UPI" asset catalog image resource.
    static let deRegisterUPI = DeveloperToolsSupport.ImageResource(name: "DeRegister UPI", bundle: resourceBundle)

    /// The "Emergency-Exit" asset catalog image resource.
    static let emergencyExit = DeveloperToolsSupport.ImageResource(name: "Emergency-Exit", bundle: resourceBundle)

    /// The "Fire-Extinguisher" asset catalog image resource.
    static let fireExtinguisher = DeveloperToolsSupport.ImageResource(name: "Fire-Extinguisher", bundle: resourceBundle)

    /// The "First-Aid-Box" asset catalog image resource.
    static let firstAidBox = DeveloperToolsSupport.ImageResource(name: "First-Aid-Box", bundle: resourceBundle)

    /// The "FloatingControlBg" asset catalog image resource.
    static let floatingControlBg = DeveloperToolsSupport.ImageResource(name: "FloatingControlBg", bundle: resourceBundle)

    /// The "FloatingMenuBG" asset catalog image resource.
    static let floatingMenuBG = DeveloperToolsSupport.ImageResource(name: "FloatingMenuBG", bundle: resourceBundle)

    /// The "GPS-Tracking" asset catalog image resource.
    static let gpsTracking = DeveloperToolsSupport.ImageResource(name: "GPS-Tracking", bundle: resourceBundle)

    /// The "Hammer" asset catalog image resource.
    static let hammer = DeveloperToolsSupport.ImageResource(name: "Hammer", bundle: resourceBundle)

    /// The "Hand-Sanitizer" asset catalog image resource.
    static let handSanitizer = DeveloperToolsSupport.ImageResource(name: "Hand-Sanitizer", bundle: resourceBundle)

    /// The "Image" asset catalog image resource.
    static let image = DeveloperToolsSupport.ImageResource(name: "Image", bundle: resourceBundle)

    /// The "Intro1" asset catalog image resource.
    static let intro1 = DeveloperToolsSupport.ImageResource(name: "Intro1", bundle: resourceBundle)

    /// The "Intro2" asset catalog image resource.
    static let intro2 = DeveloperToolsSupport.ImageResource(name: "Intro2", bundle: resourceBundle)

    /// The "Intro3" asset catalog image resource.
    static let intro3 = DeveloperToolsSupport.ImageResource(name: "Intro3", bundle: resourceBundle)

    /// The "Intro4" asset catalog image resource.
    static let intro4 = DeveloperToolsSupport.ImageResource(name: "Intro4", bundle: resourceBundle)

    /// The "Intro5" asset catalog image resource.
    static let intro5 = DeveloperToolsSupport.ImageResource(name: "Intro5", bundle: resourceBundle)

    /// The "Manage UPI ID" asset catalog image resource.
    static let manageUPIID = DeveloperToolsSupport.ImageResource(name: "Manage UPI ID", bundle: resourceBundle)

    /// The "Manage UPI Number" asset catalog image resource.
    static let manageUPINumber = DeveloperToolsSupport.ImageResource(name: "Manage UPI Number", bundle: resourceBundle)

    /// The "Pillow" asset catalog image resource.
    static let pillow = DeveloperToolsSupport.ImageResource(name: "Pillow", bundle: resourceBundle)

    /// The "Qeflight" asset catalog image resource.
    static let qeflight = DeveloperToolsSupport.ImageResource(name: "Qeflight", bundle: resourceBundle)

    /// The "Reading-Light" asset catalog image resource.
    static let readingLight = DeveloperToolsSupport.ImageResource(name: "Reading-Light", bundle: resourceBundle)

    /// The "Rectanglecard" asset catalog image resource.
    static let rectanglecard = DeveloperToolsSupport.ImageResource(name: "Rectanglecard", bundle: resourceBundle)

    /// The "Remove All Cache" asset catalog image resource.
    static let removeAllCache = DeveloperToolsSupport.ImageResource(name: "Remove All Cache", bundle: resourceBundle)

    /// The "Request Money" asset catalog image resource.
    static let requestMoney = DeveloperToolsSupport.ImageResource(name: "Request Money", bundle: resourceBundle)

    /// The "Request Money to Contact or UPI ID" asset catalog image resource.
    static let requestMoneyToContactOrUPIID = DeveloperToolsSupport.ImageResource(name: "Request Money to Contact or UPI ID", bundle: resourceBundle)

    /// The "Send Money to Bank Account" asset catalog image resource.
    static let sendMoneyToBankAccount = DeveloperToolsSupport.ImageResource(name: "Send Money to Bank Account", bundle: resourceBundle)

    /// The "Send Money to Contact or UPI ID" asset catalog image resource.
    static let sendMoneyToContactOrUPIID = DeveloperToolsSupport.ImageResource(name: "Send Money to Contact or UPI ID", bundle: resourceBundle)

    /// The "Staff" asset catalog image resource.
    static let staff = DeveloperToolsSupport.ImageResource(name: "Staff", bundle: resourceBundle)

    /// The "TV" asset catalog image resource.
    static let TV = DeveloperToolsSupport.ImageResource(name: "TV", bundle: resourceBundle)

    /// The "Toilet" asset catalog image resource.
    static let toilet = DeveloperToolsSupport.ImageResource(name: "Toilet", bundle: resourceBundle)

    /// The "Transaction History" asset catalog image resource.
    static let transactionHistory = DeveloperToolsSupport.ImageResource(name: "Transaction History", bundle: resourceBundle)

    /// The "UPI Autopay" asset catalog image resource.
    static let upiAutopay = DeveloperToolsSupport.ImageResource(name: "UPI Autopay", bundle: resourceBundle)

    /// The "UPIIconIImage" asset catalog image resource.
    static let upiIconI = DeveloperToolsSupport.ImageResource(name: "UPIIconIImage", bundle: resourceBundle)

    /// The "UPIPayment" asset catalog image resource.
    static let upiPayment = DeveloperToolsSupport.ImageResource(name: "UPIPayment", bundle: resourceBundle)

    /// The "Water-Bottle" asset catalog image resource.
    static let waterBottle = DeveloperToolsSupport.ImageResource(name: "Water-Bottle", bundle: resourceBundle)

    /// The "WiFi" asset catalog image resource.
    static let wiFi = DeveloperToolsSupport.ImageResource(name: "WiFi", bundle: resourceBundle)

    /// The "add" asset catalog image resource.
    static let add = DeveloperToolsSupport.ImageResource(name: "add", bundle: resourceBundle)

    /// The "addFPop" asset catalog image resource.
    static let addFPop = DeveloperToolsSupport.ImageResource(name: "addFPop", bundle: resourceBundle)

    /// The "addpriv" asset catalog image resource.
    static let addpriv = DeveloperToolsSupport.ImageResource(name: "addpriv", bundle: resourceBundle)

    /// The "avSeat" asset catalog image resource.
    static let avSeat = DeveloperToolsSupport.ImageResource(name: "avSeat", bundle: resourceBundle)

    /// The "backarrow" asset catalog image resource.
    static let backarrow = DeveloperToolsSupport.ImageResource(name: "backarrow", bundle: resourceBundle)

    /// The "backgroundImg" asset catalog image resource.
    static let backgroundImg = DeveloperToolsSupport.ImageResource(name: "backgroundImg", bundle: resourceBundle)

    /// The "bank_logo" asset catalog image resource.
    static let bankLogo = DeveloperToolsSupport.ImageResource(name: "bank_logo", bundle: resourceBundle)

    /// The "bannerQuiz" asset catalog image resource.
    static let bannerQuiz = DeveloperToolsSupport.ImageResource(name: "bannerQuiz", bundle: resourceBundle)

    /// The "barcodeFlight" asset catalog image resource.
    static let barcodeFlight = DeveloperToolsSupport.ImageResource(name: "barcodeFlight", bundle: resourceBundle)

    /// The "bbps_logo" asset catalog image resource.
    static let bbpsLogo = DeveloperToolsSupport.ImageResource(name: "bbps_logo", bundle: resourceBundle)

    /// The "beneficiary-name-ic" asset catalog image resource.
    static let beneficiaryNameIc = DeveloperToolsSupport.ImageResource(name: "beneficiary-name-ic", bundle: resourceBundle)

    /// The "beneficiary-upiid-ic" asset catalog image resource.
    static let beneficiaryUpiidIc = DeveloperToolsSupport.ImageResource(name: "beneficiary-upiid-ic", bundle: resourceBundle)

    /// The "bg-home-header-green" asset catalog image resource.
    static let bgHomeHeaderGreen = DeveloperToolsSupport.ImageResource(name: "bg-home-header-green", bundle: resourceBundle)

    /// The "bg-home-header-white" asset catalog image resource.
    static let bgHomeHeaderWhite = DeveloperToolsSupport.ImageResource(name: "bg-home-header-white", bundle: resourceBundle)

    /// The "bhim" asset catalog image resource.
    static let bhim = DeveloperToolsSupport.ImageResource(name: "bhim", bundle: resourceBundle)

    /// The "bhim-upi-ic" asset catalog image resource.
    static let bhimUpiIc = DeveloperToolsSupport.ImageResource(name: "bhim-upi-ic", bundle: resourceBundle)

    /// The "bhimImg" asset catalog image resource.
    static let bhimImg = DeveloperToolsSupport.ImageResource(name: "bhimImg", bundle: resourceBundle)

    /// The "bill" asset catalog image resource.
    static let bill = DeveloperToolsSupport.ImageResource(name: "bill", bundle: resourceBundle)

    /// The "black_seat" asset catalog image resource.
    static let blackSeat = DeveloperToolsSupport.ImageResource(name: "black_seat", bundle: resourceBundle)

    /// The "bnkImg" asset catalog image resource.
    static let bnkImg = DeveloperToolsSupport.ImageResource(name: "bnkImg", bundle: resourceBundle)

    /// The "bookedSeat" asset catalog image resource.
    static let bookedSeat = DeveloperToolsSupport.ImageResource(name: "bookedSeat", bundle: resourceBundle)

    /// The "borderGreenPic" asset catalog image resource.
    static let borderGreenPic = DeveloperToolsSupport.ImageResource(name: "borderGreenPic", bundle: resourceBundle)

    /// The "bus-drop-point-tab" asset catalog image resource.
    static let busDropPointTab = DeveloperToolsSupport.ImageResource(name: "bus-drop-point-tab", bundle: resourceBundle)

    /// The "bus-pickup-point-tab" asset catalog image resource.
    static let busPickupPointTab = DeveloperToolsSupport.ImageResource(name: "bus-pickup-point-tab", bundle: resourceBundle)

    /// The "bus-select-seat-tab" asset catalog image resource.
    static let busSelectSeatTab = DeveloperToolsSupport.ImageResource(name: "bus-select-seat-tab", bundle: resourceBundle)

    /// The "bus-serchticket-bg" asset catalog image resource.
    static let busSerchticketBg = DeveloperToolsSupport.ImageResource(name: "bus-serchticket-bg", bundle: resourceBundle)

    /// The "calender-history-ic" asset catalog image resource.
    static let calenderHistoryIc = DeveloperToolsSupport.ImageResource(name: "calender-history-ic", bundle: resourceBundle)

    /// The "card" asset catalog image resource.
    static let card = DeveloperToolsSupport.ImageResource(name: "card", bundle: resourceBundle)

    /// The "card-bgview-ic" asset catalog image resource.
    static let cardBgviewIc = DeveloperToolsSupport.ImageResource(name: "card-bgview-ic", bundle: resourceBundle)

    /// The "card-chip-ic" asset catalog image resource.
    static let cardChipIc = DeveloperToolsSupport.ImageResource(name: "card-chip-ic", bundle: resourceBundle)

    /// The "card-home-upper" asset catalog image resource.
    static let cardHomeUpper = DeveloperToolsSupport.ImageResource(name: "card-home-upper", bundle: resourceBundle)

    /// The "card-uparrow-ic" asset catalog image resource.
    static let cardUparrowIc = DeveloperToolsSupport.ImageResource(name: "card-uparrow-ic", bundle: resourceBundle)

    /// The "cardBBack" asset catalog image resource.
    static let cardBBack = DeveloperToolsSupport.ImageResource(name: "cardBBack", bundle: resourceBundle)

    /// The "cardBackPro" asset catalog image resource.
    static let cardBackPro = DeveloperToolsSupport.ImageResource(name: "cardBackPro", bundle: resourceBundle)

    /// The "cardFBack" asset catalog image resource.
    static let cardFBack = DeveloperToolsSupport.ImageResource(name: "cardFBack", bundle: resourceBundle)

    /// The "cardGrBack" asset catalog image resource.
    static let cardGrBack = DeveloperToolsSupport.ImageResource(name: "cardGrBack", bundle: resourceBundle)

    /// The "cardRBack" asset catalog image resource.
    static let cardRBack = DeveloperToolsSupport.ImageResource(name: "cardRBack", bundle: resourceBundle)

    /// The "catagory_bg" asset catalog image resource.
    static let catagoryBg = DeveloperToolsSupport.ImageResource(name: "catagory_bg", bundle: resourceBundle)

    /// The "catagory_item" asset catalog image resource.
    static let catagoryItem = DeveloperToolsSupport.ImageResource(name: "catagory_item", bundle: resourceBundle)

    /// The "chainPic" asset catalog image resource.
    static let chainPic = DeveloperToolsSupport.ImageResource(name: "chainPic", bundle: resourceBundle)

    /// The "chainProgressLine" asset catalog image resource.
    static let chainProgressLine = DeveloperToolsSupport.ImageResource(name: "chainProgressLine", bundle: resourceBundle)

    /// The "chainTopImg" asset catalog image resource.
    static let chainTopImg = DeveloperToolsSupport.ImageResource(name: "chainTopImg", bundle: resourceBundle)

    /// The "check" asset catalog image resource.
    static let check = DeveloperToolsSupport.ImageResource(name: "check", bundle: resourceBundle)

    /// The "circle-boarding-notselected" asset catalog image resource.
    static let circleBoardingNotselected = DeveloperToolsSupport.ImageResource(name: "circle-boarding-notselected", bundle: resourceBundle)

    /// The "circle-boarding-selected" asset catalog image resource.
    static let circleBoardingSelected = DeveloperToolsSupport.ImageResource(name: "circle-boarding-selected", bundle: resourceBundle)

    /// The "claimBg" asset catalog image resource.
    static let claimBg = DeveloperToolsSupport.ImageResource(name: "claimBg", bundle: resourceBundle)

    /// The "close" asset catalog image resource.
    static let close = DeveloperToolsSupport.ImageResource(name: "close", bundle: resourceBundle)

    /// The "close-button-ic" asset catalog image resource.
    static let closeButtonIc = DeveloperToolsSupport.ImageResource(name: "close-button-ic", bundle: resourceBundle)

    /// The "complaint-submitted-ic" asset catalog image resource.
    static let complaintSubmittedIc = DeveloperToolsSupport.ImageResource(name: "complaint-submitted-ic", bundle: resourceBundle)

    /// The "complete_statusImg" asset catalog image resource.
    static let completeStatusImg = DeveloperToolsSupport.ImageResource(name: "complete_statusImg", bundle: resourceBundle)

    /// The "conplaint-home" asset catalog image resource.
    static let conplaintHome = DeveloperToolsSupport.ImageResource(name: "conplaint-home", bundle: resourceBundle)

    /// The "createQRMandateVC" asset catalog image resource.
    static let createQRMandateVC = DeveloperToolsSupport.ImageResource(name: "createQRMandateVC", bundle: resourceBundle)

    /// The "deactivePhone" asset catalog image resource.
    static let deactivePhone = DeveloperToolsSupport.ImageResource(name: "deactivePhone", bundle: resourceBundle)

    /// The "debit_cd_back" asset catalog image resource.
    static let debitCdBack = DeveloperToolsSupport.ImageResource(name: "debit_cd_back", bundle: resourceBundle)

    /// The "debit_image" asset catalog image resource.
    static let debit = DeveloperToolsSupport.ImageResource(name: "debit_image", bundle: resourceBundle)

    /// The "default_maxpe_profile" asset catalog image resource.
    static let defaultMaxpeProfile = DeveloperToolsSupport.ImageResource(name: "default_maxpe_profile", bundle: resourceBundle)

    /// The "default_maxpe_profile 1" asset catalog image resource.
    static let defaultMaxpeProfile1 = DeveloperToolsSupport.ImageResource(name: "default_maxpe_profile 1", bundle: resourceBundle)

    /// The "delete" asset catalog image resource.
    static let delete = DeveloperToolsSupport.ImageResource(name: "delete", bundle: resourceBundle)

    /// The "dotted-horizontal-line-ic" asset catalog image resource.
    static let dottedHorizontalLineIc = DeveloperToolsSupport.ImageResource(name: "dotted-horizontal-line-ic", bundle: resourceBundle)

    /// The "dotted-vertical-line-ic" asset catalog image resource.
    static let dottedVerticalLineIc = DeveloperToolsSupport.ImageResource(name: "dotted-vertical-line-ic", bundle: resourceBundle)

    /// The "dotted-vertical-point-line-ic" asset catalog image resource.
    static let dottedVerticalPointLineIc = DeveloperToolsSupport.ImageResource(name: "dotted-vertical-point-line-ic", bundle: resourceBundle)

    /// The "downld" asset catalog image resource.
    static let downld = DeveloperToolsSupport.ImageResource(name: "downld", bundle: resourceBundle)

    /// The "eclanatyionmark" asset catalog image resource.
    static let eclanatyionmark = DeveloperToolsSupport.ImageResource(name: "eclanatyionmark", bundle: resourceBundle)

    /// The "elipse" asset catalog image resource.
    static let elipse = DeveloperToolsSupport.ImageResource(name: "elipse", bundle: resourceBundle)

    #warning("The \"emergencyExit\" image asset name resolves to the symbol \"emergencyExit\" which already exists. Try renaming the asset.")

    /// The "english" asset catalog image resource.
    static let english = DeveloperToolsSupport.ImageResource(name: "english", bundle: resourceBundle)

    /// The "enter_pin_screen_bg" asset catalog image resource.
    static let enterPinScreenBg = DeveloperToolsSupport.ImageResource(name: "enter_pin_screen_bg", bundle: resourceBundle)

    /// The "extraLSeat" asset catalog image resource.
    static let extraLSeat = DeveloperToolsSupport.ImageResource(name: "extraLSeat", bundle: resourceBundle)

    /// The "eye-ic" asset catalog image resource.
    static let eyeIc = DeveloperToolsSupport.ImageResource(name: "eye-ic", bundle: resourceBundle)

    /// The "failed" asset catalog image resource.
    static let failed = DeveloperToolsSupport.ImageResource(name: "failed", bundle: resourceBundle)

    /// The "filter-history-ic" asset catalog image resource.
    static let filterHistoryIc = DeveloperToolsSupport.ImageResource(name: "filter-history-ic", bundle: resourceBundle)

    /// The "flash-off-ic" asset catalog image resource.
    static let flashOffIc = DeveloperToolsSupport.ImageResource(name: "flash-off-ic", bundle: resourceBundle)

    /// The "flash-on-ic" asset catalog image resource.
    static let flashOnIc = DeveloperToolsSupport.ImageResource(name: "flash-on-ic", bundle: resourceBundle)

    /// The "flightFromto" asset catalog image resource.
    static let flightFromto = DeveloperToolsSupport.ImageResource(name: "flightFromto", bundle: resourceBundle)

    /// The "flightPic" asset catalog image resource.
    static let flightPic = DeveloperToolsSupport.ImageResource(name: "flightPic", bundle: resourceBundle)

    /// The "flightTicketBackPic" asset catalog image resource.
    static let flightTicketBackPic = DeveloperToolsSupport.ImageResource(name: "flightTicketBackPic", bundle: resourceBundle)

    /// The "flightTopPic" asset catalog image resource.
    static let flightTopPic = DeveloperToolsSupport.ImageResource(name: "flightTopPic", bundle: resourceBundle)

    /// The "foundSmilyBgGreen" asset catalog image resource.
    static let foundSmilyBgGreen = DeveloperToolsSupport.ImageResource(name: "foundSmilyBgGreen", bundle: resourceBundle)

    /// The "green_seat" asset catalog image resource.
    static let greenSeat = DeveloperToolsSupport.ImageResource(name: "green_seat", bundle: resourceBundle)

    /// The "grey_seat" asset catalog image resource.
    static let greySeat = DeveloperToolsSupport.ImageResource(name: "grey_seat", bundle: resourceBundle)

    /// The "handle" asset catalog image resource.
    static let handle = DeveloperToolsSupport.ImageResource(name: "handle", bundle: resourceBundle)

    /// The "hotelsamplePic" asset catalog image resource.
    static let hotelsamplePic = DeveloperToolsSupport.ImageResource(name: "hotelsamplePic", bundle: resourceBundle)

    /// The "icComplaint" asset catalog image resource.
    static let icComplaint = DeveloperToolsSupport.ImageResource(name: "icComplaint", bundle: resourceBundle)

    /// The "icMaxUPI" asset catalog image resource.
    static let icMaxUPI = DeveloperToolsSupport.ImageResource(name: "icMaxUPI", bundle: resourceBundle)

    /// The "icProfile" asset catalog image resource.
    static let icProfile = DeveloperToolsSupport.ImageResource(name: "icProfile", bundle: resourceBundle)

    /// The "icScanQR" asset catalog image resource.
    static let icScanQR = DeveloperToolsSupport.ImageResource(name: "icScanQR", bundle: resourceBundle)

    /// The "icShareQR" asset catalog image resource.
    static let icShareQR = DeveloperToolsSupport.ImageResource(name: "icShareQR", bundle: resourceBundle)

    /// The "ic_arrow_back_24" asset catalog image resource.
    static let icArrowBack24 = DeveloperToolsSupport.ImageResource(name: "ic_arrow_back_24", bundle: resourceBundle)

    /// The "ic_arrow_down" asset catalog image resource.
    static let icArrowDown = DeveloperToolsSupport.ImageResource(name: "ic_arrow_down", bundle: resourceBundle)

    /// The "ic_arrow_up" asset catalog image resource.
    static let icArrowUp = DeveloperToolsSupport.ImageResource(name: "ic_arrow_up", bundle: resourceBundle)

    /// The "ic_baseline_add_circle_24" asset catalog image resource.
    static let icBaselineAddCircle24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_add_circle_24", bundle: resourceBundle)

    /// The "ic_baseline_block_24" asset catalog image resource.
    static let icBaselineBlock24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_block_24", bundle: resourceBundle)

    /// The "ic_baseline_calendar" asset catalog image resource.
    static let icBaselineCalendar = DeveloperToolsSupport.ImageResource(name: "ic_baseline_calendar", bundle: resourceBundle)

    /// The "ic_baseline_calendar_today_24" asset catalog image resource.
    static let icBaselineCalendarToday24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_calendar_today_24", bundle: resourceBundle)

    /// The "ic_baseline_history_24" asset catalog image resource.
    static let icBaselineHistory24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_history_24", bundle: resourceBundle)

    /// The "ic_baseline_keyboard_arrow_down_24" asset catalog image resource.
    static let icBaselineKeyboardArrowDown24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_keyboard_arrow_down_24", bundle: resourceBundle)

    /// The "ic_baseline_keyboard_arrow_right_24 1" asset catalog image resource.
    static let icBaselineKeyboardArrowRight241 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_keyboard_arrow_right_24 1", bundle: resourceBundle)

    /// The "ic_baseline_people_alt_24" asset catalog image resource.
    static let icBaselinePeopleAlt24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_people_alt_24", bundle: resourceBundle)

    /// The "ic_baseline_qr_code_24" asset catalog image resource.
    static let icBaselineQrCode24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_qr_code_24", bundle: resourceBundle)

    /// The "ic_baseline_search_24" asset catalog image resource.
    static let icBaselineSearch24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_search_24", bundle: resourceBundle)

    /// The "ic_baseline_sim_card_24" asset catalog image resource.
    static let icBaselineSimCard24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_sim_card_24", bundle: resourceBundle)

    /// The "ic_baseline_transfer" asset catalog image resource.
    static let icBaselineTransfer = DeveloperToolsSupport.ImageResource(name: "ic_baseline_transfer", bundle: resourceBundle)

    /// The "ic_baseline_trending_flat_24" asset catalog image resource.
    static let icBaselineTrendingFlat24 = DeveloperToolsSupport.ImageResource(name: "ic_baseline_trending_flat_24", bundle: resourceBundle)

    /// The "ic_home_transfer" asset catalog image resource.
    static let icHomeTransfer = DeveloperToolsSupport.ImageResource(name: "ic_home_transfer", bundle: resourceBundle)

    /// The "ic_onboarding_1" asset catalog image resource.
    static let icOnboarding1 = DeveloperToolsSupport.ImageResource(name: "ic_onboarding_1", bundle: resourceBundle)

    /// The "ic_options_bg" asset catalog image resource.
    static let icOptionsBg = DeveloperToolsSupport.ImageResource(name: "ic_options_bg", bundle: resourceBundle)

    /// The "idea-exchange" asset catalog image resource.
    static let ideaExchange = DeveloperToolsSupport.ImageResource(name: "idea-exchange", bundle: resourceBundle)

    /// The "imgThumb" asset catalog image resource.
    static let imgThumb = DeveloperToolsSupport.ImageResource(name: "imgThumb", bundle: resourceBundle)

    /// The "imgphone" asset catalog image resource.
    static let imgphone = DeveloperToolsSupport.ImageResource(name: "imgphone", bundle: resourceBundle)

    /// The "india" asset catalog image resource.
    static let india = DeveloperToolsSupport.ImageResource(name: "india", bundle: resourceBundle)

    /// The "info-ic" asset catalog image resource.
    static let infoIc = DeveloperToolsSupport.ImageResource(name: "info-ic", bundle: resourceBundle)

    /// The "infoPics" asset catalog image resource.
    static let infoPics = DeveloperToolsSupport.ImageResource(name: "infoPics", bundle: resourceBundle)

    /// The "itemBg" asset catalog image resource.
    static let itemBg = DeveloperToolsSupport.ImageResource(name: "itemBg", bundle: resourceBundle)

    /// The "itemBgLarge" asset catalog image resource.
    static let itemBgLarge = DeveloperToolsSupport.ImageResource(name: "itemBgLarge", bundle: resourceBundle)

    /// The "itemHeaderBg" asset catalog image resource.
    static let itemHeaderBg = DeveloperToolsSupport.ImageResource(name: "itemHeaderBg", bundle: resourceBundle)

    /// The "itemMenu" asset catalog image resource.
    static let itemMenu = DeveloperToolsSupport.ImageResource(name: "itemMenu", bundle: resourceBundle)

    /// The "itemPlaceholder" asset catalog image resource.
    static let itemPlaceholder = DeveloperToolsSupport.ImageResource(name: "itemPlaceholder", bundle: resourceBundle)

    /// The "lineFlight" asset catalog image resource.
    static let lineFlight = DeveloperToolsSupport.ImageResource(name: "lineFlight", bundle: resourceBundle)

    /// The "location" asset catalog image resource.
    static let location = DeveloperToolsSupport.ImageResource(name: "location", bundle: resourceBundle)

    /// The "location-pin" asset catalog image resource.
    static let locationPin = DeveloperToolsSupport.ImageResource(name: "location-pin", bundle: resourceBundle)

    /// The "logoPics" asset catalog image resource.
    static let logoPics = DeveloperToolsSupport.ImageResource(name: "logoPics", bundle: resourceBundle)

    /// The "logout_main" asset catalog image resource.
    static let logoutMain = DeveloperToolsSupport.ImageResource(name: "logout_main", bundle: resourceBundle)

    /// The "logoutback" asset catalog image resource.
    static let logoutback = DeveloperToolsSupport.ImageResource(name: "logoutback", bundle: resourceBundle)

    /// The "lost-and-found" asset catalog image resource.
    static let lostAndFound = DeveloperToolsSupport.ImageResource(name: "lost-and-found", bundle: resourceBundle)

    /// The "lostSmilyGreen" asset catalog image resource.
    static let lostSmilyGreen = DeveloperToolsSupport.ImageResource(name: "lostSmilyGreen", bundle: resourceBundle)

    /// The "lowerbackImg" asset catalog image resource.
    static let lowerbackImg = DeveloperToolsSupport.ImageResource(name: "lowerbackImg", bundle: resourceBundle)

    /// The "mandate_alert" asset catalog image resource.
    static let mandateAlert = DeveloperToolsSupport.ImageResource(name: "mandate_alert", bundle: resourceBundle)

    /// The "max-home-header" asset catalog image resource.
    static let maxHomeHeader = DeveloperToolsSupport.ImageResource(name: "max-home-header", bundle: resourceBundle)

    /// The "max-qr-scan-bg" asset catalog image resource.
    static let maxQrScanBg = DeveloperToolsSupport.ImageResource(name: "max-qr-scan-bg", bundle: resourceBundle)

    /// The "max-theme-logi" asset catalog image resource.
    static let maxThemeLogi = DeveloperToolsSupport.ImageResource(name: "max-theme-logi", bundle: resourceBundle)

    /// The "maxpay_wallet_logo" asset catalog image resource.
    static let maxpayWalletLogo = DeveloperToolsSupport.ImageResource(name: "maxpay_wallet_logo", bundle: resourceBundle)

    /// The "maxupi" asset catalog image resource.
    static let maxupi = DeveloperToolsSupport.ImageResource(name: "maxupi", bundle: resourceBundle)

    /// The "me_chain" asset catalog image resource.
    static let meChain = DeveloperToolsSupport.ImageResource(name: "me_chain", bundle: resourceBundle)

    /// The "me_logout" asset catalog image resource.
    static let meLogout = DeveloperToolsSupport.ImageResource(name: "me_logout", bundle: resourceBundle)

    /// The "me_milestone" asset catalog image resource.
    static let meMilestone = DeveloperToolsSupport.ImageResource(name: "me_milestone", bundle: resourceBundle)

    /// The "me_monthly_contest" asset catalog image resource.
    static let meMonthlyContest = DeveloperToolsSupport.ImageResource(name: "me_monthly_contest", bundle: resourceBundle)

    /// The "me_ppolicy" asset catalog image resource.
    static let mePpolicy = DeveloperToolsSupport.ImageResource(name: "me_ppolicy", bundle: resourceBundle)

    /// The "me_profile" asset catalog image resource.
    static let meProfile = DeveloperToolsSupport.ImageResource(name: "me_profile", bundle: resourceBundle)

    /// The "me_rank" asset catalog image resource.
    static let meRank = DeveloperToolsSupport.ImageResource(name: "me_rank", bundle: resourceBundle)

    /// The "me_settings" asset catalog image resource.
    static let meSettings = DeveloperToolsSupport.ImageResource(name: "me_settings", bundle: resourceBundle)

    /// The "menu" asset catalog image resource.
    static let menu = DeveloperToolsSupport.ImageResource(name: "menu", bundle: resourceBundle)

    /// The "menu-card-ic" asset catalog image resource.
    static let menuCardIc = DeveloperToolsSupport.ImageResource(name: "menu-card-ic", bundle: resourceBundle)

    /// The "menu-ic" asset catalog image resource.
    static let menuIc = DeveloperToolsSupport.ImageResource(name: "menu-ic", bundle: resourceBundle)

    /// The "miles" asset catalog image resource.
    static let miles = DeveloperToolsSupport.ImageResource(name: "miles", bundle: resourceBundle)

    /// The "miles-ic" asset catalog image resource.
    static let milesIc = DeveloperToolsSupport.ImageResource(name: "miles-ic", bundle: resourceBundle)

    /// The "milesBannermile" asset catalog image resource.
    static let milesBannermile = DeveloperToolsSupport.ImageResource(name: "milesBannermile", bundle: resourceBundle)

    /// The "milesprogress" asset catalog image resource.
    static let milesprogress = DeveloperToolsSupport.ImageResource(name: "milesprogress", bundle: resourceBundle)

    /// The "milstone40Piller" asset catalog image resource.
    static let milstone40Piller = DeveloperToolsSupport.ImageResource(name: "milstone40Piller", bundle: resourceBundle)

    /// The "milstone50Piller" asset catalog image resource.
    static let milstone50Piller = DeveloperToolsSupport.ImageResource(name: "milstone50Piller", bundle: resourceBundle)

    /// The "milstoneCardImg" asset catalog image resource.
    static let milstoneCardImg = DeveloperToolsSupport.ImageResource(name: "milstoneCardImg", bundle: resourceBundle)

    /// The "milstoneb2" asset catalog image resource.
    static let milstoneb2 = DeveloperToolsSupport.ImageResource(name: "milstoneb2", bundle: resourceBundle)

    /// The "milstonebrandMacPics" asset catalog image resource.
    static let milstonebrandMacPics = DeveloperToolsSupport.ImageResource(name: "milstonebrandMacPics", bundle: resourceBundle)

    /// The "milstonebrandstarPics" asset catalog image resource.
    static let milstonebrandstarPics = DeveloperToolsSupport.ImageResource(name: "milstonebrandstarPics", bundle: resourceBundle)

    /// The "milstoneroadPiller" asset catalog image resource.
    static let milstoneroadPiller = DeveloperToolsSupport.ImageResource(name: "milstoneroadPiller", bundle: resourceBundle)

    /// The "milstonetoback" asset catalog image resource.
    static let milstonetoback = DeveloperToolsSupport.ImageResource(name: "milstonetoback", bundle: resourceBundle)

    /// The "milstonneroad" asset catalog image resource.
    static let milstonneroad = DeveloperToolsSupport.ImageResource(name: "milstonneroad", bundle: resourceBundle)

    /// The "minusFPop" asset catalog image resource.
    static let minusFPop = DeveloperToolsSupport.ImageResource(name: "minusFPop", bundle: resourceBundle)

    /// The "minusImg" asset catalog image resource.
    static let minusImg = DeveloperToolsSupport.ImageResource(name: "minusImg", bundle: resourceBundle)

    /// The "mobile-online-payment" asset catalog image resource.
    static let mobileOnlinePayment = DeveloperToolsSupport.ImageResource(name: "mobile-online-payment", bundle: resourceBundle)

    /// The "mobile_number_screen_bg" asset catalog image resource.
    static let mobileNumberScreenBg = DeveloperToolsSupport.ImageResource(name: "mobile_number_screen_bg", bundle: resourceBundle)

    /// The "mobile_verification_screen_bg" asset catalog image resource.
    static let mobileVerificationScreenBg = DeveloperToolsSupport.ImageResource(name: "mobile_verification_screen_bg", bundle: resourceBundle)

    /// The "mpin_match" asset catalog image resource.
    static let mpinMatch = DeveloperToolsSupport.ImageResource(name: "mpin_match", bundle: resourceBundle)

    /// The "multiEarthpic" asset catalog image resource.
    static let multiEarthpic = DeveloperToolsSupport.ImageResource(name: "multiEarthpic", bundle: resourceBundle)

    /// The "my-card-ic" asset catalog image resource.
    static let myCardIc = DeveloperToolsSupport.ImageResource(name: "my-card-ic", bundle: resourceBundle)

    /// The "my-card2-ic" asset catalog image resource.
    static let myCard2Ic = DeveloperToolsSupport.ImageResource(name: "my-card2-ic", bundle: resourceBundle)

    /// The "my-qr-button" asset catalog image resource.
    static let myQrButton = DeveloperToolsSupport.ImageResource(name: "my-qr-button", bundle: resourceBundle)

    /// The "netbanking" asset catalog image resource.
    static let netbanking = DeveloperToolsSupport.ImageResource(name: "netbanking", bundle: resourceBundle)

    /// The "nextArrow" asset catalog image resource.
    static let nextArrow = DeveloperToolsSupport.ImageResource(name: "nextArrow", bundle: resourceBundle)

    /// The "nonRecSeat" asset catalog image resource.
    static let nonRecSeat = DeveloperToolsSupport.ImageResource(name: "nonRecSeat", bundle: resourceBundle)

    /// The "notAvSeat" asset catalog image resource.
    static let notAvSeat = DeveloperToolsSupport.ImageResource(name: "notAvSeat", bundle: resourceBundle)

    /// The "notification-ic" asset catalog image resource.
    static let notificationIc = DeveloperToolsSupport.ImageResource(name: "notification-ic", bundle: resourceBundle)

    /// The "open" asset catalog image resource.
    static let open = DeveloperToolsSupport.ImageResource(name: "open", bundle: resourceBundle)

    /// The "openBg" asset catalog image resource.
    static let openBg = DeveloperToolsSupport.ImageResource(name: "openBg", bundle: resourceBundle)

    /// The "paid" asset catalog image resource.
    static let paid = DeveloperToolsSupport.ImageResource(name: "paid", bundle: resourceBundle)

    /// The "payment-failed-ic" asset catalog image resource.
    static let paymentFailedIc = DeveloperToolsSupport.ImageResource(name: "payment-failed-ic", bundle: resourceBundle)

    /// The "payment-failed-progress" asset catalog image resource.
    static let paymentFailedProgress = DeveloperToolsSupport.ImageResource(name: "payment-failed-progress", bundle: resourceBundle)

    /// The "payment-pending-ic" asset catalog image resource.
    static let paymentPendingIc = DeveloperToolsSupport.ImageResource(name: "payment-pending-ic", bundle: resourceBundle)

    /// The "payment-successful-ic" asset catalog image resource.
    static let paymentSuccessfulIc = DeveloperToolsSupport.ImageResource(name: "payment-successful-ic", bundle: resourceBundle)

    /// The "penBlack" asset catalog image resource.
    static let penBlack = DeveloperToolsSupport.ImageResource(name: "penBlack", bundle: resourceBundle)

    /// The "pencil" asset catalog image resource.
    static let pencil = DeveloperToolsSupport.ImageResource(name: "pencil", bundle: resourceBundle)

    /// The "pink_seat" asset catalog image resource.
    static let pinkSeat = DeveloperToolsSupport.ImageResource(name: "pink_seat", bundle: resourceBundle)

    /// The "plusIcon" asset catalog image resource.
    static let plusIcon = DeveloperToolsSupport.ImageResource(name: "plusIcon", bundle: resourceBundle)

    /// The "plusPic" asset catalog image resource.
    static let plusPic = DeveloperToolsSupport.ImageResource(name: "plusPic", bundle: resourceBundle)

    /// The "polsSeprator" asset catalog image resource.
    static let polsSeprator = DeveloperToolsSupport.ImageResource(name: "polsSeprator", bundle: resourceBundle)

    /// The "powered_by_upi" asset catalog image resource.
    static let poweredByUpi = DeveloperToolsSupport.ImageResource(name: "powered_by_upi", bundle: resourceBundle)

    /// The "powered_by_upi_steps" asset catalog image resource.
    static let poweredByUpiSteps = DeveloperToolsSupport.ImageResource(name: "powered_by_upi_steps", bundle: resourceBundle)

    /// The "powered_count_one" asset catalog image resource.
    static let poweredCountOne = DeveloperToolsSupport.ImageResource(name: "powered_count_one", bundle: resourceBundle)

    /// The "powered_count_three" asset catalog image resource.
    static let poweredCountThree = DeveloperToolsSupport.ImageResource(name: "powered_count_three", bundle: resourceBundle)

    /// The "powered_count_two" asset catalog image resource.
    static let poweredCountTwo = DeveloperToolsSupport.ImageResource(name: "powered_count_two", bundle: resourceBundle)

    /// The "previousArrow" asset catalog image resource.
    static let previousArrow = DeveloperToolsSupport.ImageResource(name: "previousArrow", bundle: resourceBundle)

    /// The "profileBackground" asset catalog image resource.
    static let profileBackground = DeveloperToolsSupport.ImageResource(name: "profileBackground", bundle: resourceBundle)

    /// The "qr-scanner-bg" asset catalog image resource.
    static let qrScannerBg = DeveloperToolsSupport.ImageResource(name: "qr-scanner-bg", bundle: resourceBundle)

    /// The "qrPic" asset catalog image resource.
    static let qrPic = DeveloperToolsSupport.ImageResource(name: "qrPic", bundle: resourceBundle)

    /// The "qui02" asset catalog image resource.
    static let qui02 = DeveloperToolsSupport.ImageResource(name: "qui02", bundle: resourceBundle)

    /// The "quizPicBanner" asset catalog image resource.
    static let quizPicBanner = DeveloperToolsSupport.ImageResource(name: "quizPicBanner", bundle: resourceBundle)

    /// The "radio-button" asset catalog image resource.
    static let radioButton = DeveloperToolsSupport.ImageResource(name: "radio-button", bundle: resourceBundle)

    /// The "radio-on-button" asset catalog image resource.
    static let radioOnButton = DeveloperToolsSupport.ImageResource(name: "radio-on-button", bundle: resourceBundle)

    /// The "rankPic" asset catalog image resource.
    static let rankPic = DeveloperToolsSupport.ImageResource(name: "rankPic", bundle: resourceBundle)

    /// The "refresh" asset catalog image resource.
    static let refresh = DeveloperToolsSupport.ImageResource(name: "refresh", bundle: resourceBundle)

    /// The "right-ic" asset catalog image resource.
    static let rightIc = DeveloperToolsSupport.ImageResource(name: "right-ic", bundle: resourceBundle)

    /// The "rightarrowflight" asset catalog image resource.
    static let rightarrowflight = DeveloperToolsSupport.ImageResource(name: "rightarrowflight", bundle: resourceBundle)

    /// The "rupay" asset catalog image resource.
    static let rupay = DeveloperToolsSupport.ImageResource(name: "rupay", bundle: resourceBundle)

    /// The "scan-again-button-bg" asset catalog image resource.
    static let scanAgainButtonBg = DeveloperToolsSupport.ImageResource(name: "scan-again-button-bg", bundle: resourceBundle)

    /// The "scan-qr-button-ic" asset catalog image resource.
    static let scanQrButtonIc = DeveloperToolsSupport.ImageResource(name: "scan-qr-button-ic", bundle: resourceBundle)

    /// The "scan_overflow" asset catalog image resource.
    static let scanOverflow = DeveloperToolsSupport.ImageResource(name: "scan_overflow", bundle: resourceBundle)

    /// The "search" asset catalog image resource.
    static let search = DeveloperToolsSupport.ImageResource(name: "search", bundle: resourceBundle)

    /// The "search-bar-bg" asset catalog image resource.
    static let searchBarBg = DeveloperToolsSupport.ImageResource(name: "search-bar-bg", bundle: resourceBundle)

    /// The "search_background_ic" asset catalog image resource.
    static let searchBackgroundIc = DeveloperToolsSupport.ImageResource(name: "search_background_ic", bundle: resourceBundle)

    /// The "seatBackPic" asset catalog image resource.
    static let seatBackPic = DeveloperToolsSupport.ImageResource(name: "seatBackPic", bundle: resourceBundle)

    /// The "secondry_wallet_img" asset catalog image resource.
    static let secondryWalletImg = DeveloperToolsSupport.ImageResource(name: "secondry_wallet_img", bundle: resourceBundle)

    /// The "secure" asset catalog image resource.
    static let secure = DeveloperToolsSupport.ImageResource(name: "secure", bundle: resourceBundle)

    /// The "select-from-gallery" asset catalog image resource.
    static let selectFromGallery = DeveloperToolsSupport.ImageResource(name: "select-from-gallery", bundle: resourceBundle)

    /// The "selected-tab-line" asset catalog image resource.
    static let selectedTabLine = DeveloperToolsSupport.ImageResource(name: "selected-tab-line", bundle: resourceBundle)

    /// The "selectedBg" asset catalog image resource.
    static let selectedBg = DeveloperToolsSupport.ImageResource(name: "selectedBg", bundle: resourceBundle)

    /// The "sent-from-ic" asset catalog image resource.
    static let sentFromIc = DeveloperToolsSupport.ImageResource(name: "sent-from-ic", bundle: resourceBundle)

    /// The "settingPic" asset catalog image resource.
    static let settingPic = DeveloperToolsSupport.ImageResource(name: "settingPic", bundle: resourceBundle)

    /// The "setypin_screen_bg" asset catalog image resource.
    static let setypinScreenBg = DeveloperToolsSupport.ImageResource(name: "setypin_screen_bg", bundle: resourceBundle)

    /// The "share-history-ic" asset catalog image resource.
    static let shareHistoryIc = DeveloperToolsSupport.ImageResource(name: "share-history-ic", bundle: resourceBundle)

    /// The "share-ic" asset catalog image resource.
    static let shareIc = DeveloperToolsSupport.ImageResource(name: "share-ic", bundle: resourceBundle)

    /// The "share-qr-ic" asset catalog image resource.
    static let shareQrIc = DeveloperToolsSupport.ImageResource(name: "share-qr-ic", bundle: resourceBundle)

    /// The "sharePic" asset catalog image resource.
    static let sharePic = DeveloperToolsSupport.ImageResource(name: "sharePic", bundle: resourceBundle)

    /// The "skipbutton" asset catalog image resource.
    static let skipbutton = DeveloperToolsSupport.ImageResource(name: "skipbutton", bundle: resourceBundle)

    /// The "sofa" asset catalog image resource.
    static let sofa = DeveloperToolsSupport.ImageResource(name: "sofa", bundle: resourceBundle)

    /// The "spinnerdownarr" asset catalog image resource.
    static let spinnerdownarr = DeveloperToolsSupport.ImageResource(name: "spinnerdownarr", bundle: resourceBundle)

    /// The "splash" asset catalog image resource.
    static let splash = DeveloperToolsSupport.ImageResource(name: "splash", bundle: resourceBundle)

    /// The "swap_arrow" asset catalog image resource.
    static let swapArrow = DeveloperToolsSupport.ImageResource(name: "swap_arrow", bundle: resourceBundle)

    /// The "tab-home-ic" asset catalog image resource.
    static let tabHomeIc = DeveloperToolsSupport.ImageResource(name: "tab-home-ic", bundle: resourceBundle)

    /// The "tab-myexpense-ic" asset catalog image resource.
    static let tabMyexpenseIc = DeveloperToolsSupport.ImageResource(name: "tab-myexpense-ic", bundle: resourceBundle)

    /// The "tab-profile-ic" asset catalog image resource.
    static let tabProfileIc = DeveloperToolsSupport.ImageResource(name: "tab-profile-ic", bundle: resourceBundle)

    /// The "tab-qrscan" asset catalog image resource.
    static let tabQrscan = DeveloperToolsSupport.ImageResource(name: "tab-qrscan", bundle: resourceBundle)

    /// The "tab-quiz-ic" asset catalog image resource.
    static let tabQuizIc = DeveloperToolsSupport.ImageResource(name: "tab-quiz-ic", bundle: resourceBundle)

    #warning("The \"tabQrscan\" image asset name resolves to the symbol \"tabQrscan\" which already exists. Try renaming the asset.")

    /// The "target" asset catalog image resource.
    static let target = DeveloperToolsSupport.ImageResource(name: "target", bundle: resourceBundle)

    /// The "termsPics" asset catalog image resource.
    static let termsPics = DeveloperToolsSupport.ImageResource(name: "termsPics", bundle: resourceBundle)

    /// The "timePic" asset catalog image resource.
    static let timePic = DeveloperToolsSupport.ImageResource(name: "timePic", bundle: resourceBundle)

    /// The "toggle-off-button" asset catalog image resource.
    static let toggleOffButton = DeveloperToolsSupport.ImageResource(name: "toggle-off-button", bundle: resourceBundle)

    /// The "toggle-on-button" asset catalog image resource.
    static let toggleOnButton = DeveloperToolsSupport.ImageResource(name: "toggle-on-button", bundle: resourceBundle)

    /// The "transIndicatior_Four" asset catalog image resource.
    static let transIndicatiorFour = DeveloperToolsSupport.ImageResource(name: "transIndicatior_Four", bundle: resourceBundle)

    /// The "transIndicatior_One" asset catalog image resource.
    static let transIndicatiorOne = DeveloperToolsSupport.ImageResource(name: "transIndicatior_One", bundle: resourceBundle)

    /// The "transIndicatior_Three" asset catalog image resource.
    static let transIndicatiorThree = DeveloperToolsSupport.ImageResource(name: "transIndicatior_Three", bundle: resourceBundle)

    /// The "transIndicatior_Two" asset catalog image resource.
    static let transIndicatiorTwo = DeveloperToolsSupport.ImageResource(name: "transIndicatior_Two", bundle: resourceBundle)

    /// The "transIndicatior_five" asset catalog image resource.
    static let transIndicatiorFive = DeveloperToolsSupport.ImageResource(name: "transIndicatior_five", bundle: resourceBundle)

    /// The "transactionIndicator_pending_progress" asset catalog image resource.
    static let transactionIndicatorPendingProgress = DeveloperToolsSupport.ImageResource(name: "transactionIndicator_pending_progress", bundle: resourceBundle)

    /// The "transaction_row_bg" asset catalog image resource.
    static let transactionRowBg = DeveloperToolsSupport.ImageResource(name: "transaction_row_bg", bundle: resourceBundle)

    /// The "transfer-amount-ic" asset catalog image resource.
    static let transferAmountIc = DeveloperToolsSupport.ImageResource(name: "transfer-amount-ic", bundle: resourceBundle)

    /// The "travel-bus-ic" asset catalog image resource.
    static let travelBusIc = DeveloperToolsSupport.ImageResource(name: "travel-bus-ic", bundle: resourceBundle)

    /// The "travel-flight-ic" asset catalog image resource.
    static let travelFlightIc = DeveloperToolsSupport.ImageResource(name: "travel-flight-ic", bundle: resourceBundle)

    /// The "travel-hotel-ic" asset catalog image resource.
    static let travelHotelIc = DeveloperToolsSupport.ImageResource(name: "travel-hotel-ic", bundle: resourceBundle)

    /// The "travel-luggage" asset catalog image resource.
    static let travelLuggage = DeveloperToolsSupport.ImageResource(name: "travel-luggage", bundle: resourceBundle)

    /// The "trend" asset catalog image resource.
    static let trend = DeveloperToolsSupport.ImageResource(name: "trend", bundle: resourceBundle)

    /// The "twayPic" asset catalog image resource.
    static let twayPic = DeveloperToolsSupport.ImageResource(name: "twayPic", bundle: resourceBundle)

    /// The "umbrella" asset catalog image resource.
    static let umbrella = DeveloperToolsSupport.ImageResource(name: "umbrella", bundle: resourceBundle)

    /// The "uncheck" asset catalog image resource.
    static let uncheck = DeveloperToolsSupport.ImageResource(name: "uncheck", bundle: resourceBundle)

    /// The "up-arrow-ic" asset catalog image resource.
    static let upArrowIc = DeveloperToolsSupport.ImageResource(name: "up-arrow-ic", bundle: resourceBundle)

    /// The "upi-home-header" asset catalog image resource.
    static let upiHomeHeader = DeveloperToolsSupport.ImageResource(name: "upi-home-header", bundle: resourceBundle)

    /// The "userPic" asset catalog image resource.
    static let userPic = DeveloperToolsSupport.ImageResource(name: "userPic", bundle: resourceBundle)

    /// The "wallet_secondry_img" asset catalog image resource.
    static let walletSecondryImg = DeveloperToolsSupport.ImageResource(name: "wallet_secondry_img", bundle: resourceBundle)

    /// The "wealth" asset catalog image resource.
    static let wealth = DeveloperToolsSupport.ImageResource(name: "wealth", bundle: resourceBundle)

    /// The "weather" asset catalog image resource.
    static let weather = DeveloperToolsSupport.ImageResource(name: "weather", bundle: resourceBundle)

    /// The "white_shadowed_bg" asset catalog image resource.
    static let whiteShadowedBg = DeveloperToolsSupport.ImageResource(name: "white_shadowed_bg", bundle: resourceBundle)

    /// The "winnerToppic" asset catalog image resource.
    static let winnerToppic = DeveloperToolsSupport.ImageResource(name: "winnerToppic", bundle: resourceBundle)

    /// The "wrong-ic" asset catalog image resource.
    static let wrongIc = DeveloperToolsSupport.ImageResource(name: "wrong-ic", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    #warning("The \"black-color\" color asset name resolves to a conflicting NSColor symbol \"black\". Try renaming the asset.")

    /// The "card-number" asset catalog color.
    static var cardNumber: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardNumber)
#else
        .init()
#endif
    }

    /// The "grey" asset catalog color.
    static var grey: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grey)
#else
        .init()
#endif
    }

    /// The "grey-chip-color" asset catalog color.
    static var greyChip: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greyChip)
#else
        .init()
#endif
    }

    /// The "grey-line-color" asset catalog color.
    static var greyLine: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greyLine)
#else
        .init()
#endif
    }

    /// The "ladies-sit- border-red-color" asset catalog color.
    static var ladiesSitBorderRed: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ladiesSitBorderRed)
#else
        .init()
#endif
    }

    /// The "miles-logo-red" asset catalog color.
    static var milesLogoRed: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milesLogoRed)
#else
        .init()
#endif
    }

    /// The "pay-card-bg-color" asset catalog color.
    static var payCardBg: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .payCardBg)
#else
        .init()
#endif
    }

    /// The "pink-color" asset catalog color.
    static var pink: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pink)
#else
        .init()
#endif
    }

    /// The "primary-green" asset catalog color.
    static var primaryGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .primaryGreen)
#else
        .init()
#endif
    }

    /// The "reload-grey-color" asset catalog color.
    static var reloadGrey: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .reloadGrey)
#else
        .init()
#endif
    }

    /// The "secondary-green" asset catalog color.
    static var secondaryGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .secondaryGreen)
#else
        .init()
#endif
    }

    /// The "status-red-color" asset catalog color.
    static var statusRed: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .statusRed)
#else
        .init()
#endif
    }

    /// The "text-red-color" asset catalog color.
    static var textRed: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .textRed)
#else
        .init()
#endif
    }

    /// The "theme_green" asset catalog color.
    static var themeGreen: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .themeGreen)
#else
        .init()
#endif
    }

    /// The "theme_green_light" asset catalog color.
    static var themeGreenLight: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .themeGreenLight)
#else
        .init()
#endif
    }

    /// The "theme_text_dark" asset catalog color.
    static var themeTextDark: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .themeTextDark)
#else
        .init()
#endif
    }

    /// The "theme_text_dark2" asset catalog color.
    static var themeTextDark2: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .themeTextDark2)
#else
        .init()
#endif
    }

    #warning("The \"white-color\" color asset name resolves to a conflicting NSColor symbol \"white\". Try renaming the asset.")

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    #warning("The \"black-color\" color asset name resolves to a conflicting UIColor symbol \"black\". Try renaming the asset.")

    /// The "card-number" asset catalog color.
    static var cardNumber: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .cardNumber)
#else
        .init()
#endif
    }

    /// The "grey" asset catalog color.
    static var grey: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grey)
#else
        .init()
#endif
    }

    /// The "grey-chip-color" asset catalog color.
    static var greyChip: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greyChip)
#else
        .init()
#endif
    }

    /// The "grey-line-color" asset catalog color.
    static var greyLine: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greyLine)
#else
        .init()
#endif
    }

    /// The "ladies-sit- border-red-color" asset catalog color.
    static var ladiesSitBorderRed: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ladiesSitBorderRed)
#else
        .init()
#endif
    }

    /// The "miles-logo-red" asset catalog color.
    static var milesLogoRed: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .milesLogoRed)
#else
        .init()
#endif
    }

    /// The "pay-card-bg-color" asset catalog color.
    static var payCardBg: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .payCardBg)
#else
        .init()
#endif
    }

    /// The "pink-color" asset catalog color.
    static var pink: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .pink)
#else
        .init()
#endif
    }

    /// The "primary-green" asset catalog color.
    static var primaryGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .primaryGreen)
#else
        .init()
#endif
    }

    /// The "reload-grey-color" asset catalog color.
    static var reloadGrey: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .reloadGrey)
#else
        .init()
#endif
    }

    /// The "secondary-green" asset catalog color.
    static var secondaryGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .secondaryGreen)
#else
        .init()
#endif
    }

    /// The "status-red-color" asset catalog color.
    static var statusRed: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .statusRed)
#else
        .init()
#endif
    }

    /// The "text-red-color" asset catalog color.
    static var textRed: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .textRed)
#else
        .init()
#endif
    }

    /// The "theme_green" asset catalog color.
    static var themeGreen: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .themeGreen)
#else
        .init()
#endif
    }

    /// The "theme_green_light" asset catalog color.
    static var themeGreenLight: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .themeGreenLight)
#else
        .init()
#endif
    }

    /// The "theme_text_dark" asset catalog color.
    static var themeTextDark: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .themeTextDark)
#else
        .init()
#endif
    }

    /// The "theme_text_dark2" asset catalog color.
    static var themeTextDark2: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .themeTextDark2)
#else
        .init()
#endif
    }

    #warning("The \"white-color\" color asset name resolves to a conflicting UIColor symbol \"white\". Try renaming the asset.")

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    #warning("The \"black-color\" color asset name resolves to a conflicting Color symbol \"black\". Try renaming the asset.")

    /// The "card-number" asset catalog color.
    static var cardNumber: SwiftUI.Color { .init(.cardNumber) }

    /// The "grey" asset catalog color.
    static var grey: SwiftUI.Color { .init(.grey) }

    /// The "grey-chip-color" asset catalog color.
    static var greyChip: SwiftUI.Color { .init(.greyChip) }

    /// The "grey-line-color" asset catalog color.
    static var greyLine: SwiftUI.Color { .init(.greyLine) }

    /// The "ladies-sit- border-red-color" asset catalog color.
    static var ladiesSitBorderRed: SwiftUI.Color { .init(.ladiesSitBorderRed) }

    /// The "miles-logo-red" asset catalog color.
    static var milesLogoRed: SwiftUI.Color { .init(.milesLogoRed) }

    /// The "pay-card-bg-color" asset catalog color.
    static var payCardBg: SwiftUI.Color { .init(.payCardBg) }

    #warning("The \"pink-color\" color asset name resolves to a conflicting Color symbol \"pink\". Try renaming the asset.")

    /// The "primary-green" asset catalog color.
    static var primaryGreen: SwiftUI.Color { .init(.primaryGreen) }

    /// The "reload-grey-color" asset catalog color.
    static var reloadGrey: SwiftUI.Color { .init(.reloadGrey) }

    /// The "secondary-green" asset catalog color.
    static var secondaryGreen: SwiftUI.Color { .init(.secondaryGreen) }

    /// The "status-red-color" asset catalog color.
    static var statusRed: SwiftUI.Color { .init(.statusRed) }

    /// The "text-red-color" asset catalog color.
    static var textRed: SwiftUI.Color { .init(.textRed) }

    /// The "theme_green" asset catalog color.
    static var themeGreen: SwiftUI.Color { .init(.themeGreen) }

    /// The "theme_green_light" asset catalog color.
    static var themeGreenLight: SwiftUI.Color { .init(.themeGreenLight) }

    /// The "theme_text_dark" asset catalog color.
    static var themeTextDark: SwiftUI.Color { .init(.themeTextDark) }

    /// The "theme_text_dark2" asset catalog color.
    static var themeTextDark2: SwiftUI.Color { .init(.themeTextDark2) }

    #warning("The \"white-color\" color asset name resolves to a conflicting Color symbol \"white\". Try renaming the asset.")

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "card-number" asset catalog color.
    static var cardNumber: SwiftUI.Color { .init(.cardNumber) }

    /// The "grey" asset catalog color.
    static var grey: SwiftUI.Color { .init(.grey) }

    /// The "grey-chip-color" asset catalog color.
    static var greyChip: SwiftUI.Color { .init(.greyChip) }

    /// The "grey-line-color" asset catalog color.
    static var greyLine: SwiftUI.Color { .init(.greyLine) }

    /// The "ladies-sit- border-red-color" asset catalog color.
    static var ladiesSitBorderRed: SwiftUI.Color { .init(.ladiesSitBorderRed) }

    /// The "miles-logo-red" asset catalog color.
    static var milesLogoRed: SwiftUI.Color { .init(.milesLogoRed) }

    /// The "pay-card-bg-color" asset catalog color.
    static var payCardBg: SwiftUI.Color { .init(.payCardBg) }

    /// The "primary-green" asset catalog color.
    static var primaryGreen: SwiftUI.Color { .init(.primaryGreen) }

    /// The "reload-grey-color" asset catalog color.
    static var reloadGrey: SwiftUI.Color { .init(.reloadGrey) }

    /// The "secondary-green" asset catalog color.
    static var secondaryGreen: SwiftUI.Color { .init(.secondaryGreen) }

    /// The "status-red-color" asset catalog color.
    static var statusRed: SwiftUI.Color { .init(.statusRed) }

    /// The "text-red-color" asset catalog color.
    static var textRed: SwiftUI.Color { .init(.textRed) }

    /// The "theme_green" asset catalog color.
    static var themeGreen: SwiftUI.Color { .init(.themeGreen) }

    /// The "theme_green_light" asset catalog color.
    static var themeGreenLight: SwiftUI.Color { .init(.themeGreenLight) }

    /// The "theme_text_dark" asset catalog color.
    static var themeTextDark: SwiftUI.Color { .init(.themeTextDark) }

    /// The "theme_text_dark2" asset catalog color.
    static var themeTextDark2: SwiftUI.Color { .init(.themeTextDark2) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "AC" asset catalog image.
    static var AC: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .AC)
#else
        .init()
#endif
    }

    /// The "Beneficiary" asset catalog image.
    static var beneficiary: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .beneficiary)
#else
        .init()
#endif
    }

    /// The "Blanket" asset catalog image.
    static var blanket: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .blanket)
#else
        .init()
#endif
    }

    /// The "Block List" asset catalog image.
    static var blockList: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .blockList)
#else
        .init()
#endif
    }

    /// The "Charging-Point" asset catalog image.
    static var chargingPoint: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chargingPoint)
#else
        .init()
#endif
    }

    /// The "DeRegister UPI" asset catalog image.
    static var deRegisterUPI: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .deRegisterUPI)
#else
        .init()
#endif
    }

    /// The "Emergency-Exit" asset catalog image.
    static var emergencyExit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emergencyExit)
#else
        .init()
#endif
    }

    /// The "Fire-Extinguisher" asset catalog image.
    static var fireExtinguisher: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fireExtinguisher)
#else
        .init()
#endif
    }

    /// The "First-Aid-Box" asset catalog image.
    static var firstAidBox: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .firstAidBox)
#else
        .init()
#endif
    }

    /// The "FloatingControlBg" asset catalog image.
    static var floatingControlBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .floatingControlBg)
#else
        .init()
#endif
    }

    /// The "FloatingMenuBG" asset catalog image.
    static var floatingMenuBG: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .floatingMenuBG)
#else
        .init()
#endif
    }

    /// The "GPS-Tracking" asset catalog image.
    static var gpsTracking: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .gpsTracking)
#else
        .init()
#endif
    }

    /// The "Hammer" asset catalog image.
    static var hammer: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .hammer)
#else
        .init()
#endif
    }

    /// The "Hand-Sanitizer" asset catalog image.
    static var handSanitizer: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .handSanitizer)
#else
        .init()
#endif
    }

    /// The "Image" asset catalog image.
    static var image: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Intro1" asset catalog image.
    static var intro1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .intro1)
#else
        .init()
#endif
    }

    /// The "Intro2" asset catalog image.
    static var intro2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .intro2)
#else
        .init()
#endif
    }

    /// The "Intro3" asset catalog image.
    static var intro3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .intro3)
#else
        .init()
#endif
    }

    /// The "Intro4" asset catalog image.
    static var intro4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .intro4)
#else
        .init()
#endif
    }

    /// The "Intro5" asset catalog image.
    static var intro5: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .intro5)
#else
        .init()
#endif
    }

    /// The "Manage UPI ID" asset catalog image.
    static var manageUPIID: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .manageUPIID)
#else
        .init()
#endif
    }

    /// The "Manage UPI Number" asset catalog image.
    static var manageUPINumber: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .manageUPINumber)
#else
        .init()
#endif
    }

    /// The "Pillow" asset catalog image.
    static var pillow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pillow)
#else
        .init()
#endif
    }

    /// The "Qeflight" asset catalog image.
    static var qeflight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qeflight)
#else
        .init()
#endif
    }

    /// The "Reading-Light" asset catalog image.
    static var readingLight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .readingLight)
#else
        .init()
#endif
    }

    /// The "Rectanglecard" asset catalog image.
    static var rectanglecard: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rectanglecard)
#else
        .init()
#endif
    }

    /// The "Remove All Cache" asset catalog image.
    static var removeAllCache: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .removeAllCache)
#else
        .init()
#endif
    }

    /// The "Request Money" asset catalog image.
    static var requestMoney: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .requestMoney)
#else
        .init()
#endif
    }

    /// The "Request Money to Contact or UPI ID" asset catalog image.
    static var requestMoneyToContactOrUPIID: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .requestMoneyToContactOrUPIID)
#else
        .init()
#endif
    }

    /// The "Send Money to Bank Account" asset catalog image.
    static var sendMoneyToBankAccount: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sendMoneyToBankAccount)
#else
        .init()
#endif
    }

    /// The "Send Money to Contact or UPI ID" asset catalog image.
    static var sendMoneyToContactOrUPIID: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sendMoneyToContactOrUPIID)
#else
        .init()
#endif
    }

    /// The "Staff" asset catalog image.
    static var staff: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .staff)
#else
        .init()
#endif
    }

    /// The "TV" asset catalog image.
    static var TV: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .TV)
#else
        .init()
#endif
    }

    /// The "Toilet" asset catalog image.
    static var toilet: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .toilet)
#else
        .init()
#endif
    }

    /// The "Transaction History" asset catalog image.
    static var transactionHistory: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transactionHistory)
#else
        .init()
#endif
    }

    /// The "UPI Autopay" asset catalog image.
    static var upiAutopay: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .upiAutopay)
#else
        .init()
#endif
    }

    /// The "UPIIconIImage" asset catalog image.
    static var upiIconI: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .upiIconI)
#else
        .init()
#endif
    }

    /// The "UPIPayment" asset catalog image.
    static var upiPayment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .upiPayment)
#else
        .init()
#endif
    }

    /// The "Water-Bottle" asset catalog image.
    static var waterBottle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .waterBottle)
#else
        .init()
#endif
    }

    /// The "WiFi" asset catalog image.
    static var wiFi: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wiFi)
#else
        .init()
#endif
    }

    /// The "add" asset catalog image.
    static var add: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .add)
#else
        .init()
#endif
    }

    /// The "addFPop" asset catalog image.
    static var addFPop: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .addFPop)
#else
        .init()
#endif
    }

    /// The "addpriv" asset catalog image.
    static var addpriv: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .addpriv)
#else
        .init()
#endif
    }

    /// The "avSeat" asset catalog image.
    static var avSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .avSeat)
#else
        .init()
#endif
    }

    /// The "backarrow" asset catalog image.
    static var backarrow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .backarrow)
#else
        .init()
#endif
    }

    /// The "backgroundImg" asset catalog image.
    static var backgroundImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .backgroundImg)
#else
        .init()
#endif
    }

    /// The "bank_logo" asset catalog image.
    static var bankLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bankLogo)
#else
        .init()
#endif
    }

    /// The "bannerQuiz" asset catalog image.
    static var bannerQuiz: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bannerQuiz)
#else
        .init()
#endif
    }

    /// The "barcodeFlight" asset catalog image.
    static var barcodeFlight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .barcodeFlight)
#else
        .init()
#endif
    }

    /// The "bbps_logo" asset catalog image.
    static var bbpsLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bbpsLogo)
#else
        .init()
#endif
    }

    /// The "beneficiary-name-ic" asset catalog image.
    static var beneficiaryNameIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .beneficiaryNameIc)
#else
        .init()
#endif
    }

    /// The "beneficiary-upiid-ic" asset catalog image.
    static var beneficiaryUpiidIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .beneficiaryUpiidIc)
#else
        .init()
#endif
    }

    /// The "bg-home-header-green" asset catalog image.
    static var bgHomeHeaderGreen: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bgHomeHeaderGreen)
#else
        .init()
#endif
    }

    /// The "bg-home-header-white" asset catalog image.
    static var bgHomeHeaderWhite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bgHomeHeaderWhite)
#else
        .init()
#endif
    }

    /// The "bhim" asset catalog image.
    static var bhim: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bhim)
#else
        .init()
#endif
    }

    /// The "bhim-upi-ic" asset catalog image.
    static var bhimUpiIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bhimUpiIc)
#else
        .init()
#endif
    }

    /// The "bhimImg" asset catalog image.
    static var bhimImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bhimImg)
#else
        .init()
#endif
    }

    /// The "bill" asset catalog image.
    static var bill: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bill)
#else
        .init()
#endif
    }

    /// The "black_seat" asset catalog image.
    static var blackSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .blackSeat)
#else
        .init()
#endif
    }

    /// The "bnkImg" asset catalog image.
    static var bnkImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bnkImg)
#else
        .init()
#endif
    }

    /// The "bookedSeat" asset catalog image.
    static var bookedSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bookedSeat)
#else
        .init()
#endif
    }

    /// The "borderGreenPic" asset catalog image.
    static var borderGreenPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .borderGreenPic)
#else
        .init()
#endif
    }

    /// The "bus-drop-point-tab" asset catalog image.
    static var busDropPointTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .busDropPointTab)
#else
        .init()
#endif
    }

    /// The "bus-pickup-point-tab" asset catalog image.
    static var busPickupPointTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .busPickupPointTab)
#else
        .init()
#endif
    }

    /// The "bus-select-seat-tab" asset catalog image.
    static var busSelectSeatTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .busSelectSeatTab)
#else
        .init()
#endif
    }

    /// The "bus-serchticket-bg" asset catalog image.
    static var busSerchticketBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .busSerchticketBg)
#else
        .init()
#endif
    }

    /// The "calender-history-ic" asset catalog image.
    static var calenderHistoryIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .calenderHistoryIc)
#else
        .init()
#endif
    }

    /// The "card" asset catalog image.
    static var card: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .card)
#else
        .init()
#endif
    }

    /// The "card-bgview-ic" asset catalog image.
    static var cardBgviewIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardBgviewIc)
#else
        .init()
#endif
    }

    /// The "card-chip-ic" asset catalog image.
    static var cardChipIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardChipIc)
#else
        .init()
#endif
    }

    /// The "card-home-upper" asset catalog image.
    static var cardHomeUpper: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardHomeUpper)
#else
        .init()
#endif
    }

    /// The "card-uparrow-ic" asset catalog image.
    static var cardUparrowIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardUparrowIc)
#else
        .init()
#endif
    }

    /// The "cardBBack" asset catalog image.
    static var cardBBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardBBack)
#else
        .init()
#endif
    }

    /// The "cardBackPro" asset catalog image.
    static var cardBackPro: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardBackPro)
#else
        .init()
#endif
    }

    /// The "cardFBack" asset catalog image.
    static var cardFBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardFBack)
#else
        .init()
#endif
    }

    /// The "cardGrBack" asset catalog image.
    static var cardGrBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardGrBack)
#else
        .init()
#endif
    }

    /// The "cardRBack" asset catalog image.
    static var cardRBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cardRBack)
#else
        .init()
#endif
    }

    /// The "catagory_bg" asset catalog image.
    static var catagoryBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .catagoryBg)
#else
        .init()
#endif
    }

    /// The "catagory_item" asset catalog image.
    static var catagoryItem: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .catagoryItem)
#else
        .init()
#endif
    }

    /// The "chainPic" asset catalog image.
    static var chainPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chainPic)
#else
        .init()
#endif
    }

    /// The "chainProgressLine" asset catalog image.
    static var chainProgressLine: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chainProgressLine)
#else
        .init()
#endif
    }

    /// The "chainTopImg" asset catalog image.
    static var chainTopImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chainTopImg)
#else
        .init()
#endif
    }

    /// The "check" asset catalog image.
    static var check: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .check)
#else
        .init()
#endif
    }

    /// The "circle-boarding-notselected" asset catalog image.
    static var circleBoardingNotselected: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .circleBoardingNotselected)
#else
        .init()
#endif
    }

    /// The "circle-boarding-selected" asset catalog image.
    static var circleBoardingSelected: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .circleBoardingSelected)
#else
        .init()
#endif
    }

    /// The "claimBg" asset catalog image.
    static var claimBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .claimBg)
#else
        .init()
#endif
    }

    /// The "close" asset catalog image.
    static var close: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .close)
#else
        .init()
#endif
    }

    /// The "close-button-ic" asset catalog image.
    static var closeButtonIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .closeButtonIc)
#else
        .init()
#endif
    }

    /// The "complaint-submitted-ic" asset catalog image.
    static var complaintSubmittedIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .complaintSubmittedIc)
#else
        .init()
#endif
    }

    /// The "complete_statusImg" asset catalog image.
    static var completeStatusImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .completeStatusImg)
#else
        .init()
#endif
    }

    /// The "conplaint-home" asset catalog image.
    static var conplaintHome: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .conplaintHome)
#else
        .init()
#endif
    }

    /// The "createQRMandateVC" asset catalog image.
    static var createQRMandateVC: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .createQRMandateVC)
#else
        .init()
#endif
    }

    /// The "deactivePhone" asset catalog image.
    static var deactivePhone: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .deactivePhone)
#else
        .init()
#endif
    }

    /// The "debit_cd_back" asset catalog image.
    static var debitCdBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .debitCdBack)
#else
        .init()
#endif
    }

    /// The "debit_image" asset catalog image.
    static var debit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .debit)
#else
        .init()
#endif
    }

    /// The "default_maxpe_profile" asset catalog image.
    static var defaultMaxpeProfile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .defaultMaxpeProfile)
#else
        .init()
#endif
    }

    /// The "default_maxpe_profile 1" asset catalog image.
    static var defaultMaxpeProfile1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .defaultMaxpeProfile1)
#else
        .init()
#endif
    }

    /// The "delete" asset catalog image.
    static var delete: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .delete)
#else
        .init()
#endif
    }

    /// The "dotted-horizontal-line-ic" asset catalog image.
    static var dottedHorizontalLineIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dottedHorizontalLineIc)
#else
        .init()
#endif
    }

    /// The "dotted-vertical-line-ic" asset catalog image.
    static var dottedVerticalLineIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dottedVerticalLineIc)
#else
        .init()
#endif
    }

    /// The "dotted-vertical-point-line-ic" asset catalog image.
    static var dottedVerticalPointLineIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dottedVerticalPointLineIc)
#else
        .init()
#endif
    }

    /// The "downld" asset catalog image.
    static var downld: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .downld)
#else
        .init()
#endif
    }

    /// The "eclanatyionmark" asset catalog image.
    static var eclanatyionmark: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eclanatyionmark)
#else
        .init()
#endif
    }

    /// The "elipse" asset catalog image.
    static var elipse: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .elipse)
#else
        .init()
#endif
    }

    /// The "english" asset catalog image.
    static var english: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .english)
#else
        .init()
#endif
    }

    /// The "enter_pin_screen_bg" asset catalog image.
    static var enterPinScreenBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .enterPinScreenBg)
#else
        .init()
#endif
    }

    /// The "extraLSeat" asset catalog image.
    static var extraLSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .extraLSeat)
#else
        .init()
#endif
    }

    /// The "eye-ic" asset catalog image.
    static var eyeIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eyeIc)
#else
        .init()
#endif
    }

    /// The "failed" asset catalog image.
    static var failed: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .failed)
#else
        .init()
#endif
    }

    /// The "filter-history-ic" asset catalog image.
    static var filterHistoryIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .filterHistoryIc)
#else
        .init()
#endif
    }

    /// The "flash-off-ic" asset catalog image.
    static var flashOffIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flashOffIc)
#else
        .init()
#endif
    }

    /// The "flash-on-ic" asset catalog image.
    static var flashOnIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flashOnIc)
#else
        .init()
#endif
    }

    /// The "flightFromto" asset catalog image.
    static var flightFromto: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flightFromto)
#else
        .init()
#endif
    }

    /// The "flightPic" asset catalog image.
    static var flightPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flightPic)
#else
        .init()
#endif
    }

    /// The "flightTicketBackPic" asset catalog image.
    static var flightTicketBackPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flightTicketBackPic)
#else
        .init()
#endif
    }

    /// The "flightTopPic" asset catalog image.
    static var flightTopPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flightTopPic)
#else
        .init()
#endif
    }

    /// The "foundSmilyBgGreen" asset catalog image.
    static var foundSmilyBgGreen: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .foundSmilyBgGreen)
#else
        .init()
#endif
    }

    /// The "green_seat" asset catalog image.
    static var greenSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greenSeat)
#else
        .init()
#endif
    }

    /// The "grey_seat" asset catalog image.
    static var greySeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greySeat)
#else
        .init()
#endif
    }

    /// The "handle" asset catalog image.
    static var handle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .handle)
#else
        .init()
#endif
    }

    /// The "hotelsamplePic" asset catalog image.
    static var hotelsamplePic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .hotelsamplePic)
#else
        .init()
#endif
    }

    /// The "icComplaint" asset catalog image.
    static var icComplaint: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icComplaint)
#else
        .init()
#endif
    }

    /// The "icMaxUPI" asset catalog image.
    static var icMaxUPI: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icMaxUPI)
#else
        .init()
#endif
    }

    /// The "icProfile" asset catalog image.
    static var icProfile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icProfile)
#else
        .init()
#endif
    }

    /// The "icScanQR" asset catalog image.
    static var icScanQR: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icScanQR)
#else
        .init()
#endif
    }

    /// The "icShareQR" asset catalog image.
    static var icShareQR: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icShareQR)
#else
        .init()
#endif
    }

    /// The "ic_arrow_back_24" asset catalog image.
    static var icArrowBack24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icArrowBack24)
#else
        .init()
#endif
    }

    /// The "ic_arrow_down" asset catalog image.
    static var icArrowDown: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icArrowDown)
#else
        .init()
#endif
    }

    /// The "ic_arrow_up" asset catalog image.
    static var icArrowUp: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icArrowUp)
#else
        .init()
#endif
    }

    /// The "ic_baseline_add_circle_24" asset catalog image.
    static var icBaselineAddCircle24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineAddCircle24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_block_24" asset catalog image.
    static var icBaselineBlock24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineBlock24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_calendar" asset catalog image.
    static var icBaselineCalendar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineCalendar)
#else
        .init()
#endif
    }

    /// The "ic_baseline_calendar_today_24" asset catalog image.
    static var icBaselineCalendarToday24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineCalendarToday24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_history_24" asset catalog image.
    static var icBaselineHistory24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineHistory24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_keyboard_arrow_down_24" asset catalog image.
    static var icBaselineKeyboardArrowDown24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineKeyboardArrowDown24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_keyboard_arrow_right_24 1" asset catalog image.
    static var icBaselineKeyboardArrowRight241: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineKeyboardArrowRight241)
#else
        .init()
#endif
    }

    /// The "ic_baseline_people_alt_24" asset catalog image.
    static var icBaselinePeopleAlt24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselinePeopleAlt24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_qr_code_24" asset catalog image.
    static var icBaselineQrCode24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineQrCode24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_search_24" asset catalog image.
    static var icBaselineSearch24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineSearch24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_sim_card_24" asset catalog image.
    static var icBaselineSimCard24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineSimCard24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_transfer" asset catalog image.
    static var icBaselineTransfer: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineTransfer)
#else
        .init()
#endif
    }

    /// The "ic_baseline_trending_flat_24" asset catalog image.
    static var icBaselineTrendingFlat24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBaselineTrendingFlat24)
#else
        .init()
#endif
    }

    /// The "ic_home_transfer" asset catalog image.
    static var icHomeTransfer: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeTransfer)
#else
        .init()
#endif
    }

    /// The "ic_onboarding_1" asset catalog image.
    static var icOnboarding1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icOnboarding1)
#else
        .init()
#endif
    }

    /// The "ic_options_bg" asset catalog image.
    static var icOptionsBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icOptionsBg)
#else
        .init()
#endif
    }

    /// The "idea-exchange" asset catalog image.
    static var ideaExchange: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ideaExchange)
#else
        .init()
#endif
    }

    /// The "imgThumb" asset catalog image.
    static var imgThumb: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgThumb)
#else
        .init()
#endif
    }

    /// The "imgphone" asset catalog image.
    static var imgphone: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imgphone)
#else
        .init()
#endif
    }

    /// The "india" asset catalog image.
    static var india: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .india)
#else
        .init()
#endif
    }

    /// The "info-ic" asset catalog image.
    static var infoIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .infoIc)
#else
        .init()
#endif
    }

    /// The "infoPics" asset catalog image.
    static var infoPics: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .infoPics)
#else
        .init()
#endif
    }

    /// The "itemBg" asset catalog image.
    static var itemBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemBg)
#else
        .init()
#endif
    }

    /// The "itemBgLarge" asset catalog image.
    static var itemBgLarge: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemBgLarge)
#else
        .init()
#endif
    }

    /// The "itemHeaderBg" asset catalog image.
    static var itemHeaderBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemHeaderBg)
#else
        .init()
#endif
    }

    /// The "itemMenu" asset catalog image.
    static var itemMenu: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemMenu)
#else
        .init()
#endif
    }

    /// The "itemPlaceholder" asset catalog image.
    static var itemPlaceholder: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemPlaceholder)
#else
        .init()
#endif
    }

    /// The "lineFlight" asset catalog image.
    static var lineFlight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lineFlight)
#else
        .init()
#endif
    }

    /// The "location" asset catalog image.
    static var location: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .location)
#else
        .init()
#endif
    }

    /// The "location-pin" asset catalog image.
    static var locationPin: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .locationPin)
#else
        .init()
#endif
    }

    /// The "logoPics" asset catalog image.
    static var logoPics: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logoPics)
#else
        .init()
#endif
    }

    /// The "logout_main" asset catalog image.
    static var logoutMain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logoutMain)
#else
        .init()
#endif
    }

    /// The "logoutback" asset catalog image.
    static var logoutback: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logoutback)
#else
        .init()
#endif
    }

    /// The "lost-and-found" asset catalog image.
    static var lostAndFound: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lostAndFound)
#else
        .init()
#endif
    }

    /// The "lostSmilyGreen" asset catalog image.
    static var lostSmilyGreen: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lostSmilyGreen)
#else
        .init()
#endif
    }

    /// The "lowerbackImg" asset catalog image.
    static var lowerbackImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lowerbackImg)
#else
        .init()
#endif
    }

    /// The "mandate_alert" asset catalog image.
    static var mandateAlert: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mandateAlert)
#else
        .init()
#endif
    }

    /// The "max-home-header" asset catalog image.
    static var maxHomeHeader: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maxHomeHeader)
#else
        .init()
#endif
    }

    /// The "max-qr-scan-bg" asset catalog image.
    static var maxQrScanBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maxQrScanBg)
#else
        .init()
#endif
    }

    /// The "max-theme-logi" asset catalog image.
    static var maxThemeLogi: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maxThemeLogi)
#else
        .init()
#endif
    }

    /// The "maxpay_wallet_logo" asset catalog image.
    static var maxpayWalletLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maxpayWalletLogo)
#else
        .init()
#endif
    }

    /// The "maxupi" asset catalog image.
    static var maxupi: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .maxupi)
#else
        .init()
#endif
    }

    /// The "me_chain" asset catalog image.
    static var meChain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meChain)
#else
        .init()
#endif
    }

    /// The "me_logout" asset catalog image.
    static var meLogout: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meLogout)
#else
        .init()
#endif
    }

    /// The "me_milestone" asset catalog image.
    static var meMilestone: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meMilestone)
#else
        .init()
#endif
    }

    /// The "me_monthly_contest" asset catalog image.
    static var meMonthlyContest: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meMonthlyContest)
#else
        .init()
#endif
    }

    /// The "me_ppolicy" asset catalog image.
    static var mePpolicy: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mePpolicy)
#else
        .init()
#endif
    }

    /// The "me_profile" asset catalog image.
    static var meProfile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meProfile)
#else
        .init()
#endif
    }

    /// The "me_rank" asset catalog image.
    static var meRank: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meRank)
#else
        .init()
#endif
    }

    /// The "me_settings" asset catalog image.
    static var meSettings: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .meSettings)
#else
        .init()
#endif
    }

    /// The "menu" asset catalog image.
    static var menu: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .menu)
#else
        .init()
#endif
    }

    /// The "menu-card-ic" asset catalog image.
    static var menuCardIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .menuCardIc)
#else
        .init()
#endif
    }

    /// The "menu-ic" asset catalog image.
    static var menuIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .menuIc)
#else
        .init()
#endif
    }

    /// The "miles" asset catalog image.
    static var miles: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .miles)
#else
        .init()
#endif
    }

    /// The "miles-ic" asset catalog image.
    static var milesIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milesIc)
#else
        .init()
#endif
    }

    /// The "milesBannermile" asset catalog image.
    static var milesBannermile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milesBannermile)
#else
        .init()
#endif
    }

    /// The "milesprogress" asset catalog image.
    static var milesprogress: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milesprogress)
#else
        .init()
#endif
    }

    /// The "milstone40Piller" asset catalog image.
    static var milstone40Piller: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstone40Piller)
#else
        .init()
#endif
    }

    /// The "milstone50Piller" asset catalog image.
    static var milstone50Piller: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstone50Piller)
#else
        .init()
#endif
    }

    /// The "milstoneCardImg" asset catalog image.
    static var milstoneCardImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstoneCardImg)
#else
        .init()
#endif
    }

    /// The "milstoneb2" asset catalog image.
    static var milstoneb2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstoneb2)
#else
        .init()
#endif
    }

    /// The "milstonebrandMacPics" asset catalog image.
    static var milstonebrandMacPics: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstonebrandMacPics)
#else
        .init()
#endif
    }

    /// The "milstonebrandstarPics" asset catalog image.
    static var milstonebrandstarPics: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstonebrandstarPics)
#else
        .init()
#endif
    }

    /// The "milstoneroadPiller" asset catalog image.
    static var milstoneroadPiller: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstoneroadPiller)
#else
        .init()
#endif
    }

    /// The "milstonetoback" asset catalog image.
    static var milstonetoback: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstonetoback)
#else
        .init()
#endif
    }

    /// The "milstonneroad" asset catalog image.
    static var milstonneroad: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .milstonneroad)
#else
        .init()
#endif
    }

    /// The "minusFPop" asset catalog image.
    static var minusFPop: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .minusFPop)
#else
        .init()
#endif
    }

    /// The "minusImg" asset catalog image.
    static var minusImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .minusImg)
#else
        .init()
#endif
    }

    /// The "mobile-online-payment" asset catalog image.
    static var mobileOnlinePayment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mobileOnlinePayment)
#else
        .init()
#endif
    }

    /// The "mobile_number_screen_bg" asset catalog image.
    static var mobileNumberScreenBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mobileNumberScreenBg)
#else
        .init()
#endif
    }

    /// The "mobile_verification_screen_bg" asset catalog image.
    static var mobileVerificationScreenBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mobileVerificationScreenBg)
#else
        .init()
#endif
    }

    /// The "mpin_match" asset catalog image.
    static var mpinMatch: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mpinMatch)
#else
        .init()
#endif
    }

    /// The "multiEarthpic" asset catalog image.
    static var multiEarthpic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .multiEarthpic)
#else
        .init()
#endif
    }

    /// The "my-card-ic" asset catalog image.
    static var myCardIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .myCardIc)
#else
        .init()
#endif
    }

    /// The "my-card2-ic" asset catalog image.
    static var myCard2Ic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .myCard2Ic)
#else
        .init()
#endif
    }

    /// The "my-qr-button" asset catalog image.
    static var myQrButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .myQrButton)
#else
        .init()
#endif
    }

    /// The "netbanking" asset catalog image.
    static var netbanking: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .netbanking)
#else
        .init()
#endif
    }

    /// The "nextArrow" asset catalog image.
    static var nextArrow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .nextArrow)
#else
        .init()
#endif
    }

    /// The "nonRecSeat" asset catalog image.
    static var nonRecSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .nonRecSeat)
#else
        .init()
#endif
    }

    /// The "notAvSeat" asset catalog image.
    static var notAvSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .notAvSeat)
#else
        .init()
#endif
    }

    /// The "notification-ic" asset catalog image.
    static var notificationIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .notificationIc)
#else
        .init()
#endif
    }

    /// The "open" asset catalog image.
    static var open: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .open)
#else
        .init()
#endif
    }

    /// The "openBg" asset catalog image.
    static var openBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .openBg)
#else
        .init()
#endif
    }

    /// The "paid" asset catalog image.
    static var paid: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .paid)
#else
        .init()
#endif
    }

    /// The "payment-failed-ic" asset catalog image.
    static var paymentFailedIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .paymentFailedIc)
#else
        .init()
#endif
    }

    /// The "payment-failed-progress" asset catalog image.
    static var paymentFailedProgress: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .paymentFailedProgress)
#else
        .init()
#endif
    }

    /// The "payment-pending-ic" asset catalog image.
    static var paymentPendingIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .paymentPendingIc)
#else
        .init()
#endif
    }

    /// The "payment-successful-ic" asset catalog image.
    static var paymentSuccessfulIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .paymentSuccessfulIc)
#else
        .init()
#endif
    }

    /// The "penBlack" asset catalog image.
    static var penBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .penBlack)
#else
        .init()
#endif
    }

    /// The "pencil" asset catalog image.
    static var pencil: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pencil)
#else
        .init()
#endif
    }

    /// The "pink_seat" asset catalog image.
    static var pinkSeat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pinkSeat)
#else
        .init()
#endif
    }

    /// The "plusIcon" asset catalog image.
    static var plusIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plusIcon)
#else
        .init()
#endif
    }

    /// The "plusPic" asset catalog image.
    static var plusPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plusPic)
#else
        .init()
#endif
    }

    /// The "polsSeprator" asset catalog image.
    static var polsSeprator: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .polsSeprator)
#else
        .init()
#endif
    }

    /// The "powered_by_upi" asset catalog image.
    static var poweredByUpi: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredByUpi)
#else
        .init()
#endif
    }

    /// The "powered_by_upi_steps" asset catalog image.
    static var poweredByUpiSteps: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredByUpiSteps)
#else
        .init()
#endif
    }

    /// The "powered_count_one" asset catalog image.
    static var poweredCountOne: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredCountOne)
#else
        .init()
#endif
    }

    /// The "powered_count_three" asset catalog image.
    static var poweredCountThree: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredCountThree)
#else
        .init()
#endif
    }

    /// The "powered_count_two" asset catalog image.
    static var poweredCountTwo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredCountTwo)
#else
        .init()
#endif
    }

    /// The "previousArrow" asset catalog image.
    static var previousArrow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .previousArrow)
#else
        .init()
#endif
    }

    /// The "profileBackground" asset catalog image.
    static var profileBackground: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileBackground)
#else
        .init()
#endif
    }

    /// The "qr-scanner-bg" asset catalog image.
    static var qrScannerBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qrScannerBg)
#else
        .init()
#endif
    }

    /// The "qrPic" asset catalog image.
    static var qrPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qrPic)
#else
        .init()
#endif
    }

    /// The "qui02" asset catalog image.
    static var qui02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qui02)
#else
        .init()
#endif
    }

    /// The "quizPicBanner" asset catalog image.
    static var quizPicBanner: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .quizPicBanner)
#else
        .init()
#endif
    }

    /// The "radio-button" asset catalog image.
    static var radioButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .radioButton)
#else
        .init()
#endif
    }

    /// The "radio-on-button" asset catalog image.
    static var radioOnButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .radioOnButton)
#else
        .init()
#endif
    }

    /// The "rankPic" asset catalog image.
    static var rankPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rankPic)
#else
        .init()
#endif
    }

    /// The "refresh" asset catalog image.
    static var refresh: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .refresh)
#else
        .init()
#endif
    }

    /// The "right-ic" asset catalog image.
    static var rightIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rightIc)
#else
        .init()
#endif
    }

    /// The "rightarrowflight" asset catalog image.
    static var rightarrowflight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rightarrowflight)
#else
        .init()
#endif
    }

    /// The "rupay" asset catalog image.
    static var rupay: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rupay)
#else
        .init()
#endif
    }

    /// The "scan-again-button-bg" asset catalog image.
    static var scanAgainButtonBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scanAgainButtonBg)
#else
        .init()
#endif
    }

    /// The "scan-qr-button-ic" asset catalog image.
    static var scanQrButtonIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scanQrButtonIc)
#else
        .init()
#endif
    }

    /// The "scan_overflow" asset catalog image.
    static var scanOverflow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scanOverflow)
#else
        .init()
#endif
    }

    /// The "search" asset catalog image.
    static var search: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .search)
#else
        .init()
#endif
    }

    /// The "search-bar-bg" asset catalog image.
    static var searchBarBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .searchBarBg)
#else
        .init()
#endif
    }

    /// The "search_background_ic" asset catalog image.
    static var searchBackgroundIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .searchBackgroundIc)
#else
        .init()
#endif
    }

    /// The "seatBackPic" asset catalog image.
    static var seatBackPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .seatBackPic)
#else
        .init()
#endif
    }

    /// The "secondry_wallet_img" asset catalog image.
    static var secondryWalletImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .secondryWalletImg)
#else
        .init()
#endif
    }

    /// The "secure" asset catalog image.
    static var secure: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .secure)
#else
        .init()
#endif
    }

    /// The "select-from-gallery" asset catalog image.
    static var selectFromGallery: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .selectFromGallery)
#else
        .init()
#endif
    }

    /// The "selected-tab-line" asset catalog image.
    static var selectedTabLine: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .selectedTabLine)
#else
        .init()
#endif
    }

    /// The "selectedBg" asset catalog image.
    static var selectedBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .selectedBg)
#else
        .init()
#endif
    }

    /// The "sent-from-ic" asset catalog image.
    static var sentFromIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sentFromIc)
#else
        .init()
#endif
    }

    /// The "settingPic" asset catalog image.
    static var settingPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .settingPic)
#else
        .init()
#endif
    }

    /// The "setypin_screen_bg" asset catalog image.
    static var setypinScreenBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .setypinScreenBg)
#else
        .init()
#endif
    }

    /// The "share-history-ic" asset catalog image.
    static var shareHistoryIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shareHistoryIc)
#else
        .init()
#endif
    }

    /// The "share-ic" asset catalog image.
    static var shareIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shareIc)
#else
        .init()
#endif
    }

    /// The "share-qr-ic" asset catalog image.
    static var shareQrIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shareQrIc)
#else
        .init()
#endif
    }

    /// The "sharePic" asset catalog image.
    static var sharePic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sharePic)
#else
        .init()
#endif
    }

    /// The "skipbutton" asset catalog image.
    static var skipbutton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .skipbutton)
#else
        .init()
#endif
    }

    /// The "sofa" asset catalog image.
    static var sofa: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sofa)
#else
        .init()
#endif
    }

    /// The "spinnerdownarr" asset catalog image.
    static var spinnerdownarr: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .spinnerdownarr)
#else
        .init()
#endif
    }

    /// The "splash" asset catalog image.
    static var splash: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .splash)
#else
        .init()
#endif
    }

    /// The "swap_arrow" asset catalog image.
    static var swapArrow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .swapArrow)
#else
        .init()
#endif
    }

    /// The "tab-home-ic" asset catalog image.
    static var tabHomeIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabHomeIc)
#else
        .init()
#endif
    }

    /// The "tab-myexpense-ic" asset catalog image.
    static var tabMyexpenseIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabMyexpenseIc)
#else
        .init()
#endif
    }

    /// The "tab-profile-ic" asset catalog image.
    static var tabProfileIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabProfileIc)
#else
        .init()
#endif
    }

    /// The "tab-qrscan" asset catalog image.
    static var tabQrscan: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabQrscan)
#else
        .init()
#endif
    }

    /// The "tab-quiz-ic" asset catalog image.
    static var tabQuizIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tabQuizIc)
#else
        .init()
#endif
    }

    /// The "target" asset catalog image.
    static var target: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .target)
#else
        .init()
#endif
    }

    /// The "termsPics" asset catalog image.
    static var termsPics: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .termsPics)
#else
        .init()
#endif
    }

    /// The "timePic" asset catalog image.
    static var timePic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .timePic)
#else
        .init()
#endif
    }

    /// The "toggle-off-button" asset catalog image.
    static var toggleOffButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .toggleOffButton)
#else
        .init()
#endif
    }

    /// The "toggle-on-button" asset catalog image.
    static var toggleOnButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .toggleOnButton)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Four" asset catalog image.
    static var transIndicatiorFour: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transIndicatiorFour)
#else
        .init()
#endif
    }

    /// The "transIndicatior_One" asset catalog image.
    static var transIndicatiorOne: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transIndicatiorOne)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Three" asset catalog image.
    static var transIndicatiorThree: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transIndicatiorThree)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Two" asset catalog image.
    static var transIndicatiorTwo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transIndicatiorTwo)
#else
        .init()
#endif
    }

    /// The "transIndicatior_five" asset catalog image.
    static var transIndicatiorFive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transIndicatiorFive)
#else
        .init()
#endif
    }

    /// The "transactionIndicator_pending_progress" asset catalog image.
    static var transactionIndicatorPendingProgress: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transactionIndicatorPendingProgress)
#else
        .init()
#endif
    }

    /// The "transaction_row_bg" asset catalog image.
    static var transactionRowBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transactionRowBg)
#else
        .init()
#endif
    }

    /// The "transfer-amount-ic" asset catalog image.
    static var transferAmountIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .transferAmountIc)
#else
        .init()
#endif
    }

    /// The "travel-bus-ic" asset catalog image.
    static var travelBusIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .travelBusIc)
#else
        .init()
#endif
    }

    /// The "travel-flight-ic" asset catalog image.
    static var travelFlightIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .travelFlightIc)
#else
        .init()
#endif
    }

    /// The "travel-hotel-ic" asset catalog image.
    static var travelHotelIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .travelHotelIc)
#else
        .init()
#endif
    }

    /// The "travel-luggage" asset catalog image.
    static var travelLuggage: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .travelLuggage)
#else
        .init()
#endif
    }

    /// The "trend" asset catalog image.
    static var trend: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .trend)
#else
        .init()
#endif
    }

    /// The "twayPic" asset catalog image.
    static var twayPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .twayPic)
#else
        .init()
#endif
    }

    /// The "umbrella" asset catalog image.
    static var umbrella: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .umbrella)
#else
        .init()
#endif
    }

    /// The "uncheck" asset catalog image.
    static var uncheck: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .uncheck)
#else
        .init()
#endif
    }

    /// The "up-arrow-ic" asset catalog image.
    static var upArrowIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .upArrowIc)
#else
        .init()
#endif
    }

    /// The "upi-home-header" asset catalog image.
    static var upiHomeHeader: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .upiHomeHeader)
#else
        .init()
#endif
    }

    /// The "userPic" asset catalog image.
    static var userPic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .userPic)
#else
        .init()
#endif
    }

    /// The "wallet_secondry_img" asset catalog image.
    static var walletSecondryImg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .walletSecondryImg)
#else
        .init()
#endif
    }

    /// The "wealth" asset catalog image.
    static var wealth: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wealth)
#else
        .init()
#endif
    }

    /// The "weather" asset catalog image.
    static var weather: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .weather)
#else
        .init()
#endif
    }

    /// The "white_shadowed_bg" asset catalog image.
    static var whiteShadowedBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .whiteShadowedBg)
#else
        .init()
#endif
    }

    /// The "winnerToppic" asset catalog image.
    static var winnerToppic: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .winnerToppic)
#else
        .init()
#endif
    }

    /// The "wrong-ic" asset catalog image.
    static var wrongIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wrongIc)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "AC" asset catalog image.
    static var AC: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .AC)
#else
        .init()
#endif
    }

    /// The "Beneficiary" asset catalog image.
    static var beneficiary: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .beneficiary)
#else
        .init()
#endif
    }

    /// The "Blanket" asset catalog image.
    static var blanket: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .blanket)
#else
        .init()
#endif
    }

    /// The "Block List" asset catalog image.
    static var blockList: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .blockList)
#else
        .init()
#endif
    }

    /// The "Charging-Point" asset catalog image.
    static var chargingPoint: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chargingPoint)
#else
        .init()
#endif
    }

    /// The "DeRegister UPI" asset catalog image.
    static var deRegisterUPI: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .deRegisterUPI)
#else
        .init()
#endif
    }

    /// The "Emergency-Exit" asset catalog image.
    static var emergencyExit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emergencyExit)
#else
        .init()
#endif
    }

    /// The "Fire-Extinguisher" asset catalog image.
    static var fireExtinguisher: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fireExtinguisher)
#else
        .init()
#endif
    }

    /// The "First-Aid-Box" asset catalog image.
    static var firstAidBox: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .firstAidBox)
#else
        .init()
#endif
    }

    /// The "FloatingControlBg" asset catalog image.
    static var floatingControlBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .floatingControlBg)
#else
        .init()
#endif
    }

    /// The "FloatingMenuBG" asset catalog image.
    static var floatingMenuBG: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .floatingMenuBG)
#else
        .init()
#endif
    }

    /// The "GPS-Tracking" asset catalog image.
    static var gpsTracking: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .gpsTracking)
#else
        .init()
#endif
    }

    /// The "Hammer" asset catalog image.
    static var hammer: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .hammer)
#else
        .init()
#endif
    }

    /// The "Hand-Sanitizer" asset catalog image.
    static var handSanitizer: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .handSanitizer)
#else
        .init()
#endif
    }

    /// The "Image" asset catalog image.
    static var image: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Intro1" asset catalog image.
    static var intro1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .intro1)
#else
        .init()
#endif
    }

    /// The "Intro2" asset catalog image.
    static var intro2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .intro2)
#else
        .init()
#endif
    }

    /// The "Intro3" asset catalog image.
    static var intro3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .intro3)
#else
        .init()
#endif
    }

    /// The "Intro4" asset catalog image.
    static var intro4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .intro4)
#else
        .init()
#endif
    }

    /// The "Intro5" asset catalog image.
    static var intro5: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .intro5)
#else
        .init()
#endif
    }

    /// The "Manage UPI ID" asset catalog image.
    static var manageUPIID: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .manageUPIID)
#else
        .init()
#endif
    }

    /// The "Manage UPI Number" asset catalog image.
    static var manageUPINumber: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .manageUPINumber)
#else
        .init()
#endif
    }

    /// The "Pillow" asset catalog image.
    static var pillow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pillow)
#else
        .init()
#endif
    }

    /// The "Qeflight" asset catalog image.
    static var qeflight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qeflight)
#else
        .init()
#endif
    }

    /// The "Reading-Light" asset catalog image.
    static var readingLight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .readingLight)
#else
        .init()
#endif
    }

    /// The "Rectanglecard" asset catalog image.
    static var rectanglecard: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rectanglecard)
#else
        .init()
#endif
    }

    /// The "Remove All Cache" asset catalog image.
    static var removeAllCache: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .removeAllCache)
#else
        .init()
#endif
    }

    /// The "Request Money" asset catalog image.
    static var requestMoney: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .requestMoney)
#else
        .init()
#endif
    }

    /// The "Request Money to Contact or UPI ID" asset catalog image.
    static var requestMoneyToContactOrUPIID: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .requestMoneyToContactOrUPIID)
#else
        .init()
#endif
    }

    /// The "Send Money to Bank Account" asset catalog image.
    static var sendMoneyToBankAccount: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sendMoneyToBankAccount)
#else
        .init()
#endif
    }

    /// The "Send Money to Contact or UPI ID" asset catalog image.
    static var sendMoneyToContactOrUPIID: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sendMoneyToContactOrUPIID)
#else
        .init()
#endif
    }

    /// The "Staff" asset catalog image.
    static var staff: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .staff)
#else
        .init()
#endif
    }

    /// The "TV" asset catalog image.
    static var TV: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .TV)
#else
        .init()
#endif
    }

    /// The "Toilet" asset catalog image.
    static var toilet: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .toilet)
#else
        .init()
#endif
    }

    /// The "Transaction History" asset catalog image.
    static var transactionHistory: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transactionHistory)
#else
        .init()
#endif
    }

    /// The "UPI Autopay" asset catalog image.
    static var upiAutopay: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .upiAutopay)
#else
        .init()
#endif
    }

    /// The "UPIIconIImage" asset catalog image.
    static var upiIconI: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .upiIconI)
#else
        .init()
#endif
    }

    /// The "UPIPayment" asset catalog image.
    static var upiPayment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .upiPayment)
#else
        .init()
#endif
    }

    /// The "Water-Bottle" asset catalog image.
    static var waterBottle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .waterBottle)
#else
        .init()
#endif
    }

    /// The "WiFi" asset catalog image.
    static var wiFi: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wiFi)
#else
        .init()
#endif
    }

    #warning("The \"add\" image asset name resolves to a conflicting UIImage symbol \"add\". Try renaming the asset.")

    /// The "addFPop" asset catalog image.
    static var addFPop: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .addFPop)
#else
        .init()
#endif
    }

    /// The "addpriv" asset catalog image.
    static var addpriv: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .addpriv)
#else
        .init()
#endif
    }

    /// The "avSeat" asset catalog image.
    static var avSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .avSeat)
#else
        .init()
#endif
    }

    /// The "backarrow" asset catalog image.
    static var backarrow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .backarrow)
#else
        .init()
#endif
    }

    /// The "backgroundImg" asset catalog image.
    static var backgroundImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .backgroundImg)
#else
        .init()
#endif
    }

    /// The "bank_logo" asset catalog image.
    static var bankLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bankLogo)
#else
        .init()
#endif
    }

    /// The "bannerQuiz" asset catalog image.
    static var bannerQuiz: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bannerQuiz)
#else
        .init()
#endif
    }

    /// The "barcodeFlight" asset catalog image.
    static var barcodeFlight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .barcodeFlight)
#else
        .init()
#endif
    }

    /// The "bbps_logo" asset catalog image.
    static var bbpsLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bbpsLogo)
#else
        .init()
#endif
    }

    /// The "beneficiary-name-ic" asset catalog image.
    static var beneficiaryNameIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .beneficiaryNameIc)
#else
        .init()
#endif
    }

    /// The "beneficiary-upiid-ic" asset catalog image.
    static var beneficiaryUpiidIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .beneficiaryUpiidIc)
#else
        .init()
#endif
    }

    /// The "bg-home-header-green" asset catalog image.
    static var bgHomeHeaderGreen: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bgHomeHeaderGreen)
#else
        .init()
#endif
    }

    /// The "bg-home-header-white" asset catalog image.
    static var bgHomeHeaderWhite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bgHomeHeaderWhite)
#else
        .init()
#endif
    }

    /// The "bhim" asset catalog image.
    static var bhim: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bhim)
#else
        .init()
#endif
    }

    /// The "bhim-upi-ic" asset catalog image.
    static var bhimUpiIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bhimUpiIc)
#else
        .init()
#endif
    }

    /// The "bhimImg" asset catalog image.
    static var bhimImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bhimImg)
#else
        .init()
#endif
    }

    /// The "bill" asset catalog image.
    static var bill: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bill)
#else
        .init()
#endif
    }

    /// The "black_seat" asset catalog image.
    static var blackSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .blackSeat)
#else
        .init()
#endif
    }

    /// The "bnkImg" asset catalog image.
    static var bnkImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bnkImg)
#else
        .init()
#endif
    }

    /// The "bookedSeat" asset catalog image.
    static var bookedSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bookedSeat)
#else
        .init()
#endif
    }

    /// The "borderGreenPic" asset catalog image.
    static var borderGreenPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .borderGreenPic)
#else
        .init()
#endif
    }

    /// The "bus-drop-point-tab" asset catalog image.
    static var busDropPointTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .busDropPointTab)
#else
        .init()
#endif
    }

    /// The "bus-pickup-point-tab" asset catalog image.
    static var busPickupPointTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .busPickupPointTab)
#else
        .init()
#endif
    }

    /// The "bus-select-seat-tab" asset catalog image.
    static var busSelectSeatTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .busSelectSeatTab)
#else
        .init()
#endif
    }

    /// The "bus-serchticket-bg" asset catalog image.
    static var busSerchticketBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .busSerchticketBg)
#else
        .init()
#endif
    }

    /// The "calender-history-ic" asset catalog image.
    static var calenderHistoryIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .calenderHistoryIc)
#else
        .init()
#endif
    }

    /// The "card" asset catalog image.
    static var card: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .card)
#else
        .init()
#endif
    }

    /// The "card-bgview-ic" asset catalog image.
    static var cardBgviewIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardBgviewIc)
#else
        .init()
#endif
    }

    /// The "card-chip-ic" asset catalog image.
    static var cardChipIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardChipIc)
#else
        .init()
#endif
    }

    /// The "card-home-upper" asset catalog image.
    static var cardHomeUpper: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardHomeUpper)
#else
        .init()
#endif
    }

    /// The "card-uparrow-ic" asset catalog image.
    static var cardUparrowIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardUparrowIc)
#else
        .init()
#endif
    }

    /// The "cardBBack" asset catalog image.
    static var cardBBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardBBack)
#else
        .init()
#endif
    }

    /// The "cardBackPro" asset catalog image.
    static var cardBackPro: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardBackPro)
#else
        .init()
#endif
    }

    /// The "cardFBack" asset catalog image.
    static var cardFBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardFBack)
#else
        .init()
#endif
    }

    /// The "cardGrBack" asset catalog image.
    static var cardGrBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardGrBack)
#else
        .init()
#endif
    }

    /// The "cardRBack" asset catalog image.
    static var cardRBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cardRBack)
#else
        .init()
#endif
    }

    /// The "catagory_bg" asset catalog image.
    static var catagoryBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .catagoryBg)
#else
        .init()
#endif
    }

    /// The "catagory_item" asset catalog image.
    static var catagoryItem: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .catagoryItem)
#else
        .init()
#endif
    }

    /// The "chainPic" asset catalog image.
    static var chainPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chainPic)
#else
        .init()
#endif
    }

    /// The "chainProgressLine" asset catalog image.
    static var chainProgressLine: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chainProgressLine)
#else
        .init()
#endif
    }

    /// The "chainTopImg" asset catalog image.
    static var chainTopImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chainTopImg)
#else
        .init()
#endif
    }

    /// The "check" asset catalog image.
    static var check: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .check)
#else
        .init()
#endif
    }

    /// The "circle-boarding-notselected" asset catalog image.
    static var circleBoardingNotselected: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .circleBoardingNotselected)
#else
        .init()
#endif
    }

    /// The "circle-boarding-selected" asset catalog image.
    static var circleBoardingSelected: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .circleBoardingSelected)
#else
        .init()
#endif
    }

    /// The "claimBg" asset catalog image.
    static var claimBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .claimBg)
#else
        .init()
#endif
    }

    /// The "close" asset catalog image.
    static var close: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .close)
#else
        .init()
#endif
    }

    /// The "close-button-ic" asset catalog image.
    static var closeButtonIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .closeButtonIc)
#else
        .init()
#endif
    }

    /// The "complaint-submitted-ic" asset catalog image.
    static var complaintSubmittedIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .complaintSubmittedIc)
#else
        .init()
#endif
    }

    /// The "complete_statusImg" asset catalog image.
    static var completeStatusImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .completeStatusImg)
#else
        .init()
#endif
    }

    /// The "conplaint-home" asset catalog image.
    static var conplaintHome: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .conplaintHome)
#else
        .init()
#endif
    }

    /// The "createQRMandateVC" asset catalog image.
    static var createQRMandateVC: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .createQRMandateVC)
#else
        .init()
#endif
    }

    /// The "deactivePhone" asset catalog image.
    static var deactivePhone: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .deactivePhone)
#else
        .init()
#endif
    }

    /// The "debit_cd_back" asset catalog image.
    static var debitCdBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .debitCdBack)
#else
        .init()
#endif
    }

    /// The "debit_image" asset catalog image.
    static var debit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .debit)
#else
        .init()
#endif
    }

    /// The "default_maxpe_profile" asset catalog image.
    static var defaultMaxpeProfile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .defaultMaxpeProfile)
#else
        .init()
#endif
    }

    /// The "default_maxpe_profile 1" asset catalog image.
    static var defaultMaxpeProfile1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .defaultMaxpeProfile1)
#else
        .init()
#endif
    }

    /// The "delete" asset catalog image.
    static var delete: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .delete)
#else
        .init()
#endif
    }

    /// The "dotted-horizontal-line-ic" asset catalog image.
    static var dottedHorizontalLineIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dottedHorizontalLineIc)
#else
        .init()
#endif
    }

    /// The "dotted-vertical-line-ic" asset catalog image.
    static var dottedVerticalLineIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dottedVerticalLineIc)
#else
        .init()
#endif
    }

    /// The "dotted-vertical-point-line-ic" asset catalog image.
    static var dottedVerticalPointLineIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dottedVerticalPointLineIc)
#else
        .init()
#endif
    }

    /// The "downld" asset catalog image.
    static var downld: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .downld)
#else
        .init()
#endif
    }

    /// The "eclanatyionmark" asset catalog image.
    static var eclanatyionmark: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eclanatyionmark)
#else
        .init()
#endif
    }

    /// The "elipse" asset catalog image.
    static var elipse: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .elipse)
#else
        .init()
#endif
    }

    /// The "english" asset catalog image.
    static var english: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .english)
#else
        .init()
#endif
    }

    /// The "enter_pin_screen_bg" asset catalog image.
    static var enterPinScreenBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .enterPinScreenBg)
#else
        .init()
#endif
    }

    /// The "extraLSeat" asset catalog image.
    static var extraLSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .extraLSeat)
#else
        .init()
#endif
    }

    /// The "eye-ic" asset catalog image.
    static var eyeIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eyeIc)
#else
        .init()
#endif
    }

    /// The "failed" asset catalog image.
    static var failed: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .failed)
#else
        .init()
#endif
    }

    /// The "filter-history-ic" asset catalog image.
    static var filterHistoryIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .filterHistoryIc)
#else
        .init()
#endif
    }

    /// The "flash-off-ic" asset catalog image.
    static var flashOffIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flashOffIc)
#else
        .init()
#endif
    }

    /// The "flash-on-ic" asset catalog image.
    static var flashOnIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flashOnIc)
#else
        .init()
#endif
    }

    /// The "flightFromto" asset catalog image.
    static var flightFromto: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flightFromto)
#else
        .init()
#endif
    }

    /// The "flightPic" asset catalog image.
    static var flightPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flightPic)
#else
        .init()
#endif
    }

    /// The "flightTicketBackPic" asset catalog image.
    static var flightTicketBackPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flightTicketBackPic)
#else
        .init()
#endif
    }

    /// The "flightTopPic" asset catalog image.
    static var flightTopPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flightTopPic)
#else
        .init()
#endif
    }

    /// The "foundSmilyBgGreen" asset catalog image.
    static var foundSmilyBgGreen: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .foundSmilyBgGreen)
#else
        .init()
#endif
    }

    /// The "green_seat" asset catalog image.
    static var greenSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .greenSeat)
#else
        .init()
#endif
    }

    /// The "grey_seat" asset catalog image.
    static var greySeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .greySeat)
#else
        .init()
#endif
    }

    /// The "handle" asset catalog image.
    static var handle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .handle)
#else
        .init()
#endif
    }

    /// The "hotelsamplePic" asset catalog image.
    static var hotelsamplePic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .hotelsamplePic)
#else
        .init()
#endif
    }

    /// The "icComplaint" asset catalog image.
    static var icComplaint: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icComplaint)
#else
        .init()
#endif
    }

    /// The "icMaxUPI" asset catalog image.
    static var icMaxUPI: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icMaxUPI)
#else
        .init()
#endif
    }

    /// The "icProfile" asset catalog image.
    static var icProfile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icProfile)
#else
        .init()
#endif
    }

    /// The "icScanQR" asset catalog image.
    static var icScanQR: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icScanQR)
#else
        .init()
#endif
    }

    /// The "icShareQR" asset catalog image.
    static var icShareQR: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icShareQR)
#else
        .init()
#endif
    }

    /// The "ic_arrow_back_24" asset catalog image.
    static var icArrowBack24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icArrowBack24)
#else
        .init()
#endif
    }

    /// The "ic_arrow_down" asset catalog image.
    static var icArrowDown: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icArrowDown)
#else
        .init()
#endif
    }

    /// The "ic_arrow_up" asset catalog image.
    static var icArrowUp: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icArrowUp)
#else
        .init()
#endif
    }

    /// The "ic_baseline_add_circle_24" asset catalog image.
    static var icBaselineAddCircle24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineAddCircle24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_block_24" asset catalog image.
    static var icBaselineBlock24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineBlock24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_calendar" asset catalog image.
    static var icBaselineCalendar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineCalendar)
#else
        .init()
#endif
    }

    /// The "ic_baseline_calendar_today_24" asset catalog image.
    static var icBaselineCalendarToday24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineCalendarToday24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_history_24" asset catalog image.
    static var icBaselineHistory24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineHistory24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_keyboard_arrow_down_24" asset catalog image.
    static var icBaselineKeyboardArrowDown24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineKeyboardArrowDown24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_keyboard_arrow_right_24 1" asset catalog image.
    static var icBaselineKeyboardArrowRight241: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineKeyboardArrowRight241)
#else
        .init()
#endif
    }

    /// The "ic_baseline_people_alt_24" asset catalog image.
    static var icBaselinePeopleAlt24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselinePeopleAlt24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_qr_code_24" asset catalog image.
    static var icBaselineQrCode24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineQrCode24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_search_24" asset catalog image.
    static var icBaselineSearch24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineSearch24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_sim_card_24" asset catalog image.
    static var icBaselineSimCard24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineSimCard24)
#else
        .init()
#endif
    }

    /// The "ic_baseline_transfer" asset catalog image.
    static var icBaselineTransfer: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineTransfer)
#else
        .init()
#endif
    }

    /// The "ic_baseline_trending_flat_24" asset catalog image.
    static var icBaselineTrendingFlat24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBaselineTrendingFlat24)
#else
        .init()
#endif
    }

    /// The "ic_home_transfer" asset catalog image.
    static var icHomeTransfer: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeTransfer)
#else
        .init()
#endif
    }

    /// The "ic_onboarding_1" asset catalog image.
    static var icOnboarding1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icOnboarding1)
#else
        .init()
#endif
    }

    /// The "ic_options_bg" asset catalog image.
    static var icOptionsBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icOptionsBg)
#else
        .init()
#endif
    }

    /// The "idea-exchange" asset catalog image.
    static var ideaExchange: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ideaExchange)
#else
        .init()
#endif
    }

    /// The "imgThumb" asset catalog image.
    static var imgThumb: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgThumb)
#else
        .init()
#endif
    }

    /// The "imgphone" asset catalog image.
    static var imgphone: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imgphone)
#else
        .init()
#endif
    }

    /// The "india" asset catalog image.
    static var india: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .india)
#else
        .init()
#endif
    }

    /// The "info-ic" asset catalog image.
    static var infoIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .infoIc)
#else
        .init()
#endif
    }

    /// The "infoPics" asset catalog image.
    static var infoPics: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .infoPics)
#else
        .init()
#endif
    }

    /// The "itemBg" asset catalog image.
    static var itemBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemBg)
#else
        .init()
#endif
    }

    /// The "itemBgLarge" asset catalog image.
    static var itemBgLarge: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemBgLarge)
#else
        .init()
#endif
    }

    /// The "itemHeaderBg" asset catalog image.
    static var itemHeaderBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemHeaderBg)
#else
        .init()
#endif
    }

    /// The "itemMenu" asset catalog image.
    static var itemMenu: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemMenu)
#else
        .init()
#endif
    }

    /// The "itemPlaceholder" asset catalog image.
    static var itemPlaceholder: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemPlaceholder)
#else
        .init()
#endif
    }

    /// The "lineFlight" asset catalog image.
    static var lineFlight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lineFlight)
#else
        .init()
#endif
    }

    /// The "location" asset catalog image.
    static var location: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .location)
#else
        .init()
#endif
    }

    /// The "location-pin" asset catalog image.
    static var locationPin: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .locationPin)
#else
        .init()
#endif
    }

    /// The "logoPics" asset catalog image.
    static var logoPics: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logoPics)
#else
        .init()
#endif
    }

    /// The "logout_main" asset catalog image.
    static var logoutMain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logoutMain)
#else
        .init()
#endif
    }

    /// The "logoutback" asset catalog image.
    static var logoutback: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logoutback)
#else
        .init()
#endif
    }

    /// The "lost-and-found" asset catalog image.
    static var lostAndFound: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lostAndFound)
#else
        .init()
#endif
    }

    /// The "lostSmilyGreen" asset catalog image.
    static var lostSmilyGreen: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lostSmilyGreen)
#else
        .init()
#endif
    }

    /// The "lowerbackImg" asset catalog image.
    static var lowerbackImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lowerbackImg)
#else
        .init()
#endif
    }

    /// The "mandate_alert" asset catalog image.
    static var mandateAlert: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mandateAlert)
#else
        .init()
#endif
    }

    /// The "max-home-header" asset catalog image.
    static var maxHomeHeader: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maxHomeHeader)
#else
        .init()
#endif
    }

    /// The "max-qr-scan-bg" asset catalog image.
    static var maxQrScanBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maxQrScanBg)
#else
        .init()
#endif
    }

    /// The "max-theme-logi" asset catalog image.
    static var maxThemeLogi: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maxThemeLogi)
#else
        .init()
#endif
    }

    /// The "maxpay_wallet_logo" asset catalog image.
    static var maxpayWalletLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maxpayWalletLogo)
#else
        .init()
#endif
    }

    /// The "maxupi" asset catalog image.
    static var maxupi: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .maxupi)
#else
        .init()
#endif
    }

    /// The "me_chain" asset catalog image.
    static var meChain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meChain)
#else
        .init()
#endif
    }

    /// The "me_logout" asset catalog image.
    static var meLogout: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meLogout)
#else
        .init()
#endif
    }

    /// The "me_milestone" asset catalog image.
    static var meMilestone: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meMilestone)
#else
        .init()
#endif
    }

    /// The "me_monthly_contest" asset catalog image.
    static var meMonthlyContest: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meMonthlyContest)
#else
        .init()
#endif
    }

    /// The "me_ppolicy" asset catalog image.
    static var mePpolicy: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mePpolicy)
#else
        .init()
#endif
    }

    /// The "me_profile" asset catalog image.
    static var meProfile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meProfile)
#else
        .init()
#endif
    }

    /// The "me_rank" asset catalog image.
    static var meRank: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meRank)
#else
        .init()
#endif
    }

    /// The "me_settings" asset catalog image.
    static var meSettings: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .meSettings)
#else
        .init()
#endif
    }

    /// The "menu" asset catalog image.
    static var menu: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .menu)
#else
        .init()
#endif
    }

    /// The "menu-card-ic" asset catalog image.
    static var menuCardIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .menuCardIc)
#else
        .init()
#endif
    }

    /// The "menu-ic" asset catalog image.
    static var menuIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .menuIc)
#else
        .init()
#endif
    }

    /// The "miles" asset catalog image.
    static var miles: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .miles)
#else
        .init()
#endif
    }

    /// The "miles-ic" asset catalog image.
    static var milesIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milesIc)
#else
        .init()
#endif
    }

    /// The "milesBannermile" asset catalog image.
    static var milesBannermile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milesBannermile)
#else
        .init()
#endif
    }

    /// The "milesprogress" asset catalog image.
    static var milesprogress: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milesprogress)
#else
        .init()
#endif
    }

    /// The "milstone40Piller" asset catalog image.
    static var milstone40Piller: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstone40Piller)
#else
        .init()
#endif
    }

    /// The "milstone50Piller" asset catalog image.
    static var milstone50Piller: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstone50Piller)
#else
        .init()
#endif
    }

    /// The "milstoneCardImg" asset catalog image.
    static var milstoneCardImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstoneCardImg)
#else
        .init()
#endif
    }

    /// The "milstoneb2" asset catalog image.
    static var milstoneb2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstoneb2)
#else
        .init()
#endif
    }

    /// The "milstonebrandMacPics" asset catalog image.
    static var milstonebrandMacPics: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstonebrandMacPics)
#else
        .init()
#endif
    }

    /// The "milstonebrandstarPics" asset catalog image.
    static var milstonebrandstarPics: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstonebrandstarPics)
#else
        .init()
#endif
    }

    /// The "milstoneroadPiller" asset catalog image.
    static var milstoneroadPiller: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstoneroadPiller)
#else
        .init()
#endif
    }

    /// The "milstonetoback" asset catalog image.
    static var milstonetoback: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstonetoback)
#else
        .init()
#endif
    }

    /// The "milstonneroad" asset catalog image.
    static var milstonneroad: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .milstonneroad)
#else
        .init()
#endif
    }

    /// The "minusFPop" asset catalog image.
    static var minusFPop: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .minusFPop)
#else
        .init()
#endif
    }

    /// The "minusImg" asset catalog image.
    static var minusImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .minusImg)
#else
        .init()
#endif
    }

    /// The "mobile-online-payment" asset catalog image.
    static var mobileOnlinePayment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mobileOnlinePayment)
#else
        .init()
#endif
    }

    /// The "mobile_number_screen_bg" asset catalog image.
    static var mobileNumberScreenBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mobileNumberScreenBg)
#else
        .init()
#endif
    }

    /// The "mobile_verification_screen_bg" asset catalog image.
    static var mobileVerificationScreenBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mobileVerificationScreenBg)
#else
        .init()
#endif
    }

    /// The "mpin_match" asset catalog image.
    static var mpinMatch: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mpinMatch)
#else
        .init()
#endif
    }

    /// The "multiEarthpic" asset catalog image.
    static var multiEarthpic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .multiEarthpic)
#else
        .init()
#endif
    }

    /// The "my-card-ic" asset catalog image.
    static var myCardIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .myCardIc)
#else
        .init()
#endif
    }

    /// The "my-card2-ic" asset catalog image.
    static var myCard2Ic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .myCard2Ic)
#else
        .init()
#endif
    }

    /// The "my-qr-button" asset catalog image.
    static var myQrButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .myQrButton)
#else
        .init()
#endif
    }

    /// The "netbanking" asset catalog image.
    static var netbanking: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .netbanking)
#else
        .init()
#endif
    }

    /// The "nextArrow" asset catalog image.
    static var nextArrow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .nextArrow)
#else
        .init()
#endif
    }

    /// The "nonRecSeat" asset catalog image.
    static var nonRecSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .nonRecSeat)
#else
        .init()
#endif
    }

    /// The "notAvSeat" asset catalog image.
    static var notAvSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .notAvSeat)
#else
        .init()
#endif
    }

    /// The "notification-ic" asset catalog image.
    static var notificationIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .notificationIc)
#else
        .init()
#endif
    }

    /// The "open" asset catalog image.
    static var open: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .open)
#else
        .init()
#endif
    }

    /// The "openBg" asset catalog image.
    static var openBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .openBg)
#else
        .init()
#endif
    }

    /// The "paid" asset catalog image.
    static var paid: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .paid)
#else
        .init()
#endif
    }

    /// The "payment-failed-ic" asset catalog image.
    static var paymentFailedIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .paymentFailedIc)
#else
        .init()
#endif
    }

    /// The "payment-failed-progress" asset catalog image.
    static var paymentFailedProgress: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .paymentFailedProgress)
#else
        .init()
#endif
    }

    /// The "payment-pending-ic" asset catalog image.
    static var paymentPendingIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .paymentPendingIc)
#else
        .init()
#endif
    }

    /// The "payment-successful-ic" asset catalog image.
    static var paymentSuccessfulIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .paymentSuccessfulIc)
#else
        .init()
#endif
    }

    /// The "penBlack" asset catalog image.
    static var penBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .penBlack)
#else
        .init()
#endif
    }

    /// The "pencil" asset catalog image.
    static var pencil: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pencil)
#else
        .init()
#endif
    }

    /// The "pink_seat" asset catalog image.
    static var pinkSeat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pinkSeat)
#else
        .init()
#endif
    }

    /// The "plusIcon" asset catalog image.
    static var plusIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plusIcon)
#else
        .init()
#endif
    }

    /// The "plusPic" asset catalog image.
    static var plusPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plusPic)
#else
        .init()
#endif
    }

    /// The "polsSeprator" asset catalog image.
    static var polsSeprator: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .polsSeprator)
#else
        .init()
#endif
    }

    /// The "powered_by_upi" asset catalog image.
    static var poweredByUpi: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredByUpi)
#else
        .init()
#endif
    }

    /// The "powered_by_upi_steps" asset catalog image.
    static var poweredByUpiSteps: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredByUpiSteps)
#else
        .init()
#endif
    }

    /// The "powered_count_one" asset catalog image.
    static var poweredCountOne: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredCountOne)
#else
        .init()
#endif
    }

    /// The "powered_count_three" asset catalog image.
    static var poweredCountThree: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredCountThree)
#else
        .init()
#endif
    }

    /// The "powered_count_two" asset catalog image.
    static var poweredCountTwo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredCountTwo)
#else
        .init()
#endif
    }

    /// The "previousArrow" asset catalog image.
    static var previousArrow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .previousArrow)
#else
        .init()
#endif
    }

    /// The "profileBackground" asset catalog image.
    static var profileBackground: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileBackground)
#else
        .init()
#endif
    }

    /// The "qr-scanner-bg" asset catalog image.
    static var qrScannerBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qrScannerBg)
#else
        .init()
#endif
    }

    /// The "qrPic" asset catalog image.
    static var qrPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qrPic)
#else
        .init()
#endif
    }

    /// The "qui02" asset catalog image.
    static var qui02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qui02)
#else
        .init()
#endif
    }

    /// The "quizPicBanner" asset catalog image.
    static var quizPicBanner: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .quizPicBanner)
#else
        .init()
#endif
    }

    /// The "radio-button" asset catalog image.
    static var radioButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .radioButton)
#else
        .init()
#endif
    }

    /// The "radio-on-button" asset catalog image.
    static var radioOnButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .radioOnButton)
#else
        .init()
#endif
    }

    /// The "rankPic" asset catalog image.
    static var rankPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rankPic)
#else
        .init()
#endif
    }

    /// The "refresh" asset catalog image.
    static var refresh: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .refresh)
#else
        .init()
#endif
    }

    /// The "right-ic" asset catalog image.
    static var rightIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rightIc)
#else
        .init()
#endif
    }

    /// The "rightarrowflight" asset catalog image.
    static var rightarrowflight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rightarrowflight)
#else
        .init()
#endif
    }

    /// The "rupay" asset catalog image.
    static var rupay: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rupay)
#else
        .init()
#endif
    }

    /// The "scan-again-button-bg" asset catalog image.
    static var scanAgainButtonBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scanAgainButtonBg)
#else
        .init()
#endif
    }

    /// The "scan-qr-button-ic" asset catalog image.
    static var scanQrButtonIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scanQrButtonIc)
#else
        .init()
#endif
    }

    /// The "scan_overflow" asset catalog image.
    static var scanOverflow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scanOverflow)
#else
        .init()
#endif
    }

    /// The "search" asset catalog image.
    static var search: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .search)
#else
        .init()
#endif
    }

    /// The "search-bar-bg" asset catalog image.
    static var searchBarBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .searchBarBg)
#else
        .init()
#endif
    }

    /// The "search_background_ic" asset catalog image.
    static var searchBackgroundIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .searchBackgroundIc)
#else
        .init()
#endif
    }

    /// The "seatBackPic" asset catalog image.
    static var seatBackPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .seatBackPic)
#else
        .init()
#endif
    }

    /// The "secondry_wallet_img" asset catalog image.
    static var secondryWalletImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .secondryWalletImg)
#else
        .init()
#endif
    }

    /// The "secure" asset catalog image.
    static var secure: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .secure)
#else
        .init()
#endif
    }

    /// The "select-from-gallery" asset catalog image.
    static var selectFromGallery: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .selectFromGallery)
#else
        .init()
#endif
    }

    /// The "selected-tab-line" asset catalog image.
    static var selectedTabLine: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .selectedTabLine)
#else
        .init()
#endif
    }

    /// The "selectedBg" asset catalog image.
    static var selectedBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .selectedBg)
#else
        .init()
#endif
    }

    /// The "sent-from-ic" asset catalog image.
    static var sentFromIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sentFromIc)
#else
        .init()
#endif
    }

    /// The "settingPic" asset catalog image.
    static var settingPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .settingPic)
#else
        .init()
#endif
    }

    /// The "setypin_screen_bg" asset catalog image.
    static var setypinScreenBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .setypinScreenBg)
#else
        .init()
#endif
    }

    /// The "share-history-ic" asset catalog image.
    static var shareHistoryIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shareHistoryIc)
#else
        .init()
#endif
    }

    /// The "share-ic" asset catalog image.
    static var shareIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shareIc)
#else
        .init()
#endif
    }

    /// The "share-qr-ic" asset catalog image.
    static var shareQrIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shareQrIc)
#else
        .init()
#endif
    }

    /// The "sharePic" asset catalog image.
    static var sharePic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sharePic)
#else
        .init()
#endif
    }

    /// The "skipbutton" asset catalog image.
    static var skipbutton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .skipbutton)
#else
        .init()
#endif
    }

    /// The "sofa" asset catalog image.
    static var sofa: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sofa)
#else
        .init()
#endif
    }

    /// The "spinnerdownarr" asset catalog image.
    static var spinnerdownarr: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .spinnerdownarr)
#else
        .init()
#endif
    }

    /// The "splash" asset catalog image.
    static var splash: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .splash)
#else
        .init()
#endif
    }

    /// The "swap_arrow" asset catalog image.
    static var swapArrow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .swapArrow)
#else
        .init()
#endif
    }

    /// The "tab-home-ic" asset catalog image.
    static var tabHomeIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tabHomeIc)
#else
        .init()
#endif
    }

    /// The "tab-myexpense-ic" asset catalog image.
    static var tabMyexpenseIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tabMyexpenseIc)
#else
        .init()
#endif
    }

    /// The "tab-profile-ic" asset catalog image.
    static var tabProfileIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tabProfileIc)
#else
        .init()
#endif
    }

    /// The "tab-qrscan" asset catalog image.
    static var tabQrscan: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tabQrscan)
#else
        .init()
#endif
    }

    /// The "tab-quiz-ic" asset catalog image.
    static var tabQuizIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tabQuizIc)
#else
        .init()
#endif
    }

    /// The "target" asset catalog image.
    static var target: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .target)
#else
        .init()
#endif
    }

    /// The "termsPics" asset catalog image.
    static var termsPics: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .termsPics)
#else
        .init()
#endif
    }

    /// The "timePic" asset catalog image.
    static var timePic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .timePic)
#else
        .init()
#endif
    }

    /// The "toggle-off-button" asset catalog image.
    static var toggleOffButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .toggleOffButton)
#else
        .init()
#endif
    }

    /// The "toggle-on-button" asset catalog image.
    static var toggleOnButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .toggleOnButton)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Four" asset catalog image.
    static var transIndicatiorFour: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transIndicatiorFour)
#else
        .init()
#endif
    }

    /// The "transIndicatior_One" asset catalog image.
    static var transIndicatiorOne: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transIndicatiorOne)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Three" asset catalog image.
    static var transIndicatiorThree: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transIndicatiorThree)
#else
        .init()
#endif
    }

    /// The "transIndicatior_Two" asset catalog image.
    static var transIndicatiorTwo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transIndicatiorTwo)
#else
        .init()
#endif
    }

    /// The "transIndicatior_five" asset catalog image.
    static var transIndicatiorFive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transIndicatiorFive)
#else
        .init()
#endif
    }

    /// The "transactionIndicator_pending_progress" asset catalog image.
    static var transactionIndicatorPendingProgress: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transactionIndicatorPendingProgress)
#else
        .init()
#endif
    }

    /// The "transaction_row_bg" asset catalog image.
    static var transactionRowBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transactionRowBg)
#else
        .init()
#endif
    }

    /// The "transfer-amount-ic" asset catalog image.
    static var transferAmountIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .transferAmountIc)
#else
        .init()
#endif
    }

    /// The "travel-bus-ic" asset catalog image.
    static var travelBusIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .travelBusIc)
#else
        .init()
#endif
    }

    /// The "travel-flight-ic" asset catalog image.
    static var travelFlightIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .travelFlightIc)
#else
        .init()
#endif
    }

    /// The "travel-hotel-ic" asset catalog image.
    static var travelHotelIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .travelHotelIc)
#else
        .init()
#endif
    }

    /// The "travel-luggage" asset catalog image.
    static var travelLuggage: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .travelLuggage)
#else
        .init()
#endif
    }

    /// The "trend" asset catalog image.
    static var trend: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .trend)
#else
        .init()
#endif
    }

    /// The "twayPic" asset catalog image.
    static var twayPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .twayPic)
#else
        .init()
#endif
    }

    /// The "umbrella" asset catalog image.
    static var umbrella: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .umbrella)
#else
        .init()
#endif
    }

    /// The "uncheck" asset catalog image.
    static var uncheck: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .uncheck)
#else
        .init()
#endif
    }

    /// The "up-arrow-ic" asset catalog image.
    static var upArrowIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .upArrowIc)
#else
        .init()
#endif
    }

    /// The "upi-home-header" asset catalog image.
    static var upiHomeHeader: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .upiHomeHeader)
#else
        .init()
#endif
    }

    /// The "userPic" asset catalog image.
    static var userPic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .userPic)
#else
        .init()
#endif
    }

    /// The "wallet_secondry_img" asset catalog image.
    static var walletSecondryImg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .walletSecondryImg)
#else
        .init()
#endif
    }

    /// The "wealth" asset catalog image.
    static var wealth: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wealth)
#else
        .init()
#endif
    }

    /// The "weather" asset catalog image.
    static var weather: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .weather)
#else
        .init()
#endif
    }

    /// The "white_shadowed_bg" asset catalog image.
    static var whiteShadowedBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .whiteShadowedBg)
#else
        .init()
#endif
    }

    /// The "winnerToppic" asset catalog image.
    static var winnerToppic: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .winnerToppic)
#else
        .init()
#endif
    }

    /// The "wrong-ic" asset catalog image.
    static var wrongIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wrongIc)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

