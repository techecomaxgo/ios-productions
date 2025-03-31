import UIKit

class FetechingBillCellTable: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var swichButton: UISwitch!
    @IBOutlet weak var reamningday: UILabel!
    @IBOutlet weak var descriptiondetail: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var isActive: UILabel!
    
    var switchAction: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Switch state change event
        swichButton.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }

    @objc func switchChanged(_ sender: UISwitch) {
        switchAction?(sender.isOn)
        updateSwitchUI(sender.isOn)
    }

    func configure(with feature: Feature, isSelected: Bool) {
        lblTitle.text = feature.feature
        reamningday.text = feature.duration + " days Left"
        descriptiondetail.text = feature.description
        amount.text = "₹ " + feature.price
        
        // Set switch state based on selection
        swichButton.isOn = isSelected
        swichButton.isEnabled = !feature.isActive  // Disable switch if already active
        
        // Update UI based on switch state
        updateSwitchUI(swichButton.isOn)

        // Set switch tint color based on title
        updateSwitchTintColor(for: feature.feature)
    }
    
    private func updateSwitchUI(_ isOn: Bool) {
        isActive.text = isOn ? "Active" : "Inactive"
    }

    private func updateSwitchTintColor(for title: String) {
        switch title.lowercased() {
        case "rank":
            swichButton.onTintColor = UIColor(hex: "#FF9933") // Orange
        case "quiz":
            swichButton.onTintColor = UIColor(hex: "#669900") // Green
        case "chain":
            swichButton.onTintColor = UIColor(hex: "#FFFFFF") // White
        default:
            swichButton.onTintColor = UIColor.systemGray // Default color
        }
    }
}

// MARK: - UIColor Extension to Support Hex Colors
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
