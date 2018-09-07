//
//  MainTutorialUViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 07/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class MainTutorialUViewController: UIPageViewController {

    private var pages: [UIViewController]!
    private var currentUser: Users!
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    convenience init(currentUser: Users) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.currentUser = currentUser
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tutorial1 = TutorialOneViewController()
        let tutorial2 = TutorialTwoViewController()
        let tutorial3 = TutorialThreeViewController(currentUser: currentUser)
        
        self.pages = [tutorial1, tutorial2, tutorial3]
        
        setupDelegates()
        
        self.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    
}

extension MainTutorialUViewController: UIPageViewControllerDelegate {
    
}

extension MainTutorialUViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            }
            else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    
}
