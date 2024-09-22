//
//  EditProfileVC.swift
//  MaxPay
//
//  Created by Ios Developer on 27/05/24.
//

import UIKit

class EditProfileVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var btnUploadProfileimage: UIButton!
    
    @IBOutlet weak var txtfullname: UITextField!
    
    @IBOutlet weak var txtGender: UITextField!
    
    @IBOutlet weak var txtMobile: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtDescription: UITextView!
    
    
    @IBOutlet weak var btnSave: DesignableButton!
    
    
    let genderPicker = UIPickerView()
    let genders = ["Male", "Female", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up the picker view
                genderPicker.delegate = self
                genderPicker.dataSource = self
                
                // Assign the picker view to the inputView of the text field
        txtGender.inputView = genderPicker
                
                // Add a toolbar with a Done button
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
                toolbar.setItems([doneButton], animated: false)
                toolbar.isUserInteractionEnabled = true
                
        txtGender.inputAccessoryView = toolbar
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           self.tabBarController?.tabBar.isHidden = true

   }
    
    
    
    @objc func donePressed() {
        txtGender.resignFirstResponder()
        }
    
    
    
    // UIPickerViewDataSource
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return genders.count
       }
       
       // UIPickerViewDelegate
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return genders[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           txtGender.text = genders[row]
       }
    
    
    

    @IBAction func btnUploadProfileClicked(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        
        
        
    }
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        self.tabBarController?.tabBar.isHidden = false
        
        
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


