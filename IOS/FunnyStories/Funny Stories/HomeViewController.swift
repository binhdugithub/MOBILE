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
    
//    collectionView!.registerClass(HomeViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HomeViewLoadingCellIdentifier)
    
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
    
    
    //load story
    if FSCore.ShareInstance.m_ArrayStory.count == 0
    {
      NetWorkModel.ShareInstance.GETStories(0,p_type: 0, p_object: self, p_limit: NUMBER_IMAGES_ONCE_LOAD, p_thefirst: 0)
    }
    
  }
  
  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.hidden = false
    self.navigationController?.navigationBarHidden = true
  
    m_TxtSearch.hidden = true
    
    if FSCore.ShareInstance.m_ArrayStory.count == 0
    {
      self.view.bringSubviewToFront(m_Indicator!)
      m_Indicator!.startAnimating()
    }

  }
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)

    if m_IsScrolled == false && FSCore.ShareInstance.m_IndexStoryStartDisplayed > 0
    {
      NSThread(target: self, selector: "doSomething:", object: Int(0)).start()
    }

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
    
    if l_row.row <= FSCore.ShareInstance.m_IndexStoryStartDisplayed
    {
      if l_row.row > l_indexParam
      {
        print("Scroll to: \(l_row.row)")
        ScrollToRow(l_row)
        
        NSThread(target: self, selector: "doSomething:", object: Int(l_row.row)).start()
      }
      else if l_row.row < FSCore.ShareInstance.m_IndexStoryStartDisplayed
      {
        //NSThread.sleepForTimeInterval(0.5)
        NSThread(target: self, selector: "doSomething:", object: Int(l_indexParam)).start()
      }
      else
      {
        self.m_IsScrolled = true
      }

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
    
    print("****scrollViewDidEndDecelerating****")
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
      
      NetWorkModel.ShareInstance.GETStories((FSCore.ShareInstance.m_ArrayStory.last?.m_id)!,p_type: 0, p_object:self,p_limit: NUMBER_IMAGES_ONCE_LOAD, p_thefirst: 1)

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



