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
  var m_CurrentIndex: NSIndexPath?
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle
  {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout
    {
      layout.delegate = self
    }
    
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    
    
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
    //self.navigationController?.navigationBarHidden = true
    m_TxtSearch.hidden = true
    
    if FSCore.ShareInstance.m_LoadedListTitle == false
    {
      self.view.bringSubviewToFront(m_Indicator!)
      m_Indicator!.startAnimating()
    }
    
  }
  
  override func viewDidAppear(animated: Bool)
  {
    //print("Did appear")
    if FSCore.ShareInstance.m_LoadedListTitle == false
    {
      FSCore.ShareInstance.GETListTitle()
      m_Indicator!.stopAnimating()
      
    }
    
    if FSCore.ShareInstance.m_LoadedListImage == false
    {
      FSCore.ShareInstance.GETListImage(self)
    }
    
    self.collectionView!.reloadData()
    
    
    //load to current sotry when pop
    if let l_currentindex = m_CurrentIndex
    {
      
      var indexPaths = [NSIndexPath]()
      
      indexPaths.append(l_currentindex)
     
      self.collectionView?.performBatchUpdates({
        self.collectionView?.reloadItemsAtIndexPaths(indexPaths)
        return })
        {
          completed in

          print("Scroll to current index:\(l_currentindex)")
          self.collectionView?.scrollToItemAtIndexPath(
            l_currentindex,
            atScrollPosition: .CenteredVertically,
            animated: true)
          
      }
    }

    
  }
  
}


extension HomeViewController
{
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    //print("number of items: \(FSCore.ShareInstance.m_ArrayStory.count)")
    return FSCore.ShareInstance.m_ArrayStory.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewCell", forIndexPath: indexPath) as! HomeViewCell
    FSCore.ShareInstance.m_ArrayStory[indexPath.item].m_row = indexPath
    cell.m_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
  {
    self.performSegueWithIdentifier("Segue2Story", sender: indexPath)
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
  {
    if segue.identifier == "Segue2Story"
    {
      let StoryView = segue.destinationViewController as! StoryViewController
      let l_item: NSIndexPath = sender as! NSIndexPath
      StoryView.m_Story = FSCore.ShareInstance.m_ArrayStory[l_item.item]
      StoryView.m_Row = l_item.item
    }
  }
  
}


extension HomeViewController : HomeLayoutDelegate
{
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      //print("heightForPhotoAtIndexPath")
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
      if let l_image = l_Story.m_image
      {
        let image = UIImage(data: l_image)?.decompressedImage
        let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, boundingRect)
        return rect.size.height
        
      }
    
      return 100
  }
  
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      let annotationPadding = CGFloat(4)
      let annotationHeaderHeight = CGFloat(17)
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let font = UIFont(name: "AvenirNext-Regular", size: 10)!
      let commentHeight = l_Story.heightForComment(font, width: width)
      let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
    
      return height
  }
}


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



