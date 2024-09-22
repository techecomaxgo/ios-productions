//
//  Utils.swift


import UIKit

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
}
