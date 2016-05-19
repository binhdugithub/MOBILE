//
//  ListPicCollectionViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "identifer_photocell"

class ListMoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var m_layout: MoreLayout!
    var m_collectionview: UICollectionView!
    
    //header
    var m_view_header: UIView!
    var m_view_subheader: UIView!
    var m_view_body: UIView!
   
    var m_btn_home: UIButton!
    var m_lbl_title: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if PPCore.ShareInstance.m_ArrayApp.count <= 0
        {
            NetWorkModel.ShareInstance.GETApps()
        }
    
        SetupView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

    }

    func SetupView() -> Void
    {
        self.view.backgroundColor = UIColor.clearColor()
        //
        //header view
        //
        var l_view_header_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_header_frm.size.width = SCREEN_WIDTH
        l_view_header_frm.size.height = ViewDesign.ShareInstance.HEIGHT_HEADER
        l_view_header_frm.origin = CGPointMake(0, 0)
        m_view_header = UIView(frame: l_view_header_frm)
        m_view_header.backgroundColor = ViewDesign.ShareInstance.COLOR_HEADER_BG
        
        //home
        var l_btn_home_frm = CGRectMake(0, 0, 0, 0)
        l_btn_home_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        l_btn_home_frm.size.width = l_btn_home_frm.size.height
        l_btn_home_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_home_frm.size.height)
        l_btn_home_frm.origin.x = 1.0/3 * l_btn_home_frm.size.width
        m_btn_home = UIButton(frame: l_btn_home_frm)
        m_btn_home.setImage(UIImage(named: "btn_back"), forState: .Normal)
        m_btn_home.addTarget(self, action: #selector(ListPhotoViewController.HomeClick(_:)), forControlEvents: .TouchUpInside)
        
        
        //level
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font_level: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[6], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)!
        l_lbl_level_frm.size.width = WidthForText("MORE FREE", p_font: l_font_level, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_home.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_title = UILabel(frame: l_lbl_level_frm)
        m_lbl_title.textColor = UIColor.whiteColor()
        m_lbl_title.textAlignment = .Center
        m_lbl_title.text = "MORE FREE"
        m_lbl_title.font = l_font_level
        
        //
        //body view
        var l_body_frm = CGRectMake(0, 0, 0, 0)
        l_body_frm.size.width = self.view.frame.width
        l_body_frm.size.height = self.view.frame.height - m_view_header.frame.size.height
        l_body_frm.origin.x = 0
        l_body_frm.origin.y = 0 + m_view_header.frame.size.height
        m_view_body = UIView(frame: l_body_frm)
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = m_view_body.frame.size.width
        l_view_subheader_frm.size.height = ViewDesign.ShareInstance.HEIGHT_SUBHEADER
        l_view_subheader_frm.origin = CGPointMake(0, 0)
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
        //collection view
        var l_cllv_frm = m_view_body.frame
        l_cllv_frm.size.height = l_cllv_frm.size.height - m_view_subheader.frame.size.height
        l_cllv_frm.origin.x = 0
        l_cllv_frm.origin.y = m_view_subheader.frame.size.height
        self.m_layout = MoreLayout()
        m_collectionview = UICollectionView(frame: l_cllv_frm, collectionViewLayout: self.m_layout)
        m_collectionview.delegate = self
        m_collectionview.dataSource = self
        m_collectionview.backgroundColor = UIColor.clearColor()
        
        self.m_collectionview.registerClass(MoreCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //
        //
        //self add
        //
        m_view_header.addSubview(m_btn_home)
        m_view_header.addSubview(m_lbl_title)
        
        self.view.addSubview(m_view_header)
        self.m_view_body.addSubview(m_view_subheader)
        self.m_view_body.addSubview(m_collectionview)
        self.view.addSubview(m_view_body)
    }
    
    
    func HomeClick(sender: UIButton)
    {
        SoundController.ShareInstance.PlayClick()
        if let l_navController = self.navigationController
        {
            for controller in l_navController.viewControllers
            {
                if controller.isKindOfClass(HomeViewController)
                {
                    let HomeView: HomeViewController = controller as! HomeViewController
                    l_navController.popToViewController(HomeView, animated: true)
                }
            }
            
        }
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "segue_listphoto_to_play"
        {
            //            let l_item: NSIndexPath = sender as! NSIndexPath
            //            let ViewPlay = segue.destinationViewController as! PlayViewController
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return PPCore.ShareInstance.m_ArrayApp.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? MoreCell
        let l_app = PPCore.ShareInstance.m_ArrayApp[indexPath.item]
        cell!.SetApp(l_app)
        
        return cell!
    }
    
    // MARK: UICollectionViewDelegate
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        //print("shouldHighlightItemAtIndexPath")
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let l_linkapp = PPCore.ShareInstance.m_ArrayApp[indexPath.item].m_link
        UIApplication.sharedApplication().openURL(NSURL(string : l_linkapp)!)
        return true
        
    }
    
    
    
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    
}

