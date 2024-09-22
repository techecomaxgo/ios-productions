//
//  PageContainerViewController.swift
//  MaxPay
//
//  Created by Admin on 02/07/24.
//

import UIKit

class PageContainerViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var viewControllersList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let pageOne = PageOneViewController()
        pageOne.mainViewController = self
        
        let pageTwo = PageTwoViewController()
        pageTwo.mainViewController = self
        
        let pageThree = FlightBookViewController()
        pageThree.mainViewController = self
        
        viewControllersList = [pageOne, pageTwo, pageThree]
        
        if let firstViewController = viewControllersList.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func goToNextPage(from viewController: UIViewController) {
        guard let currentIndex = viewControllersList.firstIndex(of: viewController), currentIndex < (viewControllersList.count - 1) else {
            return
        }
        let nextViewController = viewControllersList[currentIndex + 1]
        pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersList.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return viewControllersList[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersList.firstIndex(of: viewController), currentIndex < (viewControllersList.count - 1) else {
            return nil
        }
        return viewControllersList[currentIndex + 1]
    }
}
