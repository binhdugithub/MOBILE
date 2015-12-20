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
        
//        for xx in (self.tabBar.items! as [UITabBarItem])
//        {
//            if xx.tag == 0
//            {
//                self.tabBar.selectedItem = xx
//                break
//            }
//        }
        
        self.tabBar.barTintColor = UIColor.blackColor()
        self.tabBar.tintColor = UIColor.brownColor()
        
        let homeSelectImage: UIImage! = UIImage(named: "home.png")?.imageWithRenderingMode(.AlwaysOriginal)
        //var qaSelectImage: UIImage! = UIImage(named: "Q&ASelected")?.imageWithRenderingMode(.AlwaysOriginal)
        //var mySelectImage: UIImage! = UIImage(named: "myBagSelected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        self.tabBar.items![0].image = homeSelectImage
        self.tabBar.items![0].selectedImage = homeSelectImage
        self.tabBar.items![0].title = String("Home")
        //(tabBar.items![1] as! UITabBarItem ).selectedImage = qaSelectImage
        //(tabBar.items![2] as! UITabBarItem ).selectedImage = mySelectImage
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
