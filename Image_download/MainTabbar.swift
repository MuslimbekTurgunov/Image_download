//
//  MainTabbar.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import UIKit

class MainTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = MainVC.init(nibName: "MainVC", bundle: nil)
        let vc2 = SearchVC.init(nibName: "SearchVC", bundle: nil)
        
        let tabbar1 = UITabBarItem.init(title: "Main", image: UIImage(systemName: "house"), selectedImage: nil)
        let tabbar2 = UITabBarItem.init(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        
        vc1.tabBarItem = tabbar1
        vc2.tabBarItem = tabbar2
        
        self.viewControllers = [vc1, vc2]
        
        
    }
    


}
