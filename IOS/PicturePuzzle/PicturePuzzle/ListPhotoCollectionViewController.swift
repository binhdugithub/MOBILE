//
//  ListPicCollectionViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "identifer_photocell"

class ListPhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var m_layout: PhotoLayout!
    var m_collectionview: UICollectionView!
    
    //header 
    var m_view_header: UIView!
    var m_view_subheader: UIView!
    var m_view_footer: UIView!
    
    var m_btn_home: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_level: UILabel!
    
    //index path 
    var m_indexpath_photo: NSIndexPath!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        SetupView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        if let l_indexpath = self.m_indexpath_photo
        {
            if let visibleIndexPaths = self.m_collectionview.indexPathsForVisibleItems().indexOf(l_indexpath)
            {
                if visibleIndexPaths != NSNotFound
                {
                    self.m_collectionview.reloadItemsAtIndexPaths([l_indexpath])
                }
            }
            
        }
        
        self.m_indexpath_photo = nil
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        l_btn_home_frm.origin.x = 1.0/2 * l_btn_home_frm.size.width
        m_btn_home = UIButton(frame: l_btn_home_frm)
        m_btn_home.setImage(UIImage(named: "btn_back"), forState: .Normal)
        m_btn_home.addTarget(self, action: #selector(ListPhotoCollectionViewController.HomeClick(_:)), forControlEvents: .TouchUpInside)
        
        //ads
        //        var l_btn_ads_frm = CGRectMake(0, 0, 0, 0)
        //        l_btn_ads_frm.size.height = 3.0/4 * m_view_header.frame.size.height
        //        l_btn_ads_frm.size.width = l_btn_ads_frm.size.height
        //        l_btn_ads_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_ads_frm.size.height)
        //        l_btn_ads_frm.origin.x = m_btn_home.frame.origin.x + m_btn_home.frame.size.width + 1.0/2 * m_btn_home.frame.size.width
        //        m_btn_ads = UIButton(frame: l_btn_ads_frm)
        //        m_btn_ads.setImage(UIImage(named: "btn_mute"), forState: .Normal)
        
        //level
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font: UIFont = UIFont.systemFontOfSize(30)
        l_lbl_level_frm.size.width = WidthForText("LEVEL 10", p_font: l_font, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_home.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_level = UILabel(frame: l_lbl_level_frm)
        m_lbl_level.textColor = UIColor.init(white: 1, alpha: 0.9)
        m_lbl_level.textAlignment = .Center
        m_lbl_level.text = "LEVEL 10"
        
        //coins
        var l_btn_coin_frm = CGRectMake(0, 0, 0, 0)
        l_btn_coin_frm.size.height = 1.0/2 * m_view_header.frame.size.height
        l_btn_coin_frm.size.width = 3 * l_btn_coin_frm.size.height
        l_btn_coin_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_btn_coin_frm.size.height)
        l_btn_coin_frm.origin.x = m_view_header.frame.size.width - l_btn_coin_frm.size.width - 1.0/3 * l_btn_coin_frm.size.width
        m_btn_coin = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.setImage(UIImage(named: "btn_coin"), forState: .Normal)
        
        
        //subheader view
        var l_view_subheader_frm: CGRect = CGRectMake(0,0,0,0)
        l_view_subheader_frm.size.width = SCREEN_WIDTH
        l_view_subheader_frm.size.height = ViewDesign.ShareInstance.HEIGHT_SUBHEADER
        l_view_subheader_frm.origin = CGPointMake(0, m_view_header.frame.size.height)
        m_view_subheader = UIView(frame: l_view_subheader_frm)
        m_view_subheader.backgroundColor = ViewDesign.ShareInstance.COLOR_SUBHEADER_BG
        
    
        //footer view
        var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
        l_view_footer_frm.size.width = SCREEN_WIDTH
        l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
        l_view_footer_frm.origin.x = 0
        l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
        m_view_footer = UIView(frame: l_view_footer_frm)
        m_view_footer.backgroundColor = ViewDesign.ShareInstance.COLOR_FOOTER_BG
        
        //
        //collection view
        var l_collectionview_frm = CGRectMake(0, 0, 0, 0)
        l_collectionview_frm.size.width = self.view.frame.width
        l_collectionview_frm.size.height = self.view.frame.height - m_view_header.frame.size.height - m_view_subheader.frame.size.height - m_view_footer.frame.size.height - 20
        l_collectionview_frm.origin.x = 0
        l_collectionview_frm.origin.y = m_view_subheader.frame.origin.y + m_view_subheader.frame.size.height + 10
        self.m_layout = PhotoLayout()
        m_collectionview = UICollectionView(frame: l_collectionview_frm, collectionViewLayout: self.m_layout)
        m_collectionview.delegate = self
        m_collectionview.dataSource = self
        m_collectionview.backgroundColor = UIColor.clearColor()
        
        // Register cell classes
        self.m_collectionview.registerClass(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //
        //
        //self add
        //
        m_view_header.addSubview(m_btn_home)
        //m_view_header.addSubview(m_btn_ads)
        m_view_header.addSubview(m_btn_coin)
        m_view_header.addSubview(m_lbl_level)
    
        self.view.addSubview(m_view_header)
        self.view.addSubview(m_view_subheader)
        self.view.addSubview(m_collectionview)
        self.view.addSubview(m_view_footer)
    }
    

    func HomeClick(sender: UIButton)
    {
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
            let l_item: NSIndexPath = sender as! NSIndexPath
            let ViewPlay = segue.destinationViewController as! PlayViewController
            ViewPlay.m_photo_index = l_item.item
            
            //PPCore.ShareInstance.m_ArrayPhoto[l_item.item].m_completed = PHOTO_STATUS.PHOTO_COMPLETED
            self.m_indexpath_photo = l_item
            
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
        return PPCore.ShareInstance.m_ArrayPhoto.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? PhotoCell
        let photo: Photo = PPCore.ShareInstance.m_ArrayPhoto[indexPath.item]
        cell!.SetPhoto(photo)
    
        return cell!
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        self.performSegueWithIdentifier("segue_listphoto_to_play", sender: indexPath)
        return true
    }
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

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
