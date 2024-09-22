//
//  TravelTabViewController.swift
//  MaxPay
//
//  Created by Admin on 01/07/24.
//

import UIKit

class TravelTabViewController: BaseVC,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
 
    @IBOutlet weak var tabButtonsView: UIStackView!
    
    @IBOutlet weak var containerView: UIView!


    var pageViewController: UIPageViewController!
        var viewControllers: [UIViewController]!
    
    var currentPageIndex: Int = 0 // Declare currentPageIndex

    
    @IBOutlet weak var btnBus: UIButton!
    
    @IBOutlet weak var btnFlight: UIButton!
    
    @IBOutlet weak var btnHotel: UIButton!
    
    @IBOutlet weak var viewBus: UIView!
    
    @IBOutlet weak var viewFlight: UIView!
    
    @IBOutlet weak var viewHotel: UIView!
    
    @IBOutlet weak var imgBus: UIImageView!
    
    @IBOutlet weak var lblBus: UILabel!
    
    @IBOutlet weak var imgFlight: UIImageView!
    
    @IBOutlet weak var lblFlight: UILabel!
    
    
    @IBOutlet weak var lblHotel: UILabel!
    
    @IBOutlet weak var imgHotel: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up the view controllers
               let storyboard = UIStoryboard(name: "USP", bundle: nil)
               let firstVC = storyboard.instantiateViewController(withIdentifier: "PageOneViewController")
               let secondVC = storyboard.instantiateViewController(withIdentifier: "FlightBookViewController")
               let thirdVC = storyboard.instantiateViewController(withIdentifier: "PageTwoViewController")
               viewControllers = [firstVC, secondVC, thirdVC]
               
               // Set up the page view controller
               pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
               pageViewController.dataSource = self
               pageViewController.delegate = self
               pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
               
               addChild(pageViewController)
               containerView.addSubview(pageViewController.view)
               pageViewController.didMove(toParent: self)
               
               // Add constraints to page view controller's view
               pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                   pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                   pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                   pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
               ])
     
        
        
            }
    
    
    
    
    
    
    // MARK: - UIPageViewControllerDataSource
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = viewControllers.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            return viewControllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else {
                return nil
            }
            return viewControllers[index + 1]
        }
    
    
    
   
    @IBAction func tabButtonTapped(_ sender: UIButton) {
        
        
        if sender.tag == 0 {
            
            resetBusBackgrounds()
            
        } else if sender.tag == 1 {
                     
            resetFlightBackgrounds()
            
        } else if sender.tag == 2 {
            
            resetHotelBackgrounds()
            
        }
        
               // let index = sender.tag
        
               // print("Index :", index)

//        
//        if let index = sender.tag as? Int, index >= 0, index < viewControllers.count {
//            let direction: UIPageViewController.NavigationDirection = index > currentPageIndex ? .forward : .reverse
//            currentPageIndex = index
//            
//            pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
//        }

        
        
        
            let index = sender.tag
        
        print("Index :", index)
           
        let direction: UIPageViewController.NavigationDirection = index > pageViewController.viewControllers?.first?.view.tag ?? 0 ? .forward : .reverse
            pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true, completion: nil)
        
        

        
        
        }
            
    
    
    func resetBusBackgrounds() {
        
            btnBus.backgroundColor = UIColor.clear
            btnFlight.backgroundColor = UIColor.clear
            btnHotel.backgroundColor = UIColor.clear
        
        imgBus.tintColor = UIColor.white
        imgFlight.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        imgHotel.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        lblBus.textColor = UIColor.white
        lblHotel.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        lblFlight.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        viewBus.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        viewHotel.backgroundColor = UIColor.white
        viewFlight.backgroundColor = UIColor.white
        
        viewBus.layer.applyCornerRadiusShadowGreen(cornerRadiusValue: 8)
        

        
        }
    
    
    func resetFlightBackgrounds() {
        
            btnBus.backgroundColor = UIColor.clear
            btnFlight.backgroundColor = UIColor.clear
            btnHotel.backgroundColor = UIColor.clear
        
        imgFlight.tintColor = UIColor.white
        imgBus.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        imgHotel.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        lblFlight.textColor = UIColor.white
        lblHotel.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        lblBus.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        viewFlight.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        viewHotel.backgroundColor = UIColor.white
        viewBus.backgroundColor = UIColor.white
        //viewFlight.layer.applyCornerRadiusShadowGreen(cornerRadiusValue: 8)
        
        }
    
    func resetHotelBackgrounds() {
        
            btnBus.backgroundColor = UIColor.clear
            btnFlight.backgroundColor = UIColor.clear
            btnHotel.backgroundColor = UIColor.clear
        
        imgHotel.tintColor = UIColor.white
        imgBus.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        imgFlight.tintColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        lblHotel.textColor = UIColor.white
        lblFlight.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        lblBus.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.00)
        
        viewHotel.backgroundColor = UIColor(red: 0.81, green: 0.90, blue: 0.31, alpha: 1.00)
        viewFlight.backgroundColor = UIColor.white
        viewBus.backgroundColor = UIColor.white
       // viewHotel.layer.applyCornerRadiusShadowGreen(cornerRadiusValue: 8)


        
        }
    
    func resetButtonBackgrounds() {
            btnBus.backgroundColor = UIColor.clear
            btnFlight.backgroundColor = UIColor.clear
            btnHotel.backgroundColor = UIColor.clear
        }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           self.tabBarController?.tabBar.isHidden = true
        
        resetBusBackgrounds()
       

   }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
       
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
