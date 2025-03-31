//
//  Constants.swift
//  LostAndFound
//
//  Created by Ekta Majithiya on 23/05/24.
//

import Foundation



//payment key



let Merchantid = "ECOMAXGOPROD1234"
let Merchantvpa = "ecomaxgo@maxaxis"

let Submerchantid = "ECOMAXGOPROD1234"

let MerchantChannelId = "ECOMAXGOPROD1234"
let TranType = "P2M"
let Mcc = "4814"
let Codezero = "00"
let RefUrl = "https://www.maxupi.in"



let accessMax = "@maxaxis"


let KCategoryCVCell = "CategoryCVCell"
let KItemCVCell = "ItemCVCell"
let KLostItemCVCell = "LostItemCVCell"
let KFloatingMenuView = "FloatingMenuView"
let KThemeLightGreen = "theme_green_light"
let KThemeTextDark = "theme_text_dark"
let KLostItemView = "LostItemVC"
let KThemeTextDark2 = "theme_text_dark2"
let KMyPostView = "MyPostVC"
let KItemDetailsView = "ItemDetailsVC"

let KClaimPopUpVC = "ClaimPopUpVC"
let KFilterPopUPVC = "FilterTexPopUpVC"
let KFilterDatePopUPVC = "FilterDatePopUpVC"
let AlertTitle = "Alert"
let OkButton = "OK"

//Messages

let NoInternet = "No Internet Available"
let Success = "success"
let NoItem = "No Item Found"
let ItemClaimed = "Item Claimed Successfully!"
let ItemNotClaimed = "Item could not claimed successfully!"
let ItemPosted = "Item Posted Successfully!"
let ItemNotPosted = "Item could not Posted successfully!"

//Values

let isoDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

//MARK: - API
//UAT Server URL  27 Nov
// let baseUrl = "https://uat.maxupi.in"

//Production Server URL
let baseUrl = "https://api.maxupi.in"
let apiVersion = "/api/v1/"

let getAllCategories = "lfcategories/all-categories"

let lostRecords = "lost/all-lost-items"
let searchLostRecords = "lost/search"
let filterLostByLatest = "lost/list-by-latest"
let filterLostByOldest = "lost/list-by-old"
let filterLostByCity = "lost/list-by-city"
let filterLostByDate = "lost/list-by-date"
let lostItemByCategory = "lost/list-by-category"
let postLostItem = "lost/lost-record"
//My post
let lostListByUser = "lost/list-by-user"

let foundRecords = "found/all-found-items"
let searchFoundRecords = "found/search"
let filterFoundByLatest = "found/list-by-latest"
let filterFoundByOldest = "found/list-by-old"
let filterFoundByCity = "found/list-by-city"
let filterFoundByDate = "found/list-by-date"
let foundItemByCategory = "found/list-by-category"
let postFoundItem = "found/found-record"

//Mypost
let foundListByUser = "found/list-by-user"


let claimedRecords = "lf-claim/view-claim"
let claimItem = "lf-claim/lf-claim"
let filterClaimByLatest = "lf-claim/list-by-latest"
let filterClaimByOldest = "lf-claim/list-by-old"
let filterClaimByDate = "lf-claim/list-by-date"

let termsConditions_PrivacyPolicy = "https://www.ecomaxgo.in/"


//API Values
let KTokenValue = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI3IiwicGhvbmUiOiI3NDk4OTI4NDI1IiwidWlkIjoiMjE2OWY2MjQtOTY0My00YmRiLTlhMjQtMWI2NTMyYWU0NTY2IiwiaWF0IjoxNjk3NDM5NzgxfQ.lZUoUM2voWlJnDr-wzPlZ4PNODarOb9MD64IZkatiIA"

let KSkeyValue = "AVJQIdwn79iR0zlP0iKNKumME"

let KJWTTokenValue = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiIxMyIsInBob25lIjoiNzAwNzQzOTY1MSIsInVpZCI6IjRkODE2N2ZkLTgxOWEtNGFiNS04MjI3LTM5YjhiYjQyNjExMSIsImlhdCI6MTcxNjg4MDk4N30.-syhhd1i_dAF-e7NL2rP1LYi7mqTicfyvP2qVFP-0fY"

//API Params
let KSKEY = "skey"
let KTOKEN = "token"

let KSearchKey = "search_key"
let KCity = "city"
let KDate = "date"
let KId = "id"
let KDescription = "description"
let KCategory = "category"

let KLocation = "location"
let KLost_date_time = "lost_date_time"
let KIp = "ip"
let KItem_name = "item_name"
let KContact_number = "contact_number"
let KOther_info = "other_info"

let KContact_name = "contact_name"
let KAddress = "address"
let KImages = "images"
let KFound_date_time = "found_date_time"
//API Content-type

struct ContentType{
    var appJson = "application/json"
    var appXWFormUrlEncoded =  "Application/x-www-form-urlencoded"
    var rawType = "text/html"
    var multipPart = "multipart/form-data"
}

//API Methods

struct APIMethod{
    var post = "POST"
    var get = "GET"
}
