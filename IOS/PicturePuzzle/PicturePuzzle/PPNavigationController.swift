//
//  PPNavigationController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/18/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class PPNavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
       self.navigationBarHidden = true
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

}
