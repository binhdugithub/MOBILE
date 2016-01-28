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
  //var m_CurrentIndex: NSIndexPath?
  
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
    
    if FSCore.ShareInstance.m_ArrayStory.count == 0
    {
      FSCore.ShareInstance.GETListStory(0)
      m_Indicator!.stopAnimating()
      
      FSCore.ShareInstance.GETListImage(self)
      FSCore.ShareInstance.GETListAudio(self)
    }
    
    //reload data
    self.ReloadData()
    
  }
  
  func ReloadData()
  {
    if let layout = collectionView?.collectionViewLayout as? HomeLayout
    {
      layout.clearCache()
      self.collectionView!.reloadData()
    }
  }
  
}

//Collection delegate
extension HomeViewController
{
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    return FSCore.ShareInstance.m_ArrayStory.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewCell", forIndexPath: indexPath) as! HomeViewCell
    FSCore.ShareInstance.m_ArrayStory[indexPath.row].m_row = indexPath
    cell.m_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.row]
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
  {
    //highlightCell(indexPath, flag: true)
    self.performSegueWithIdentifier("Segue2Story", sender: indexPath)
  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
  {
        //highlightCell(indexPath, flag: false)
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
    //print("scrollViewDidEndDecelerating")
    if (scrollView.contentOffset.y < 0)
    {
      //reach top
      print("Here is top")
    }
    else if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
    {
      //reach bottom
      print("Here is button")
      self.view.bringSubviewToFront(m_Indicator!)
      m_Indicator!.startAnimating()
      
      FSCore.ShareInstance.GETListStory((FSCore.ShareInstance.m_ArrayStory.last?.m_id)!)
      self.ReloadData()
      
      m_Indicator!.stopAnimating()
      
      FSCore.ShareInstance.GETListImage(self)
      FSCore.ShareInstance.GETListAudio(self)
    }
    
  }
  
  override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
  {
    //print("scrollViewDidEndDragging")
  }
  
  override func scrollViewDidScrollToTop(scrollView: UIScrollView)
  {
    print("scrollViewDidScrollToTop")
  }
  
  override func scrollViewDidScroll(scrollView: UIScrollView)
  {
    //print("scrollViewDidScroll")
  }
  
  override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
  {
    //print("scrollViewDidEndScrollingAnimation")
  }
}


extension HomeViewController : LayoutDelegate
{
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
    
      return ((SCREEN_WIDTH / 3) - 8)
    
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
      if let l_image = l_Story.m_image
      {
        let image = UIImage(data: l_image)?.decompressedImage
        let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, boundingRect)
        return rect.size.height
        
      }
    
      return (SCREEN_WIDTH / 3)
  }
  
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      let annotationPadding = CGFloat(15)
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    
      //height title
      let annotationHeaderHeight = l_Story.heightForTitle(font, width: width)
      //height comment
      //let commentHeight = l_Story.heightForComment(font, width: width)
      //height annotation
      let height = annotationPadding + annotationHeaderHeight /*+ commentHeight*/ + annotationPadding
    
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



