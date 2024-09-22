//
//  QuizQuesViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 21/05/24.
//

import UIKit
import SwiftLoader


class QuizQuesViewController: BaseVC {

    
    private var attendQuizVM =  AttendQuizViewModel()

    
    
    @IBOutlet weak var btnOptOne: UIButton!
    
    @IBOutlet weak var btnOptTwo: UIButton!
    
    @IBOutlet weak var viewTimerDisp: UIView!
    
    @IBOutlet weak var btnOptThree: UIButton!
    
    
    @IBOutlet weak var btnOptFour: UIButton!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
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

   var punchinStr = ""
    
    var punchoutStr = ""

    var ansTypeOptStr = ""

    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  print(quizdata)
      //  print(quizdata?.options?.a ?? "")
        

        punchinStr = getCurrentTime()
        

        
        lblQuestion.text = quizdata?.question ?? ""
        
        btnOptOne.setTitle(quizdata?.options?.a ?? "", for: .normal)
        btnOptOne.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnOptOne.setTitleColor(.black, for: .normal)
        btnOptOne.layer.cornerRadius = 10
        btnOptOne.layer.borderWidth = 1
        btnOptOne.layer.borderColor = UIColor.gray.cgColor
        
        
        btnOptTwo.setTitle(quizdata?.options?.b ?? "", for: .normal)
        btnOptTwo.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnOptTwo.setTitleColor(.black, for: .normal)
        btnOptTwo.layer.cornerRadius = 10
        btnOptTwo.layer.borderWidth = 1
        btnOptTwo.layer.borderColor = UIColor.gray.cgColor
        
        
        
        btnOptThree.setTitle(quizdata?.options?.c ?? "", for: .normal)
        btnOptThree.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnOptThree.setTitleColor(.black, for: .normal)
        btnOptThree.layer.cornerRadius = 10
        btnOptThree.layer.borderWidth = 1
        btnOptThree.layer.borderColor = UIColor.gray.cgColor
        
        
        
        btnOptFour.setTitle(quizdata?.options?.d ?? "", for: .normal)
        btnOptFour.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnOptFour.setTitleColor(.black, for: .normal)
        btnOptFour.layer.cornerRadius = 10
        btnOptFour.layer.borderWidth = 1
        btnOptFour.layer.borderColor = UIColor.gray.cgColor

        
        
        // Set up the timer background view
                //view.addSubview(timerBackgroundView)
                //timerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    timerBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    timerBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                    timerBackgroundView.widthAnchor.constraint(equalToConstant: 350),
//                    timerBackgroundView.heightAnchor.constraint(equalToConstant: 150)
//                ])
                
        
//        viewTimerDisp.layer.cornerRadius = 20
//        viewTimerDisp.layer.borderWidth = 2
//        viewTimerDisp.layer.borderColor = UIColor.gray.cgColor
        
        
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
                
        viewTimerDisp.addSubview(stackView)
        
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.centerXAnchor.constraint(equalTo: viewTimerDisp.centerXAnchor),
                    stackView.centerYAnchor.constraint(equalTo: viewTimerDisp.centerYAnchor)
                ])
                
                // Initialize the timer labels
                updateLabels(minutes: 5, seconds: 0)
                
                // Start the countdown
                startTimer()
        
        
    }
    
   
    func getCurrentTime() -> String {
        
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            let formattedDate = formatter.string(from: date)
            return formattedDate
        
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
    
    
    
    @IBAction func btnOptOneClicked(_ sender: UIButton) {
        
        ansTypeOptStr = "A"
        btnOptOne.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)

        attendQuestion()

        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
//       // vc.accountDetails = primaryAccount
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnOptTwoClicked(_ sender: UIButton) {
        
        ansTypeOptStr = "B"
        
        btnOptTwo.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        
        attendQuestion()

        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
//       // vc.accountDetails = primaryAccount
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnThreeClicked(_ sender: UIButton) {
        
        ansTypeOptStr = "C"
        btnOptThree.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)

        attendQuestion()

        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
//       // vc.accountDetails = primaryAccount
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    @IBAction func btnFourClicked(_ sender: UIButton) {
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
//       // vc.accountDetails = primaryAccount
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        //QuizWinnerViewController
        btnOptFour.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)

        
        ansTypeOptStr = "D"
        
        attendQuestion()
        
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizWinnerViewController") as! QuizWinnerViewController
//       // vc.accountDetails = primaryAccount
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func attendQuestion() {
        
        print(punchinStr)
        
        punchoutStr = getCurrentTime()
        
        print(punchoutStr)
        
        DispatchQueue.main.async {
            
            SwiftLoader.show(animated: true)
            
        }
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            attendQuizVM.AttendQuizModelApiCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4", questionid: quizdata?.id ?? 0, answerStr: ansTypeOptStr, punchinStr: punchinStr, punchoutStr: punchoutStr)
            
            observeAttendQuizApi()

        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
        
        
        
    }
    
    
    
    //MARK: Observing the data
    func observeAttendQuizApi() {
        
        attendQuizVM.eventHandler = { [weak self] event in
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
                    
                    if self?.attendQuizVM.attendQuizModelBase?.status == "success" {
                        

                        DispatchQueue.main.async {
                            
                            
                            SwiftLoader.hide()
                            
                            self?.showErrorAlert(self?.attendQuizVM.attendQuizModelBase?.message ?? "")

                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                //self.navigationController?.popViewController(animated: true)
                                
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                let vc = storyBoard.instantiateViewController(withIdentifier: "QuizResultVC") as! QuizResultVC
                                //vc.quizdata = self?.getQuizViewModel.getQuizModelBase?.data
    
                                self?.navigationController?.pushViewController(vc, animated: true)
                                
                                
                            })
                            
                            
                    
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.attendQuizVM.attendQuizModelBase?.message ?? "")
                        
                    }
                    
                    
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
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

}
