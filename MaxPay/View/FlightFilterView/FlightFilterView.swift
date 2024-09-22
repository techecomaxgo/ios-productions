//
//  FlightFilterView.swift
//  MaxPay
//
//  Created by Admin on 12/07/24.
//

protocol flightfilterSelectedDelegate {
    
    func filterItemsSelected(filterItems:[String])
    
}



import UIKit

class FlightFilterView: UIViewController {

    
    var delegateFlightfilterSelected : flightfilterSelectedDelegate?

    
    
    @IBOutlet weak var priceButton: UIButton!
    
    @IBOutlet weak var bestRatedButton: UIButton!
    
    @IBOutlet weak var earlyDepartureButton: UIButton!
    
    @IBOutlet weak var lateDepartureButton: UIButton!
    
    
    @IBOutlet weak var boardingMorningButton: UIButton!
    
    @IBOutlet weak var boardingAfternoonButton: UIButton!
    
    
    @IBOutlet weak var boardingEveningButton: UIButton!
    
    @IBOutlet weak var boardingNightButton: UIButton!
    
    
    @IBOutlet weak var arrivalMorningButton: UIButton!
    
    @IBOutlet weak var arrivalAfternoonButton: UIButton!
    
    
    @IBOutlet weak var arrivalEveningButton: UIButton!
    
    @IBOutlet weak var arrivalNightButton: UIButton!
    
    @IBOutlet weak var nonStopButton: UIButton!
    
    @IBOutlet weak var oneStopButton: UIButton!
    
    
    @IBOutlet weak var twoPlusStopButton: UIButton!
    
    
    @IBOutlet weak var clearAllButton: DesignableButton!
    
    
    @IBOutlet weak var applyButton: DesignableButton!
    
    @IBOutlet weak var btnClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureButtons()

    }
    
    func configureButtons() {
        
        configureButton(priceButton)
        configureButton(bestRatedButton)
        configureButton(earlyDepartureButton)
        configureButton(lateDepartureButton)

        
        
        configureButton(boardingMorningButton)
        configureButton(boardingAfternoonButton)
        configureButton(boardingEveningButton)
        configureButton(boardingNightButton)
        
        
        configureButton(arrivalMorningButton)
        configureButton(arrivalAfternoonButton)
        configureButton(arrivalEveningButton)
        configureButton(arrivalNightButton)

        
        configureButton(nonStopButton)
        configureButton(oneStopButton)
        configureButton(twoPlusStopButton)
        
        

        btnClose.layer.cornerRadius = 6

        
        
    }
    
    func configureButton(_ button: UIButton, titleColor: UIColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)) {
        
        button.setTitleColor(titleColor, for: .normal)
        //button.backgroundColor = .lightGray
        // Set button border and corner radius
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = titleColor.cgColor
        
        // Enable Auto Layout
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateButtonAppearance(sender)
    }
    
    
    func updateButtonAppearance(_ button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00) // Change to the selected state color
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .clear // Change to the deselected state color
            button.setTitleColor(UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00), for: .normal)
        }
    }
    
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    @IBAction func btnApplyClicked(_ sender: DesignableButton) {
        
        
        
        let selectedFilters = getSelectedFilters()
        print(selectedFilters)

        self.navigationController?.popViewController(animated: true)

        delegateFlightfilterSelected?.filterItemsSelected(filterItems: selectedFilters)
        
        
    }
    
    
    func getSelectedFilters() -> [String] {
        
        var filters = [String]()
        
        if priceButton.isSelected { filters.append("Price - Low to High") }
        if bestRatedButton.isSelected { filters.append("Best Rated first") }
        if earlyDepartureButton.isSelected { filters.append("Early Departure") }
        if lateDepartureButton.isSelected { filters.append("Late Departure") }
        
        if boardingMorningButton.isSelected { filters.append("Morning 6:00 to 12:00 (Boarding)") }
        if boardingAfternoonButton.isSelected { filters.append("Afternoon 12:00 to 18:00 (Boarding)") }
        if boardingEveningButton.isSelected { filters.append("Evening 18:00 to 00:00 (Boarding)") }
        if boardingNightButton.isSelected { filters.append("Night 00:00 to 06:00 (Boarding)") }
        
        if arrivalMorningButton.isSelected { filters.append("Morning 6:00 to 12:00 (Arrival)") }
        if arrivalAfternoonButton.isSelected { filters.append("Afternoon 12:00 to 18:00 (Arrival)") }
        if arrivalEveningButton.isSelected { filters.append("Evening 18:00 to 00:00 (Arrival)") }
        if arrivalNightButton.isSelected { filters.append("Night 00:00 to 06:00 (Arrival)") }
        
        if nonStopButton.isSelected { filters.append("Non-Stop") }
        if oneStopButton.isSelected { filters.append("1 Stop") }
        if twoPlusStopButton.isSelected { filters.append("2+ Stop") }
        
        return filters
    }
    
    
    @IBAction func btnClearAll(_ sender: DesignableButton) {
        
        
        let buttons = [priceButton, bestRatedButton, earlyDepartureButton, lateDepartureButton,
                       boardingMorningButton, boardingAfternoonButton, boardingEveningButton, boardingNightButton,
                       arrivalMorningButton, arrivalAfternoonButton, arrivalEveningButton, arrivalNightButton,
                       nonStopButton, oneStopButton, twoPlusStopButton]
        
        buttons.forEach { button in
            button?.isSelected = false
            updateButtonAppearance(button!)
        }

        
    }
    

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


