//
//  ListPicCollectionViewController.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

private let reuseIdentifier = "identifer_photocell"

class ListPhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var m_layout: PhotoLayout!
    var m_collectionview: UICollectionView!
    
    //header 
    var m_view_header: UIView!
    var m_view_subheader: UIView!
    var m_view_body: UIView!
    var m_view_footer: UIView!
    var m_btn_home: UIButton!
    var m_btn_coin: UIButton!
    var m_lbl_coin: UILabel!
    var m_lbl_title: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ListPhotoViewController.HandlePurchaseNotification(_:)),
                                                         name: IAPHelper.IAPHelperPurchaseNotification,
                                                         object: nil)
        SetupView()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        GADMasterViewController.ShareInstance.ShowBannerView(self, p_ads_b: self.m_view_footer)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        ReloadAllChangedPhoto()
    }
    
    func ReloadAllChangedPhoto() -> Void
    {
        for l_indexpath in PPCore.ShareInstance.m_array_indexpath_reload
        {
            if let visibleIndexPaths = self.m_collectionview.indexPathsForVisibleItems().indexOf(l_indexpath)
            {
                if visibleIndexPaths != NSNotFound
                {
                    print("Reload item: \(l_indexpath.item)")
                    self.m_collectionview.reloadItemsAtIndexPaths([l_indexpath])
                }
            }
        }
        
        PPCore.ShareInstance.m_array_indexpath_reload.removeAll()
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
        l_btn_home_frm.origin.x = 1.0/3 * l_btn_home_frm.size.width
        m_btn_home = UIButton(frame: l_btn_home_frm)
        m_btn_home.setImage(UIImage(named: "btn_home"), forState: .Normal)
        m_btn_home.addTarget(self, action: #selector(ListPhotoViewController.HomeClick(_:)), forControlEvents: .TouchUpInside)

        
        //level
        var l_lbl_level_frm = CGRectMake(0, 0, 0, 0)
        let l_font_level: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[6], size: ViewDesign.ShareInstance.FONT_SIZE_HEADER)!
        l_lbl_level_frm.size.width = WidthForText(NAME_APP, p_font: l_font_level, p_heigh: m_view_header.frame.size.height)
        l_lbl_level_frm.size.height = m_btn_home.frame.size.height
        l_lbl_level_frm.origin.x = 1.0/2 * (m_view_header.frame.size.width - l_lbl_level_frm.size.width)
        l_lbl_level_frm.origin.y = 1.0/2 * (m_view_header.frame.size.height - l_lbl_level_frm.size.height)
        m_lbl_title = UILabel(frame: l_lbl_level_frm)
        m_lbl_title.textColor = UIColor.whiteColor()
        m_lbl_title.textAlignment = .Center
        m_lbl_title.text = NAME_APP
        m_lbl_title.font = l_font_level
        
        //btn coins
        var l_btn_coin_frm = m_btn_home.frame
        l_btn_coin_frm.size.height = 0.6 * l_btn_coin_frm.size.height
        l_btn_coin_frm.size.width = 3 * l_btn_coin_frm.size.height
        l_btn_coin_frm.origin.x = m_view_header.frame.size.width - l_btn_coin_frm.size.width - m_btn_home.frame.origin.x
        l_btn_coin_frm.origin.y = m_btn_home.frame.origin.y + m_btn_home.frame.size.height - l_btn_coin_frm.size.height
        m_btn_coin = UIButton(frame: l_btn_coin_frm)
        m_btn_coin.addTarget(self, action: #selector(HomeViewController.CoinClick(_:)), forControlEvents: .TouchUpInside)
        m_btn_coin.backgroundColor = UIColor.clearColor()
        m_btn_coin.setBackgroundImage(UIImage(named: "btn_coin"), forState: .Normal)
        
        //title coin
        var l_lbl_coin_frm = m_btn_coin.frame
        let l_font_coin: UIFont = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN)!
        //l_lbl_coin_frm.size.width =  //WidthForText(String(PPCore.ShareInstance.m_coin), p_font: l_font_coin, p_heigh: l_lbl_coin_frm.size.height)
        l_lbl_coin_frm.origin.x = 0 - 1.0/4 * l_lbl_coin_frm.size.width
        l_lbl_coin_frm.origin.y = 0.1 * l_lbl_coin_frm.size.height
        
        m_lbl_coin = UILabel(frame: l_lbl_coin_frm)
        m_lbl_coin.textAlignment = .Right
        m_lbl_coin.font = l_font_coin
        m_lbl_coin.textColor = ViewDesign.ShareInstance.COLOR_COIN_TITLE
        m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
        
        m_btn_coin.addSubview(m_lbl_coin)
        
    
        if Configuration.ShareInstance.m_isads == true
        {
            //footer view
            var l_view_footer_frm: CGRect = CGRectMake(0, 0, 0, 0)
            l_view_footer_frm.size.width = SCREEN_WIDTH
            l_view_footer_frm.size.height = ViewDesign.ShareInstance.HEIGHT_ADS
            l_view_footer_frm.origin.x = 0
            l_view_footer_frm.origin.y = SCREEN_HEIGHT - l_view_footer_frm.size.height
            m_view_footer = UIView(frame: l_view_footer_frm)
            m_view_footer.backgroundColor = UIColor.clearColor()
            
            let l_lbl_copyright = UILabel.init(frame: l_view_footer_frm)
            l_lbl_copyright.frame.origin.x = 0
            l_lbl_copyright.frame.origin.y = 0
            l_lbl_copyright.textColor = UIColor.blackColor()
            l_lbl_copyright.text = TEXT_COPYRIGHT
            l_lbl_copyright.textAlignment = .Center
            l_lbl_copyright.font = UIFont.systemFontOfSize(CGFloat(ViewDesign.ShareInstance.FONT_SIZE_COPYRIGHT))
            m_view_footer.addSubview(l_lbl_copyright)
            
            self.view.addSubview(m_view_footer)
            
            //
            //body view
            var l_body_frm = CGRectMake(0, 0, 0, 0)
            l_body_frm.size.width = self.view.frame.width
            l_body_frm.size.height = self.view.frame.height - m_view_header.frame.size.height - m_view_footer.frame.size.height
            l_body_frm.origin.x = 0
            l_body_frm.origin.y = 0 + m_view_header.frame.size.height
            m_view_body = UIView(frame: l_body_frm)
        }
        else
        {
            //
            //body view
            var l_body_frm = CGRectMake(0, 0, 0, 0)
            l_body_frm.size.width = self.view.frame.width
            l_body_frm.size.height = self.view.frame.height - m_view_header.frame.size.height
            l_body_frm.origin.x = 0
            l_body_frm.origin.y = 0 + m_view_header.frame.size.height
            m_view_body = UIView(frame: l_body_frm)
        }
        
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
        self.m_layout = PhotoLayout()
        m_collectionview = UICollectionView(frame: l_cllv_frm, collectionViewLayout: self.m_layout)
        m_collectionview.delegate = self
        m_collectionview.dataSource = self
        m_collectionview.backgroundColor = UIColor.clearColor()

        self.m_collectionview.registerClass(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //
        //
        //self add
        //
        m_view_header.addSubview(m_btn_home)
        m_view_header.addSubview(m_btn_coin)
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
    
    
    func OpenPhoto(sender: UIButton)
    {
        print("Open photo: \(sender.tag)")
        SoundController.ShareInstance.PlayClick()
        if PPCore.ShareInstance.m_coin < COIN_OPEN_PHOTO
        {
            ShowToast("You don't have enough coin!")
            return
        }
        
        
        PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin - COIN_OPEN_PHOTO
        PPCore.ShareInstance.m_ArrayPhoto[sender.tag].m_completed = PHOTO_STATUS.PHOTO_NOT_COMPLETED
        PPCore.ShareInstance.m_level = sender.tag
        PPCore.ShareInstance.m_ArrayPhoto[sender.tag].m_is_choosing = false
        PPCore.ShareInstance.m_array_indexpath_reload.append(NSIndexPath(forItem: sender.tag, inSection: 0))
        
        Configuration.ShareInstance.WriteComplete(sender.tag, p_completed: PHOTO_STATUS.PHOTO_NOT_COMPLETED.rawValue)
        
        self.performSegueWithIdentifier("segue_listphoto_to_play", sender: nil)
        
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
        return PPCore.ShareInstance.m_ArrayPhoto.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? PhotoCell
        let photo: Photo = PPCore.ShareInstance.m_ArrayPhoto[indexPath.item]
        cell!.SetPhoto(photo)
        cell?.m_btn_coin.addTarget(self, action: #selector(ListPhotoViewController.OpenPhoto(_:)), forControlEvents: .TouchUpInside)
    
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
        
        if PPCore.ShareInstance.m_ArrayPhoto[indexPath.item].m_completed == PHOTO_STATUS.PHOTO_LOCK
        {
            for l_item in 0..<PPCore.ShareInstance.m_ArrayPhoto.count
            {
                if PPCore.ShareInstance.m_ArrayPhoto[l_item].m_is_choosing == true
                {
                    PPCore.ShareInstance.m_ArrayPhoto[l_item].m_is_choosing = false
                    PPCore.ShareInstance.m_array_indexpath_reload.append(NSIndexPath(forItem: l_item, inSection: 0))
                }
            }
            
            
            PPCore.ShareInstance.m_ArrayPhoto[indexPath.item].m_is_choosing = true
            PPCore.ShareInstance.m_array_indexpath_reload.append(indexPath)
            self.ReloadAllChangedPhoto()
            
            PPCore.ShareInstance.m_array_indexpath_reload.append(indexPath)

        }
        else
        {
            for l_index in PPCore.ShareInstance.m_array_indexpath_reload
            {
                PPCore.ShareInstance.m_ArrayPhoto[l_index.item].m_is_choosing = false
            }
            self.ReloadAllChangedPhoto()
            
            PPCore.ShareInstance.m_level = indexPath.item
            PPCore.ShareInstance.m_array_indexpath_reload.append(indexPath)
            
            self.performSegueWithIdentifier("segue_listphoto_to_play", sender: nil)
        }

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

    func ShowToast(p_title: String)
    {
        var l_frm = CGRectMake(0, 0, 0, 0)
        let l_font = UIFont(name: ViewDesign.ShareInstance.FONT_NAMES[2], size: ViewDesign.ShareInstance.FONT_SIZE_COIN - 2)!
        
        l_frm.size.width = WidthForText(p_title, p_font: l_font, p_heigh: 1000)
        l_frm.size.width = l_frm.size.width + 0.25 * l_frm.size.width
        l_frm.size.height = HeightForText(p_title, p_font: l_font, p_width: 1000)
        l_frm.size.height = l_frm.size.height + 0.2 * l_frm.size.height
        l_frm.origin.x = 1.0/2 * (self.view.frame.size.width - l_frm.size.width)
        l_frm.origin.y = m_view_subheader.frame.size.height
        let toastLabel = UILabel(frame: l_frm)
        
        toastLabel.font = l_font
        toastLabel.backgroundColor = UIColor.blackColor()
        toastLabel.textColor = ViewDesign.ShareInstance.COLOR_COIN_TITLE
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.m_view_body.addSubview(toastLabel)
        toastLabel.text = p_title
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animateWithDuration(6.0, delay: 0.2, options: .CurveEaseOut, animations: {
            toastLabel.alpha = 0.0
            }, completion: { (finished: Bool) -> Void in
                toastLabel.removeFromSuperview()
        })
    }
    
}



extension ListPhotoViewController
{
    func HandlePurchaseNotification(notification: NSNotification)
    {
        guard let productID = notification.object as? String else { return }
        
        for (_, product) in PPCore.ShareInstance.m_products.enumerate()
        {
            guard product.productIdentifier == productID else { continue }
            
            let l_price = Int(ceil(product.price.floatValue))
            switch l_price
            {
            case 2:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 200
                print("Buy ok 200 coin")
                break
            case 3:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 400
                print("Buy ok 400 coin")
                break
            case 4:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 600
                print("Buy ok 600 coin")
                break
            case 5:
                PPCore.ShareInstance.m_coin = PPCore.ShareInstance.m_coin + 800
                print("Buy ok 800 coin")
                break
            default:
                print("Don't know this price")
                break
            }
            
            SoundController.ShareInstance.WinCoin()
            m_lbl_coin.Shake()
            m_lbl_coin.text = String(PPCore.ShareInstance.m_coin)
            m_lbl_coin.frame.size.width = WidthForText(String(PPCore.ShareInstance.m_coin), p_font: m_lbl_coin.font, p_heigh: m_lbl_coin.frame.size.height)
            Configuration.ShareInstance.WriteCoin(PPCore.ShareInstance.m_coin)
            Configuration.ShareInstance.WriteAdsMode(false)
        }
    }
    
    func CoinClick(sender: UIButton)
    {
        print("Coin click")
        SoundController.ShareInstance.PlayClick()
        
        //view purchase background
        var l_frm = self.view.frame
        l_frm.origin = CGPointMake(0, 0)
        let l_view = UIView(frame: l_frm)
        l_view.backgroundColor = UIColor.init(white: 0.2, alpha: 0.8)
        
        //view purchase
        var l_view_purchase_frm = CGRectMake(0, 0, 0, 0)
        l_view_purchase_frm.size.width = ViewDesign.ShareInstance.WIDTH_PURCHASE
        l_view_purchase_frm.size.height = 1.5 * l_view_purchase_frm.size.width
        l_view_purchase_frm.origin.x = 0.5 * (SCREEN_WIDTH - l_view_purchase_frm.size.width)
        l_view_purchase_frm.origin.y = 0.5 * (SCREEN_HEIGHT - l_view_purchase_frm.size.height)
        let l_view_purchase = UIView(frame: l_view_purchase_frm)
        l_view_purchase.backgroundColor = UIColor.darkGrayColor()
        l_view_purchase.layer.borderColor = UIColor.whiteColor().CGColor
        l_view_purchase.layer.borderWidth = 1.0/50 * l_view_purchase_frm.size.width
        l_view_purchase.layer.cornerRadius = l_view_purchase.layer.borderWidth
        
        //label bonus
        var l_lbl_bonus_frm = l_view_purchase.frame
        let l_font = m_lbl_coin.font
        l_lbl_bonus_frm.size.width = l_lbl_bonus_frm.size.width - 2 * l_view_purchase.layer.borderWidth
        l_lbl_bonus_frm.size.height = HeightForText("Bonus! Make any purchase and deactivate the ads!", p_font: l_font, p_width: l_lbl_bonus_frm.size.width)
        l_lbl_bonus_frm.origin = CGPointMake(l_view_purchase.layer.borderWidth, 2 * l_view_purchase.layer.borderWidth)
        let l_lbl_bonus = UILabel(frame: l_lbl_bonus_frm)
        l_lbl_bonus.text = "Bonus! Make any purchase and deactivate the ads!"
        l_lbl_bonus.numberOfLines = 0
        l_lbl_bonus.lineBreakMode = .ByWordWrapping
        l_lbl_bonus.textAlignment = .Center
        l_lbl_bonus.font = l_font
        l_lbl_bonus.textColor = UIColor.whiteColor()
        
        //close
        var l_btn_close_frm = CGRectMake(0, 0, 0, 0)
        l_btn_close_frm.size.width = 1.0/7 * l_view_purchase.frame.size.width
        l_btn_close_frm.size.height = l_btn_close_frm.size.width
        l_btn_close_frm.origin.x = 0.5 * (l_view_purchase.frame.size.width - l_btn_close_frm.size.width)
        l_btn_close_frm.origin.y = l_view_purchase.frame.size.height - 1.5 * l_btn_close_frm.size.height
        let m_btn_closepurchase = UIButton(frame: l_btn_close_frm)
        m_btn_closepurchase.backgroundColor = UIColor.redColor()
        m_btn_closepurchase.setTitle("x", forState: .Normal)
        m_btn_closepurchase.setTitleColor(UIColor.blackColor(), forState: .Normal)
        m_btn_closepurchase.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
        m_btn_closepurchase.layer.cornerRadius = 0.5 * l_btn_close_frm.size.width
        m_btn_closepurchase.layer.borderColor = UIColor.whiteColor().CGColor
        m_btn_closepurchase.layer.borderWidth = 1.0/40 * l_btn_close_frm.size.width
        m_btn_closepurchase.addTarget(self, action: #selector(ListPhotoViewController.CloseClick(_:)), forControlEvents: .TouchUpInside)
        
        
        //2 dollar
        let l_h = m_btn_closepurchase.frame.origin.y - l_lbl_bonus.frame.origin.y - l_lbl_bonus.frame.size.height
        let l_btn_purchase_h = l_h * 1.0 / 5.75
        var l_btn_frm = CGRectMake(0, 0, 0, 0)
        l_btn_frm.size.height = l_btn_purchase_h
        l_btn_frm.size.width = 4 * l_btn_frm.size.height
        l_btn_frm.origin.x = 0.5 * (l_view_purchase.frame.size.width - l_btn_frm.size.width)
        l_btn_frm.origin.y = l_lbl_bonus.frame.origin.y + l_lbl_bonus.frame.size.height + 0.5 * l_btn_frm.size.height
        let l_btn_2dollar = UIButton(frame: l_btn_frm)
        l_btn_2dollar.setImage(UIImage(named: "2dollar"), forState: .Normal)
        l_btn_2dollar.tag = 2
        l_btn_2dollar.addTarget(self, action: #selector(ListPhotoViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //3 dollar
        l_btn_frm.origin.y = l_btn_2dollar.frame.origin.y + 1.25 * l_btn_2dollar.frame.size.height
        let l_btn_3dollar = UIButton(frame: l_btn_frm)
        l_btn_3dollar.setImage(UIImage(named: "3dollar"), forState: .Normal)
        l_btn_3dollar.tag = 3
        l_btn_3dollar.addTarget(self, action: #selector(ListPhotoViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //4 dollar
        l_btn_frm.origin.y = l_btn_3dollar.frame.origin.y + 1.25 * l_btn_3dollar.frame.size.height
        let l_btn_4dollar = UIButton(frame: l_btn_frm)
        l_btn_4dollar.setImage(UIImage(named: "4dollar"), forState: .Normal)
        l_btn_4dollar.tag = 4
        l_btn_4dollar.addTarget(self, action: #selector(ListPhotoViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        //5 dollar
        l_btn_frm.origin.y = l_btn_4dollar.frame.origin.y + 1.25 * l_btn_4dollar.frame.size.height
        let l_btn_5dollar = UIButton(frame: l_btn_frm)
        l_btn_5dollar.setImage(UIImage(named: "5dollar"), forState: .Normal)
        l_btn_5dollar.tag = 5
        l_btn_5dollar.addTarget(self, action: #selector(ListPhotoViewController.GetCoin(_:)), forControlEvents: .TouchUpInside)
        
        
        l_view_purchase.addSubview(l_btn_2dollar)
        l_view_purchase.addSubview(l_btn_3dollar)
        l_view_purchase.addSubview(l_btn_4dollar)
        l_view_purchase.addSubview(l_btn_5dollar)
        l_view_purchase.addSubview(m_btn_closepurchase)
        l_view_purchase.addSubview(l_lbl_bonus)
        
        
        l_view.addSubview(l_view_purchase)
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.view.addSubview(l_view)
        })
    }
    
    func CloseClick(sender: UIButton)
    {
        UIView.animateWithDuration(0.5, animations: {
            sender.superview?.superview?.removeFromSuperview()
        })
        
    }
    
    
    func GetCoin(sender: UIButton)
    {
        for l_product in PPCore.ShareInstance.m_products
        {
            if Int(ceil(l_product.price.floatValue)) == sender.tag
            {
                PPCore.ShareInstance.m_iaphelper.buyProduct(l_product)
                break
            }
        }
        
    }
}