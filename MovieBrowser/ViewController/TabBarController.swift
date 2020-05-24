//
//  TabBarController.swift
//  MovieBrowser
//
//  Created by Mohib Malgi on 2020-05-23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarViewControllers = self.viewControllers
      
        
        self.tabBar.items![0].image = UIImage(named:"ic_grid_unfill")
        self.tabBar.items![1].image = UIImage(named:"ic_search_unfill")
        
        
        self.tabBar.items![0].selectedImage = UIImage(named:"ic_grid_fill")?.withRenderingMode(.alwaysTemplate)
    
        self.tabBar.items![1].selectedImage = UIImage(named: "ic_search_fill")?.withRenderingMode(.alwaysTemplate)
        
        UITabBar.appearance().tintColor = UIColor.black

        
        self.setViewControllers(tabBarViewControllers, animated: true)
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
