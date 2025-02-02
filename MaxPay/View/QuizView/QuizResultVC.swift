//
//  QuizResultVC.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit
import SwiftLoader
class QuizResultVC: BaseVC {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var viewTimeDisp: UIView!
     private var resultQuizVM =  ResultQuizViewModel()
    var quizdata : GetQuizModel_Data?

    // UI Elements
    let timerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0) // Light background color
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let minuteTensLabel: UILabel = createDigitLabel()
    let minuteOnesLabel: UILabel = createDigitLabel()
    let colonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.black // Matching text color
        label.text = ":"
        return label
    }()
    let secondTensLabel: UILabel = createDigitLabel()
    let secondOnesLabel: UILabel = createDigitLabel()
    
    
    // Timer properties
    var timer: Timer?
    var totalTime = 300  // Total time in seconds (5 minutes)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        // Set up the timer background view
        //view.addSubview(timerBackgroundView)
        //timerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        //        viewTimeDisp.layer.cornerRadius = 20
        //        viewTimeDisp.layer.borderWidth = 2
        //        viewTimeDisp.layer.borderColor = UIColor.gray.cgColor
        
        //                NSLayoutConstraint.activate([
        //                    timerBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //                    timerBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        //                    timerBackgroundView.widthAnchor.constraint(equalToConstant: 350),
        //                    timerBackgroundView.heightAnchor.constraint(equalToConstant: 150)
        //                ])
        
        
        // Set up the digit labels with fixed widths and heights
        let digitLabels = [minuteTensLabel, minuteOnesLabel, secondTensLabel, secondOnesLabel]
        digitLabels.forEach { label in
            label.widthAnchor.constraint(equalToConstant: 26).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        
        // Set up the digit labels
        let stackView = UIStackView(arrangedSubviews: [minuteTensLabel, minuteOnesLabel, colonLabel, secondTensLabel, secondOnesLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        viewTimeDisp.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: viewTimeDisp.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: viewTimeDisp.centerYAnchor)
        ])
        
        // Initialize the timer labels
        updateLabels(minutes: 5, seconds: 0)
        
        // Start the countdown
        startTimer()
        
        self.getQuizResult()
    }
    
    
    // Function to start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Function to update the timer
    @objc func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            let minutes = totalTime / 60
            let seconds = totalTime % 60
            updateLabels(minutes: minutes, seconds: seconds)
        } else {
            timer?.invalidate()
            timer = nil
            updateLabels(minutes: 0, seconds: 0)
            // Optionally handle what happens when the timer ends
        }
    }
    
    // Function to update the digit labels
    func updateLabels(minutes: Int, seconds: Int) {
        let minuteTens = minutes / 10
        let minuteOnes = minutes % 10
        let secondTens = seconds / 10
        let secondOnes = seconds % 10
        
        minuteTensLabel.text = "\(minuteTens)"
        minuteOnesLabel.text = "\(minuteOnes)"
        secondTensLabel.text = "\(secondTens)"
        secondOnesLabel.text = "\(secondOnes)"
    }
    
    // Helper function to create digit labels
    static func createDigitLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.black // Matching text color
        label.backgroundColor = UIColor(red: 220/255, green: 240/255, blue: 120/255, alpha: 1.0) // Light green background
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
        
    }
    
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func getQuizResult(){
        DispatchQueue.main.async {
            
            SwiftLoader.show(animated: true)
            
        }
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            resultQuizVM.ResultQuizModelBaseCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")
            
            observeResultQuizApi()
            //self.sendData()
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    
   
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: QuizVC.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
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

//MARK: Observing the data
func observeResultQuizApi() {
    
    resultQuizVM.eventHandler = { [weak self] event in
        guard self != nil else { return }

        switch event {
        case .loading:
            
            print("loading....")
            
        case .stopLoading:
            
            print("Stop loading...")
            SwiftLoader.hide()
        case .dataLoaded:
            
            print("Data loaded...")
            DispatchQueue.main.async {
                                    
//                print((self?.rankVM.rankModelBase?.data)!)
                
                SwiftLoader.hide()
                
                if self?.resultQuizVM.resultQuizViewModelbase?.status == "success" {
                    

                    DispatchQueue.main.async {
                        
                        
                        SwiftLoader.hide()
                       
                        let str = self?.resultQuizVM.resultQuizViewModelbase?.rankedResult?.first?.user?.firstName
                        let str2 = self?.resultQuizVM.resultQuizViewModelbase?.rankedResult?.first?.user?.lastName
                        
                        self?.sendData(str: self?.resultQuizVM ?? ResultQuizViewModel())
                    }
                    
                }else{
                    
                    self?.showErrorAlert(self?.resultQuizVM.resultQuizViewModelbase?.status ?? "")
                    
                }
                
                
  
                
                
            }
        case .error(let error):
            print(error!)
            SwiftLoader.hide()
        }
    }
}
    
    func sendData (str:ResultQuizViewModel?){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizWinnerViewController") as! QuizWinnerViewController
        vc.rankedData = str

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
