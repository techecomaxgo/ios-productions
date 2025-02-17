//
//  QuizWinnerViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 22/05/24.
//

import UIKit

class QuizWinnerViewController: BaseVC {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var stackHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var CollectionViewQuiz: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var rankedData : ResultQuizViewModel?
    
    var name : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewQuiz.delegate = self
        CollectionViewQuiz.dataSource = self
        self.CollectionViewQuiz.register(UINib(nibName: "QuizWinnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuizWinnerCollectionViewCell")
        CollectionViewQuiz.isUserInteractionEnabled = true
        CollectionViewQuiz.reloadData()
        // Do any additional setup after loading the view.
        //lblName.text = "\(rankedData?.user?.firstName ?? "")"  + "\(rankedData?.user?.firstName ?? "")"
       // stackHeightConstant.constant = 70
        
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
extension QuizWinnerViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankedData?.resultQuizViewModelbase?.rankedResult?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizWinnerCollectionViewCell", for: indexPath) as! QuizWinnerCollectionViewCell
        
        cell.lblName.text = rankedData?.resultQuizViewModelbase?.rankedResult?[indexPath.row].user?.firstName
        return cell
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 0 {
//            let xPadding = 0
//            let spacing = 10
//            let rightPadding = 10
//            let width = (CGFloat(UIScreen.main.bounds.size.width - 10) - CGFloat(xPadding + spacing + rightPadding))/1.5
//            let height = CGFloat(200)
//
//            return CGSize(width: width, height: height)
//        } else {
            let xPadding = 0
            let spacing = 10
            let rightPadding = 10
            let width = (CGFloat(UIScreen.main.bounds.size.width - 200)) //- CGFloat(xPadding + spacing + rightPadding))/2
            let height = CGFloat(240)
            
            return CGSize(width: 60, height: 60)
        //}180
        //return CGSize(width: 0, height: 0)
    }
    
}
