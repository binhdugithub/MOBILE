//
//  HomeViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UICollectionViewController
{
    @IBOutlet weak var m_TxtSearch: UITextField!
    var m_Indicator: UIActivityIndicatorView?
    var m_IsScrolled: Bool = false
  
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle
  {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    if let layout = collectionView?.collectionViewLayout as? HomeLayout
    {
      layout.delegate = self
    }
    
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.contentInset = FSDesign.ShareInstance.INSET_COLLECTION
    
    
    var l_rect = CGRectMake(0, 0, 0, 0)
    l_rect.size.width = 1.0/5 * SCREEN_WIDTH
    l_rect.size.height = l_rect.size.width
    l_rect.origin.x = 0.5 * (SCREEN_WIDTH - l_rect.size.width)
    l_rect.origin.y  = 0.5 * (SCREEN_HEIGHT - l_rect.size.height)
    m_Indicator = UIActivityIndicatorView(frame: l_rect)
    m_Indicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
    self.view.addSubview(m_Indicator!)
    
    FSCore.ShareInstance.m_IndexStoryStartDisplayed =  FSCore.ShareInstance.m_IndexStoryStartDisplayed > (FSCore.ShareInstance.m_ArrayStory.count - 1) ? FSCore.ShareInstance.m_ArrayStory.count - 1 : FSCore.ShareInstance.m_IndexStoryStartDisplayed
    
    
    //load story
    if FSCore.ShareInstance.m_ArrayStory.count <= 8
    {
      self.view.bringSubviewToFront(m_Indicator!)
      m_Indicator!.startAnimating()
      
      if FSCore.ShareInstance.m_ArrayTemp.count > 0
      {
        NetWorkModel.ShareInstance.GETStories((FSCore.ShareInstance.m_ArrayTemp.last?.m_id)!, p_limit: NUMBER_IMAGES_ONCE_LOAD, p_object: self)
      }
      else
      {
         NetWorkModel.ShareInstance.GETStories(-1, p_limit: NUMBER_IMAGES_ONCE_LOAD, p_object: self)
      }
      
    }
    
    FSDesign.ShareInstance.NAVIGATOR_HEIGHT = (self.navigationController?.navigationBar.bounds.size.height)!
    FSDesign.ShareInstance.STATUSBAR_HEIGHT = UIApplication.sharedApplication().statusBarFrame.size.height
    
  }
  
  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.hidden = false
    self.navigationController?.navigationBarHidden = true
  
    m_TxtSearch.hidden = true

  }
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)

//    if m_IsScrolled == false && FSCore.ShareInstance.m_IndexStoryStartDisplayed > 0
//    {
//      NSThread(target: self, selector: #selector(HomeViewController.doSomething(_:)), object: Int(0)).start()
//    }

  }
  
  override func viewDidLayoutSubviews()
  {
    //print("viewDidLayoutSubviews")
    super.viewDidLayoutSubviews()
  }
  
  func doSomething(p_param: AnyObject)
  {
    let l_indexParam = p_param as! Int
    //print("scrool to: \(l_indexParam)")
    
    let l_array = self.collectionView?.indexPathsForVisibleItems()
    var l_row = l_array![0]
    
    for indexPath in l_array!
    {
      if indexPath.row > l_row.row
      {
        l_row = indexPath
      }
    }
    
    print("Find something: \(l_row.row)")
    print("have to: \(FSCore.ShareInstance.m_IndexStoryStartDisplayed)")
    
    if l_row.row <= FSCore.ShareInstance.m_IndexStoryStartDisplayed
    {
      if l_row.row > l_indexParam
      {
        print("Scroll to: \(l_row.row)")
        ScrollToRow(l_row)
        
        NSThread(target: self, selector: #selector(HomeViewController.doSomething(_:)), object: Int(l_row.row)).start()
      }
      else if l_row.row < FSCore.ShareInstance.m_IndexStoryStartDisplayed
      {
        //NSThread.sleepForTimeInterval(0.5)
        NSThread(target: self, selector: #selector(HomeViewController.doSomething(_:)), object: Int(l_indexParam)).start()
      }
      else
      {
        self.m_IsScrolled = true
      }

    }
    else
    {
      self.m_IsScrolled = true
    }
    
  }
  
  func ScrollToRow(p_row: NSIndexPath)
  {
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
    {
        dispatch_async(dispatch_get_main_queue())
        {
          self.collectionView?.layoutIfNeeded()
          self.collectionView?.scrollToItemAtIndexPath(p_row, atScrollPosition: .Top, animated: false)
        }
    }
    
  }
  
  
  func ReloadData()
  {
    if let layout = collectionView?.collectionViewLayout as? HomeLayout
    {
      if NSThread.isMainThread()
      {
        layout.clearCache()
        self.collectionView!.reloadData()
        if (self.m_Indicator!.isAnimating())
        {
          self.m_Indicator!.stopAnimating()
        }
      }
      else
      {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
          {
          // do your task
          
          dispatch_async(dispatch_get_main_queue())
          {
              layout.clearCache()
              self.collectionView!.reloadData()
            if (self.m_Indicator!.isAnimating())
            {
              self.m_Indicator!.stopAnimating()
            }
          }
        }
        
      }
      
    }
  }
  
  
  func ShowToast(p_title: String)
  {
    var l_frm = CGRectMake(0, 0, 0, 0)
    l_frm.size.width = self.view.frame.size.width - 100
    if IS_IPAD_PRO || IS_IPAD_2X
    {
        l_frm.size.width = self.view.frame.size.width - 300
    }
    l_frm.size.height = 40
    if IS_IPAD_PRO || IS_IPAD_2X
    {
        l_frm.size.height = 45
    }
    
    l_frm.origin.x = 1.0/2 * (self.view.frame.size.width - l_frm.size.width)
    l_frm.origin.y = self.view.frame.size.height - 100
    let toastLabel = UILabel(frame: l_frm)
    
    toastLabel.font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[2], size: FSDesign.ShareInstance.FONT_CELL_SIZE - 2)!
    toastLabel.backgroundColor = UIColor.blackColor()
    toastLabel.textColor = UIColor.whiteColor()
    toastLabel.textAlignment = NSTextAlignment.Center;
    self.view.addSubview(toastLabel)
    toastLabel.text = p_title
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animateWithDuration(6.0, delay: 0.1, options: .CurveEaseOut, animations: {
      toastLabel.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            toastLabel.removeFromSuperview()
            })

    
  }
  
}

//Collection delegate
extension HomeViewController
{

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
  {
    //highlightCell(indexPath, flag: true)
    self.performSegueWithIdentifier("Segue2Story", sender: indexPath)
  }

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
  {
    if segue.identifier == "Segue2Story"
    {
      let StoryView = segue.destinationViewController as! StoryViewController
      let l_item: NSIndexPath = sender as! NSIndexPath
      StoryView.m_Story = FSCore.ShareInstance.m_ArrayStory[l_item.row]
      StoryView.m_IsHomeView = true
    }
  }
  
  
  func highlightCell(indexPath : NSIndexPath, flag: Bool)
  {
    
    let cell = collectionView!.cellForItemAtIndexPath(indexPath)
    
    if flag
    {
      cell?.contentView.backgroundColor = UIColor.magentaColor()
    }
    else
    {
      cell?.contentView.backgroundColor = nil
    }
  }
  
  
  override func scrollViewDidEndDecelerating(scrollView: UIScrollView)
  {
    
    //print("****scrollViewDidEndDecelerating****")
    let l_visibles: [NSIndexPath] = (collectionView?.indexPathsForVisibleItems())!
    
    var l_row = l_visibles[0].row
    for l_indexpath in l_visibles
    {
      if l_indexpath.row < l_row
      {
        l_row = l_indexpath.row
      }
    }
    
    Configuration.ShareInstance.m_CurrentStory = l_row
    
    
    if (scrollView.contentOffset.y < 0)
    {

    }
    else if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
    {

      var l_frame = m_Indicator?.frame;
      l_frame?.origin.y = SCREEN_HEIGHT - 49 - ((l_frame?.size.height)! / 2.0)
      m_Indicator?.frame = l_frame!;
      self.view.bringSubviewToFront(m_Indicator!)
      m_Indicator!.startAnimating()
      
      NetWorkModel.ShareInstance.GETStories((FSCore.ShareInstance.m_ArrayStory.last?.m_id)!,p_limit: NUMBER_IMAGES_ONCE_LOAD,  p_object:self)

    }

  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    
    return FSCore.ShareInstance.m_ArrayStory.count
    
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewCell", forIndexPath: indexPath) as! HomeViewCell
    //cell.m_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.row + FSCore.ShareInstance.m_IndexStoryStartDisplayed]
    cell.m_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.row]
    
    return cell
  }
  
}

extension HomeViewController : LayoutDelegate
{
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
      if let l_image = l_Story.m_image
      {
        let image = UIImage(data: l_image)?.decompressedImage
        let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, boundingRect)
        return rect.size.height
        
      }
      else
      {
        //print("Have to retrun default size 400x266")
        let sizeImage = CGSize(width: 400, height: 266)
        let rect = AVMakeRectWithAspectRatioInsideRect(sizeImage, boundingRect)
        return rect.size.height
        
      }
    
      //return (SCREEN_WIDTH / 3 - 8)
  }
  
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      let annotationPadding = CGFloat(15)
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    
      //height title
      let annotationHeaderHeight = l_Story.heightForTitle(font, width: width)
      let height = annotationPadding + annotationHeaderHeight + annotationPadding
    
      return height
  }
  
}


//Text view delegate
extension HomeViewController : UITextFieldDelegate
{
  func textFieldShouldReturn(textField: UITextField) -> Bool
  {
    // 1
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()
    //
    //create code here
    
    //
    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}



