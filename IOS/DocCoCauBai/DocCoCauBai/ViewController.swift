//
//  ViewController.swift
//  DocCoCauBai
//
//  Created by Nguyen The Binh on 3/30/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DBModel.ShareInstance.CreateDatabase(FILE_DATABASE)
        DBModel.ShareInstance.CreateTable("Doc", p_database: FILE_DATABASE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

