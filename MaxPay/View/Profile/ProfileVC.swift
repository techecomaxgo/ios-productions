//
//  ProfileVC.swift
//  MaxPay
//
//  Created by india on 17/11/23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var vwSave: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtState: DesignableTextField!
    @IBOutlet weak var txtCity: DesignableTextField!
    @IBOutlet weak var txtPinCode: DesignableTextField!
    @IBOutlet weak var txtAddress: DesignableTextField!
    @IBOutlet weak var txtPhone: DesignableTextField!
    @IBOutlet weak var txtEmail: DesignableTextField!
    @IBOutlet weak var txtGender: DesignableTextField!
    @IBOutlet weak var txtDOB: DesignableTextField!
    @IBOutlet weak var txtLastName: DesignableTextField!
    @IBOutlet weak var txtfirstName: DesignableTextField!
    @IBOutlet weak var btnEdit: DesignableButton!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    let arrGender = ["Male","Female","Others"]
//    var testView = UIView()
        let minHeight: CGFloat = 100
        let maxHeight: CGFloat = 300
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        segmentController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        editUser(false)
        btnEdit.isHidden = true
        btnSave.isHidden = true
        vwSave.layer.applyCornerRadiusShadow()
        vwSave.isHidden = true
//        testView = UIView(frame: CGRect(x: 50, y: 200, width: 200, height: minHeight))
//                testView.backgroundColor = UIColor.blue
//                view.addSubview(testView)
//
//                // Add a pan gesture recognizer to the view
//                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//                testView.addGestureRecognizer(panGesture)
    }
    func editUser(_ isEdit:Bool){
        txtfirstName.isUserInteractionEnabled = isEdit
        txtLastName.isUserInteractionEnabled = isEdit
        txtDOB.isUserInteractionEnabled = isEdit
        txtGender.isUserInteractionEnabled = isEdit
        txtEmail.isUserInteractionEnabled = isEdit
        txtPhone.isUserInteractionEnabled = isEdit
        txtAddress.isUserInteractionEnabled = isEdit
        txtPinCode.isUserInteractionEnabled = isEdit
        txtCity.isUserInteractionEnabled = isEdit
        txtState.isUserInteractionEnabled = isEdit
        txtfirstName.isUserInteractionEnabled = isEdit
        
    }
//    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
//            let translation = recognizer.translation(in: view)
//            
//            // Calculate the new height based on the gesture translation
//            var newHeight = testView.frame.height + translation.y
//            
//            // Ensure the new height stays within the specified range
//            newHeight = min(maxHeight, max(minHeight, newHeight))
//
//            // Update the view's frame with the new height
//            testView.frame = CGRect(x: testView.frame.origin.x, y: testView.frame.origin.y, width: testView.frame.width, height: newHeight)
//            
//            // Reset the translation to avoid continuous incremental changes
//            recognizer.setTranslation(CGPoint.zero, in: view)
//            
//            // Handle the gesture state to perform actions when the gesture ends
//            if recognizer.state == .ended {
//                // Perform actions when the gesture ends (if needed)
//            }
//        }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEditAction(_ sender: Any) {
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            editUser(false)
            btnEdit.isHidden = true
            btnSave.isHidden = true
            vwSave.isHidden = true
        }else{
            editUser(true)
            btnEdit.isHidden = false
            btnSave.isHidden = false
            vwSave.isHidden = false
        }
    }
}
extension ProfileVC:UITextFieldDelegate,CustomListDelegate,DatePickerDelegate{

    
    func selectedDateonscroll(selectedSDate: Date) {
        print(selectedSDate)
    }
    
    func selectedDate(selectedDate: Date) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        txtDOB.text =  dateFormatter.string(from: selectedDate)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 101:
            self.view.endEditing(true)
            MyBasics.showListDropDown(Items:arrGender , ParentViewC: self)
        case 102:
            self.view.endEditing(true)
            MyBasics.showDatePickerDropDown(PickerType: UIDatePicker.Mode.date, ParentViewC: self)
        default:
            return
        }
    }
    func GetSelectedPickerItemIndex(Index: Int) {
        txtGender.text = arrGender[Index]
    }
}
