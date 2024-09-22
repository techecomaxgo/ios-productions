//
//  PresentPhotViewController.swift
//  MaxPay
//
//  Created by Admin on 12/06/24.
//

import UIKit
import SDWebImage


class PresentPhotViewController: UIViewController {

    @IBOutlet weak var imgPic: UIImageView!
    
    var urlStr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Ensure imageView is not nil
                guard let imageView = imgPic else {
                    return
                }
        
        imgPic.backgroundColor = UIColor.black
        
        imgPic.contentMode = .scaleAspectFit
        imgPic.clipsToBounds = true

        imgPic.isUserInteractionEnabled = true

        
        imgPic.sd_setImage(with: URL(string:urlStr ?? ""), placeholderImage: UIImage(named: "hotelsamplePic.png"))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageGullTapped(_:)))
        imgPic.addGestureRecognizer(tapGestureRecognizer)


    }
    
    
    @objc func imageGullTapped(_ sender: UITapGestureRecognizer) {
            // Dismiss the view controller
            self.dismiss(animated: false, completion: nil)
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
