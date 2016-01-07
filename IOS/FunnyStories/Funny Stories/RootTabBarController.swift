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
        NSLog("Vao Root tab bar controller")

        self.tabBar.barTintColor = UIColor.brownColor()
        //self.tabBar.tintColor = UIColor.brownColor()
        
        let homeSelectImage: UIImage! = UIImage(named: "home.png")?.imageWithRenderingMode(.AlwaysOriginal)
        self.tabBar.items![0].image = homeSelectImage
        self.tabBar.items![0].selectedImage = homeSelectImage
        self.tabBar.items![0].title = String("Home")
      
      
        let favoriteSelectImage: UIImage! = UIImage(named: "favorite.png")?.imageWithRenderingMode(.AlwaysOriginal)
        self.tabBar.items![1].image = favoriteSelectImage
        self.tabBar.items![1].selectedImage = favoriteSelectImage
        self.tabBar.items![1].title = String("Favorite")

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
