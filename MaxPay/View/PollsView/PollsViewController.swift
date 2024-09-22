//
//  PollsViewController.swift
//  MaxPay
//
//  Created by Admin on 29/05/24.
//

import UIKit


class PollsViewController: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    
    @IBOutlet weak var btnOptionTwo: UIButton!
    
    
    @IBOutlet weak var btnOptionFour: UIButton!
    
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    @IBOutlet weak var viewAnswerOne: UIView!
    
    @IBOutlet weak var viewAnswerTwo: UIView!
    
    
    @IBOutlet weak var viewAnswerThree: UIView!
    
    @IBOutlet weak var viewAnswerFour: UIView!
    
    
    @IBOutlet weak var lblAnsOne: UILabel!
    
    @IBOutlet weak var lblAnsTwo: UILabel!
    
    @IBOutlet weak var lblAnsThree: UILabel!
    
    
    @IBOutlet weak var lblAnsFour: UILabel!
    
    @IBOutlet weak var lbla: UILabel!
    
    @IBOutlet weak var lblb: UILabel!
    
    @IBOutlet weak var lblc: UILabel!
    
    @IBOutlet weak var lbld: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnSubmit.layer.applyCornerRadiusShadowGreen()
        
        
        viewAnswerOne.layer.applyCornerRadiusShadow()
        viewAnswerTwo.layer.applyCornerRadiusShadow()
        viewAnswerThree.layer.applyCornerRadiusShadow()
        viewAnswerFour.layer.applyCornerRadiusShadow()
        
        
    /*
              // Define the ratio (e.g., 0.7 for 70%)
              let ratio: CGFloat = 0.7

              // Create the container view
              let containerView = UIView()
              containerView.backgroundColor = .lightGray // Background color of the bar
              containerView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(containerView)

              // Create the fill view
              let fillView = UIView()
        btnOptionOne.backgroundColor = .blue // Fill color of the bar
        btnOptionOne.translatesAutoresizingMaskIntoConstraints = false
              containerView.addSubview(btnOptionOne)

              // Set up Auto Layout for the container view
              NSLayoutConstraint.activate([
                  containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                  containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  btnOptionOne.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // Width of the bar container
                  btnOptionOne.heightAnchor.constraint(equalToConstant: 50) // Height of the bar container
              ])

              // Set up Auto Layout for the fill view
              NSLayoutConstraint.activate([
                btnOptionOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                btnOptionOne.topAnchor.constraint(equalTo: containerView.topAnchor),
                btnOptionOne.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                btnOptionOne.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ratio) // Width proportional to the ratio
              ])
        
        */
        
        
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        
        
        btnSubmit.setTitle("Thanks for the response!", for: .normal)
        
        viewAnswerOne.backgroundColor = UIColor.white
        
        viewAnswerTwo.backgroundColor = UIColor.white
        
        viewAnswerThree.backgroundColor = UIColor.white
        
        viewAnswerFour.backgroundColor = UIColor.white
        
        
        btnSubmit.backgroundColor = UIColor.white
        btnSubmit.layer.cornerRadius = 12
        btnSubmit.layer.borderWidth = 1
        btnSubmit.layer.borderColor = UIColor.grey.cgColor

      //  btnOptionOne
        
      
        
    
    
        
        
    }
    
    
    
    @IBAction func btnOptionClicked(_ sender: UIButton) {
        
        viewAnswerOne.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        viewAnswerTwo.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerThree.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerFour.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        btnSubmit.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        
        
    }
    
    
    
    @IBAction func btnOptionTwoClicked(_ sender: UIButton) {
        
        
        
        viewAnswerOne.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerTwo.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        viewAnswerThree.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerFour.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        btnSubmit.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        
    }
    
    
    @IBAction func btnOptionThreeClicked(_ sender: UIButton) {
        
        
        viewAnswerOne.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerTwo.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerThree.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        viewAnswerFour.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        btnSubmit.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        
        
    }
    
    
    @IBAction func btnOptionFourClicked(_ sender: UIButton) {
        
        
        
        viewAnswerOne.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerTwo.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerThree.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        viewAnswerFour.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        btnSubmit.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        
        
        
        
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
