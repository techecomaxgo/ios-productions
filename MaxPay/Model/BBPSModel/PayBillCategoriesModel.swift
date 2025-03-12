import UIKit

// Define the PayBillCategoriesModel struct
struct PayBillCategoriesModel {
    var name: String
    var image: UIImage?
    var isHeader: Bool
    
    init(name: String, imageName: String, isHeader: Bool) {
        self.name = name
        self.image = UIImage(named: imageName)
        self.isHeader = isHeader
    }
    
    init(name: String, image: UIImage, isHeader: Bool) {
        self.name = name
        self.image = image
        self.isHeader = isHeader
    }
}
