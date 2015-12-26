//
//  SecondViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/14/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController
{
   

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarController?.tabBar.hidden = false
        self.navigationItem.title = String("Favorite")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

