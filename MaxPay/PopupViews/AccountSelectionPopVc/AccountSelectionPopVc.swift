//
//  AccountSelectionPopVc.swift
//  MaxPay
//
//  Created by Admin on 10/06/24.
//
protocol bankSelectedDelegate {
    
    func popBankSelected(cardInfo:AccountDetailsOnIIN)
    
}



import UIKit
import Toast_Swift

class AccountSelectionPopVc: UIViewController {

    
    var delegatePopupBankSelected : bankSelectedDelegate?

    @IBOutlet weak var btnPlayNow: DesignableButton!
    
    @IBOutlet weak var tableViewAccount: UITableView!
    
    @IBOutlet var bgView_ctrl: UIView!
    
    @IBOutlet weak var popView_Ctrl: UIView!
    
    
    private var cardsArr:[AccountDetailsOnIIN] = []

    var selectedBankIndex: IndexPath?

    var selectedCard :AccountDetailsOnIIN?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true

        // Add tap gesture recognizer to the background view
//             let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
//        bgView_ctrl.addGestureRecognizer(tapGestureRecognizer)
//        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch card array from user defaults
        
        cardsArr = []

       
        if let decoded = Common.shared.myCards {
            do {
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                
                for card in cardList {
                    cardsArr.append(card)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        print(cardsArr)
        
        tableViewAccount.delegate = self
        tableViewAccount.dataSource = self
        
    }
    
    
    @IBAction func btnCellBankClicked(_ sender: UIButton) {
        
        print(cardsArr[sender.tag])
       // delegatePopupBankSelected?.popBankSelected(cardInfo: cardsArr[sender.tag])

        
//        selectedBankIndex = sender.tag
        
        
        //print(cardsArr[indexPath.row])
        tableViewAccount.reloadData()
        
    }
    
    
    @objc func dismissPopup() {
            // Dismiss the popup and background view
           removeAnimate()
        }
    
    
    
    func showAnimate()
        
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations:
            {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
        
    {
        UIView.animate(withDuration: 0.0, animations:
            {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    
    
    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        
        if selectedCard != nil{
            
            // print(selectedBankIndex)
             
             delegatePopupBankSelected?.popBankSelected(cardInfo: selectedCard!)

             removeAnimate()
            
            
        }else{
            
            self.view.makeToast("Please select account", duration: 1.0, position: .bottom)
            
        }
      
        
        
        
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        
        removeAnimate()
        
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


extension AccountSelectionPopVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cardsArr.count

        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewAccount.dequeueReusableCell(withIdentifier: "AccountSelectTVC") as! AccountSelectTVC
        
        cell.lblBankName.text = "\(cardsArr[indexPath.row].bankName ?? "") \(cardsArr[indexPath.row].maskedAccnumber ?? "")"
        
        
        cell.isSelectedCell = indexPath == selectedBankIndex

        //cell.btnCellBank.tag = indexPath.row
        
        //print("Index Selected : ",indexPath)
        //print("Bank Index Selected : ",cardsArr[indexPath.row].bankName ?? "")
        //print(indexPath.row)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PlanViewPopupVC
//        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
//        self.addChild(popOverVC)
        
       // print("Index Selected",indexPath.row)
        selectedBankIndex = indexPath
      //  print(cardsArr[indexPath.row])
        
        
        selectedCard = cardsArr[indexPath.row]
        
      //  print(selectedCard)
        
        tableViewAccount.reloadData()


        
    }
    
    
    
}
