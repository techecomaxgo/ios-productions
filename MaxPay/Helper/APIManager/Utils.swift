//
//  Utils.swift


import UIKit
import KeychainAccess


let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier ??  "com.maxupi.in.maxpay")")
class Utils: NSObject {
    
    static func convertDateToString(selectedDate: Date, andFormat format : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: selectedDate)
        return strDate
    }
    
    static func convertStringToDate(selectedDateString: String, andFormat format : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let convDate = dateFormatter.date(from: selectedDateString)
        return convDate!
    }
    
    static func hasConnectivity() -> Bool {
        let reachability =  Reachability()
        let networkStatus: Int = (reachability?.connection.hashValue)!
        return (networkStatus != 0)
    }
    
    static func getBuildNumber() -> String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "")
    }
    
    static func getBuildVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
   
    
    public static func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileURL
        }
        return nil
    }
    
    public static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
    
    public static func getIpAddress() -> String? {
        
        // Call the function
           // return  fetchIPInfo()
    
        
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                } else if (name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3") {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(1), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    
    public static func  getCustomUserAgent() -> String {
        let device = UIDevice.current
        let systemName = device.systemName // e.g., "iOS"
        let systemVersion = device.systemVersion // e.g., "17.0"
        let deviceModel = device.model // e.g., "iPhone"

        let userAgent = "\(Bundle.main.bundleIdentifier ?? "com.maxupi.in.maxpay") (\(deviceModel); \(systemName) \(systemVersion))"
        return userAgent
    }


   public static func getDeviceModelIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    public static func  storeUserInfo(token: String, userFirstName: String,userLastName : String, isLoggedIn : String) {
        do {
            try keychain.set(token, key: "token")
            try keychain.set(userFirstName, key: "userFirstName")
            try keychain.set(userLastName, key: "userLastName")
            try keychain.set(isLoggedIn, key: "isLoggedIn")
            print("User information stored successfully.")
        } catch let error {
            print("Error storing user info: \(error)")
        }
    }
    
    public static func  storeUserLoginInfo(token: String, isLoggedIn : String) {
        do {
            try keychain.set(token, key: "token")
            try keychain.set(isLoggedIn, key: "isLoggedIn")
        } catch let error {
            print("Error storing user info: \(error)")
        }
    }

}

