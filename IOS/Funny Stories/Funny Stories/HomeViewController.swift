//
//  FirstViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/14/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit

let CELLIDENTIFIER = "StoryTableViewCell"

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var m_TableView: UITableView! = UITableView()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = String("Home")
        
        m_TableView.delegate = self
        m_TableView.dataSource = self
        //m_TableView.backgroundColor = UIColor.whiteColor()
        let testFrame : CGRect = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)
        m_TableView.frame = testFrame
        self.m_TableView.registerNib(UINib(nibName: CELLIDENTIFIER, bundle: nil), forCellReuseIdentifier: CELLIDENTIFIER)
        self.view.addSubview(self.m_TableView)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.m_TableView.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //print("height for row at index path:\(indexPath.row)")
        return CGFloat(FSDesign.ShareInstance.CELL_HEIGHT);
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return FSCore.ShareInstance.m_ArrayStory.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let l_cell = self.m_TableView.dequeueReusableCellWithIdentifier(CELLIDENTIFIER, forIndexPath: indexPath) as! StoryTableViewCell
        
        l_cell.SetRow(indexPath.row)
        l_cell.SetBackgroundColor(UIColor.whiteColor(), p_1: UIColor.whiteColor())
        
        if let p_title = FSCore.ShareInstance.m_ArrayStory[indexPath.row]["title"]
        {
            l_cell.SetTitle(p_title as? String)
        }
        else
        {
            l_cell.SetTitle(nil)
        }
        
        if let p_data: NSData = FSCore.ShareInstance.m_ArrayStory[indexPath.row]["uiimage"] as? NSData
        {
            if p_data.length <= 0
            {
                FSCore.ShareInstance.GETImageForCell(l_cell, p_row: indexPath.row)
            }
            else
            {
                //print("Already have avatar for:", l_cell.m_UILabelTitle.text)
                let l_image = UIImage(data: p_data)
                l_cell.SetImage(l_image)
            }
            
        }
        else
        {
            print("Cannot know type of uiimage in ArrayStory")
            FSCore.ShareInstance.m_ArrayStory[indexPath.row]["uiimage"] = NSData()
            FSCore.ShareInstance.GETImageForCell(l_cell, p_row: indexPath.row)
        }
        
        //print("Toi day roi.............................")
        return l_cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("Segue2Story", sender: self)
    }
    
  
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "Segue2Story"
        {
            //print("Prepare for segue: Segue2Story")
            //self.navigationItem.title = String("")
        }
    }
}

