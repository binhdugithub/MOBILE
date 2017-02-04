//
//  RootTabBarController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/17/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        self.tabBar.barTintColor = FSDesign.ShareInstance.COLOR_TABBAR_BG
        //self.tabBar.backgroundColor = UIColor.blackColor()
        self.tabBar.tintColor = FSDesign.ShareInstance.COLOR_TABBAR_TINT
      
        
        let homeSelectImage: UIImage! = UIImage(named: "tabbar_home")?.withRenderingMode(.alwaysTemplate)
        self.tabBar.items![0].image = homeSelectImage
        self.tabBar.items![0].selectedImage = homeSelectImage
        self.tabBar.items![0].title = String("Home")
      
        FSDesign.ShareInstance.TABBAR_HEIGHT  = self.tabBar.bounds.size.height
      
        let favoriteSelectImage: UIImage! = UIImage(named: "tabbar_favorite")?.withRenderingMode(.alwaysTemplate)
        self.tabBar.items![1].image = favoriteSelectImage
        self.tabBar.items![1].selectedImage = favoriteSelectImage
        self.tabBar.items![1].title = String("Favorite")
      
        let moreSelectImage: UIImage! = UIImage(named: "tabbar_more")?.withRenderingMode(.alwaysTemplate)
        self.tabBar.items![2].image = moreSelectImage
        self.tabBar.items![2].selectedImage = moreSelectImage
        self.tabBar.items![2].title = String("More")

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
