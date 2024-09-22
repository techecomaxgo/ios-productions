//
//  PhotoGalleryVC.swift
//  MaxPay
//
//  Created by Admin on 12/06/24.
//

import UIKit

class PhotoGalleryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    var ImagegalleryArr : [RoomImageList]?
    
    @IBOutlet weak var collectionViewGallery: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionViewGallery.delegate =  self
        
        collectionViewGallery.dataSource = self
        
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return ImagegalleryArr?.count ?? 0
       
    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCVC", for: indexPath) as! PhotoGalleryCVC
            
            cell.imageView.contentMode = .scaleAspectFill
            cell.imageView.clipsToBounds = true

            
            cell.imageView.sd_setImage(with: URL(string: ImagegalleryArr?[indexPath.row].url ?? ""), placeholderImage: UIImage(named: "hotelsamplePic.png"))
            
            cell.imageView.layer.applyCornerRadiusShadow(cornerRadiusValue: 6)
            

            
            return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "PhotoGalleryVC") as! PhotoGalleryVC

        let storyboard = UIStoryboard(name: "USP", bundle: nil)
        if let fullScreenVC = storyboard.instantiateViewController(withIdentifier: "PresentPhotViewController") as? PresentPhotViewController {
            // Set the modal presentation style to full screen
            fullScreenVC.modalPresentationStyle = .fullScreen
            fullScreenVC.urlStr = ImagegalleryArr?[indexPath.row].url ?? ""
            // Present the view controller
            self.present(fullScreenVC, animated: false, completion: nil)
            
            
        }
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height: CGFloat = 200 // You can adjust this value to match the desired height
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
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
