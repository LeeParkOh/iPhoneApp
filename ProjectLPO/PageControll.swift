//
//  PageControll.swift
//  ProjectLPO
//
//  Created by Jihun Oh on 2017. 4. 4..
//  Copyright © 2017년 Jihun Oh. All rights reserved.
//

import UIKit

class UIPageControl: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var featurePageControl: UIPageControl!
    
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "Timeline"),
                self.VCInstance(name: "SS"),
                self.VCInstance(name: "Lotte"),
                self.VCInstance(name: "Loan")
        ]
    }()
    
    
  
    
    private func VCInstance(name:String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = VCArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                
                view.backgroundColor = UIColor.clear
                
                
                
            }
        }
    }
    
    */
    
    
    //@available(iOS 5.0, *)
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
      guard let viewControllerIndex = VCArr.index(of: viewController) else
            {
                return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArr.last
        }
        
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        
        
        return VCArr[previousIndex]
    
    }
    
    //@available(iOS 5.0, *)
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArr.index(of: viewController) else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else {
            return VCArr.first
        }
        
        guard VCArr.count > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]

        
    }
    
   
    //@available(iOS 6.0, *)
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return VCArr.count
        
    }
    
    //@available(iOS 6.0, *)
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewContorller = viewControllers?.first, let firstViewControllerIndex = VCArr.index(of: firstViewContorller) else {
            return 0
            
        }
        return firstViewControllerIndex
        
    }
 
    
    
    
}
