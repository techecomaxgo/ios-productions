import UIKit

struct PayBillCategoriesModel {
    var name: String?
    var imageName: String?  // Image name as a string
    var isHeader: Bool
    
    init(name: String, imageName: String?, isHeader: Bool) {
        self.name = name
        self.imageName = imageName
        self.isHeader = isHeader
    }
}
