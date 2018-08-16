//
//  AppTabBarController.swift
//  Vigor
//
//  Created by Jason Shu on 6/21/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController, UITabBarControllerDelegate {

    @IBInspectable var defaultIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // tab bar index
        selectedIndex = defaultIndex

        // icon insets
        for vc in self.viewControllers! {
            vc.tabBarItem.title = nil
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        animateTabBarChange(tabBarController: tabBarController, to: viewController)
        return true
    }
}

// animation
func animateTabBarChange(tabBarController: UITabBarController, to viewController: UIViewController) {
    let fromView: UIView = tabBarController.selectedViewController!.view
    let toView: UIView = viewController.view

    // do whatever animation you like
    if(fromView != toView) {
        UIView.transition(from: fromView, to: toView, duration: 0.2, options: [.transitionCrossDissolve], completion: nil)
    }
}

// reload table helper
func loadListHelper(vc: UITableViewController) {
    vc.tableView.reloadData()
}
