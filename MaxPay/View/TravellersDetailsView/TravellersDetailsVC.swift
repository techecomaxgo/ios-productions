//
//  TravellersDetailsVC.swift
//  MaxPay
//
//  Created by Admin on 06/07/24.
//

import UIKit

class TravellersDetailsVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var viewContainerheightConst: NSLayoutConstraint!
    
    
    var totalfarePrice = ""
    
    var  bondsArrDVC : [Bonds]?
    
    var legsArrDVC : [Legs]?
    
    var fareDictDVC : Fare?
    
    @IBOutlet weak var lblFarePrice: UILabel!
    
    
    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(UIImage(named:"circle-boarding-notselected"), for: .normal)
                button.setImage(UIImage(named:"circle-boarding-selected"), for: .selected)
            }
        }
    }
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var tableViewPassenger: UITableView!
    
    var passengersModel = [PassengersModel]()
    
    var selectedPassengers = [PassengersModel]()


    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    @IBOutlet weak var ageTextField: UITextField!
    
    var indexCheckedTag = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        viewContainerheightConst.constant = 980
        
        print("₹ \(fareDictDVC?.totalTaxWithOutMarkUp ?? 0)")
        
        
        if totalfarePrice == "" {
            
            lblFarePrice.text = "₹ \(fareDictDVC?.totalTaxWithOutMarkUp ?? 0)"

            
        }else{
            
            
            lblFarePrice.text = "₹ \(totalfarePrice)"

            
        }
        

        // Do any additional setup after loading the view.
        
        btnSave.layer.cornerRadius = 5
        btnSave.layer.borderWidth = 1.0
        btnSave.layer.borderColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00).cgColor
        
        
        tableViewPassenger.dataSource = self
        tableViewPassenger.delegate = self

       

        
        
    }
    
    
//    @objc func didTapPassengerCheckBox(sender: UIButton) {
//        
//        
//        
//        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
//        
////        txtGST.isHidden = sender.tag == 0 ? false : true
////        viewGSTLine.isHidden = sender.tag == 0 ? false : true
//        
//        sender.tag = sender.tag == 0 ? 1 : 0
//        //indexCheckedTag = sender.tag
//        
//        print("sender tag :",sender.tag)
//        print("passengers Model :",passengersModel.count)
//        
//        
//    }
//    
    
    
    
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
                     let lastName = lastNameTextField.text, !lastName.isEmpty,
                     let email = emailTextField.text, !email.isEmpty,
                     let phone = phoneTextField.text, !phone.isEmpty,
                     let age = ageTextField.text, !age.isEmpty else {
                   // Show an alert if any field is empty
                   let alert = UIAlertController(title: "Missing Passenger’s Information", message: "Please fill in all fields.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   present(alert, animated: true)
                   return
               }
        
        
        let newPassenger = PassengersModel(firstName: firstName, lastName: lastName, email: email, phone: phone, age: age)
        passengersModel.append(newPassenger)

        print(passengersModel.count)
                // Clear text fields
               firstNameTextField.text = ""
               lastNameTextField.text = ""
               emailTextField.text = ""
               phoneTextField.text = ""
               ageTextField.text = ""
        
        if passengersModel.count == 1 {
            viewContainerheightConst.constant = 980 + 80

        }else if passengersModel.count == 2 {
            viewContainerheightConst.constant = 980 + 160

        }else if passengersModel.count == 3 {
            viewContainerheightConst.constant = 980 + 240

        }else if passengersModel.count >= 4 {
            viewContainerheightConst.constant = 980 + 320

        }
        else{
            
            viewContainerheightConst.constant = 980

        }

               
               tableViewPassenger.reloadData()
        
        
    }

    
    
    
    
    // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return passengersModel.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableViewPassenger.dequeueReusableCell(withIdentifier: "PassengersTVC") as! PassengersTVC

            cell.passengersModel = passengersModel[indexPath.row]
            
            print(passengersModel[indexPath.row])
            
            cell.cellTableCheckBox.tag = indexPath.row

            cell.cellTableCheckBox.addTarget(self, action: #selector(connectedCheckBox(sender:)), for: .touchUpInside)

            return cell
            
        }
    
    
    
    
    @objc func connectedCheckBox(sender: UIButton){

        print(" connected Check Box",sender.tag)
        
        let index = sender.tag
        passengersModel[index].isSelected.toggle()
        tableViewPassenger.reloadData()
        
        
    }
    

        
    /*
    // MARK: - UITableViewDelegate
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           tableView.deselectRow(at: indexPath, animated: true)
           passengersModel[indexPath.row].isSelected.toggle()

           
           if passengersModel[indexPath.row].isSelected {
               
              selectedPassengers.append(passengersModel[indexPath.row])
          
           } else {
               
               if let index = selectedPassengers.firstIndex(where: { $0 === passengersModel[indexPath.row] }) {
                   selectedPassengers.remove(at: index)
               }
               
           }
           
           tableView.reloadRows(at: [indexPath], with: .automatic)

           
           
           print(" selectedPassengers :",selectedPassengers)
           
//           let passenger = passengersModel[indexPath.row]
//           let detailMessage = """
//           Name: \(passenger.firstName) \(passenger.lastName)
//           Email: \(passenger.email)
//           Phone: \(passenger.phone)
//           Age: \(passenger.age)
//           """
//           let alert = UIAlertController(title: "Passenger Details", message: detailMessage, preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default))
//           present(alert, animated: true)
           
           
       }
    */
    
    
    
    @IBAction func btnCheckBoxOneClicked(_ sender: UIButton) {
        
        
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        
//        txtGST.isHidden = sender.tag == 0 ? false : true
//        viewGSTLine.isHidden = sender.tag == 0 ? false : true
        
        sender.tag = sender.tag == 0 ? 1 : 0

        
    }
    
    
    
    @IBAction func btnCheckBoxTwoClicked(_ sender: UIButton) {
        
        
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        
//        txtGST.isHidden = sender.tag == 0 ? false : true
//        viewGSTLine.isHidden = sender.tag == 0 ? false : true
        
        sender.tag = sender.tag == 0 ? 1 : 0

        
    }
    
    
    
    @IBAction func btnCheckBoxThreeClicked(_ sender: UIButton) {
        
        
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        
//        txtGST.isHidden = sender.tag == 0 ? false : true
//        viewGSTLine.isHidden = sender.tag == 0 ? false : true
        
        sender.tag = sender.tag == 0 ? 1 : 0

        
    }
    
    
    
    
    
    //Handle with single Action
    @IBAction private func guestRadioAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        // NOTE:- here you can recognize with tag weather it is `Male` or `Female`.
        print(sender.tag)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    
    @IBAction func btnBookContinue(_ sender: UIButton) {
        
        print("passengersModel Count:", passengersModel.count)
        print("passengersModel :" , passengersModel)
        
        //TravellersSeatVC
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TravellersSeatVC") as! TravellersSeatVC
        vc.fareDict = fareDictDVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
   
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
    
        self.navigationController?.popViewController(animated: true)
        
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
