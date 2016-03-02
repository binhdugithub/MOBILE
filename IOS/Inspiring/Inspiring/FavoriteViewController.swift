//
//  SecondViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/14/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class FavoriteViewController: UICollectionViewController
{
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
      return UIStatusBarStyle.LightContent
    }
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let layout = collectionView?.collectionViewLayout as? FavoriteLayout
        {
          layout.delegate = self
        }
      
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = FSDesign.ShareInstance.INSET_COLLECTION
    }
  
    override func viewWillAppear(animated: Bool)
    {
      super.viewWillAppear(animated)
      
      self.tabBarController?.tabBar.hidden = false
      self.navigationController?.navigationBarHidden = true
      
      self.ReloadData()
      
    }
  
    override func viewDidAppear(animated: Bool)
    {
      super.viewDidAppear(animated)

    }
  
    func ReloadData()
    {
     if let layout = collectionView?.collectionViewLayout as? FavoriteLayout
      {
        layout.clearCache()
        self.collectionView?.reloadData()
      }
      
    }

}



extension FavoriteViewController
{
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    //print("Item count: \(FSCore.ShareInstance.m_ArrayFavorite.count)")
    return FSCore.ShareInstance.m_ArrayFavorite.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FavoriteViewCell", forIndexPath: indexPath) as! FavoriteViewCell
    
    let l_Story = FSCore.ShareInstance.m_ArrayFavorite[indexPath.row]
    if let _ = l_Story.m_image
    {
        cell.m_Story = l_Story
    }
    else
    {
        let l_imageURL = l_Story.m_imageurl
        
        Alamofire.request(.GET, l_imageURL!).response()
        {
            (_,_,imageData,_) in
            
            //let l_image = UIImage(data: imageData!)
            l_Story.m_image = imageData
            
            cell.m_Story = l_Story
        }
    }

    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
  {
    self.performSegueWithIdentifier("SegueFavorite2Story", sender: indexPath)
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
  {
    if segue.identifier == "SegueFavorite2Story"
    {
      let StoryView = segue.destinationViewController as! StoryViewController
      let l_item: NSIndexPath = sender as! NSIndexPath
      StoryView.m_Story = FSCore.ShareInstance.m_ArrayFavorite[l_item.item]
    }
  }
  
}

extension FavoriteViewController : LayoutDelegate
{
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
    let l_Story = FSCore.ShareInstance.m_ArrayFavorite[indexPath.row]
    let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    if let l_image = l_Story.m_image
    {
        let image = UIImage(data: l_image)?.decompressedImage
        let rect = AVMakeRectWithAspectRatioInsideRect(image!.size, boundingRect)
        return rect.size.height
    }
    else
    {
        let l_imageURL = l_Story.m_imageurl
        print("Favorite request:\(l_imageURL)")
        Alamofire.request(.GET, l_imageURL!).response()
        {
            (_,_,imageData,_) in
            l_Story.m_image = imageData
            
            dispatch_async(dispatch_get_main_queue())
            {
                self.ReloadData()
            }
                
        }
        
    }
    
    return (SCREEN_WIDTH / 3)
  }
  
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
    return FSDesign.ShareInstance.HEIGTH_FAVORITE
  }
}

