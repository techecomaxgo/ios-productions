//
//  QuizVC.swift
//  MaxPay
//
//  Created by india on 08/12/23.
//

import UIKit
import SwiftLoader


class QuizVC: BaseVC {

    
    private var getQuizViewModel =  GetQuizViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
           // self.tabBarController?.tabBar.isHidden = true

    }
    
    
    
    @IBAction func btnAnswerClicked(_ sender: UIButton) {
        
        //QuizQuesViewController
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "QuizQuesViewController") as! QuizQuesViewController
//     
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        DispatchQueue.main.async {
            
            SwiftLoader.show(animated: true)
            
        }
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            getQuizViewModel.GetQuizModelBaseCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME")
            
            observeGetQuizApi()

        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
        
    
        
        
    }
    
    
    //MARK: Observing the data
    func observeGetQuizApi() {
        
        getQuizViewModel.eventHandler = { [weak self] event in
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
                    
                    if self?.getQuizViewModel.getQuizModelBase?.status == "success" {
                        

                        DispatchQueue.main.async {
                            
                            
                            SwiftLoader.hide()
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "QuizQuesViewController") as! QuizQuesViewController
                            vc.quizdata = self?.getQuizViewModel.getQuizModelBase?.data
                         
                            self?.navigationController?.pushViewController(vc, animated: true)
                            
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.getQuizViewModel.getQuizModelBase?.message ?? "")
                        
                    }
                    
                    
      
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    

}
