//
//  HomeViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class HomeViewController: UICollectionViewController
{
  var m_Indicator: UIActivityIndicatorView?
  
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
    
    
    if Configuration.ShareInstance.m_CurrentImage == -1
    {
        GETImages(-1, p_type: 1)
    }
    else
    {
        GETImages(Configuration.ShareInstance.m_CurrentImage! + 1, p_type: 0)
    }
    
    
    for l_url in Configuration.ShareInstance.m_ArrayLinkFavorite
    {
        let l_story = Story()
        l_story.m_imageurl = l_url as? String
        l_story.m_liked = true
        
        FSCore.ShareInstance.m_ArrayFavorite.append(l_story)
    }
    
    print("Current image:\(Configuration.ShareInstance.m_CurrentImage)")
    
  }
  
  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.hidden = false
    self.navigationController?.navigationBarHidden = true
    
  }
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)
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
    
    
    func GETImages(p_id: Int, p_type: Int) -> Bool
    {
        if (FSCore.ShareInstance.m_IsLoading == true)
        {
            print("Is loading => return")
            return false
        }
        
        
        FSCore.ShareInstance.m_IsLoading = true
        
        let l_url : String =  SERVER_URL + String("/images")
        
        Alamofire.request(.GET, l_url, parameters: ["id_start": "\(p_id)", "limit" : "\(NUMBER_IMAGES_ONCE_LOAD)", "type": "\(p_type)"]).responseJSON()
        {
            p_response in

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
            {
                switch p_response.result
                {
                case .Success(let JSON):
                    //print("Success with JSON: \(JSON)")
                    let JSONResponse = JSON as! NSDictionary
                    let JSONImages = JSONResponse.valueForKey("images")! as! [NSDictionary]
                    var listImages = JSONImages.map{
                        Story(p_id: $0.valueForKey("id") as! Int, p_imageurl: $0.valueForKey("imageurl") as! String)
                    }
                    

                    if listImages.count > 0
                    {
                        for p_story in listImages
                        {
                            p_story.m_liked = false
                            FSCore.ShareInstance.m_ArrayImage.append(p_story)
                            
                            for x_story in FSCore.ShareInstance.m_ArrayFavorite
                            {
                                if x_story.m_imageurl == p_story.m_imageurl
                                {
                                    x_story.m_id = p_story.m_id
                                    p_story.m_liked = true
                                    break
                                }
                                
                            }
                        }
                        
                        FSCore.ShareInstance.m_ArrayImage.sortInPlace({$0.m_id > $1.m_id})
                                                
//                        for var i in 0..<FSCore.ShareInstance.m_ArrayImage.count
//                        {
//                            print(FSCore.ShareInstance.m_ArrayImage[i].m_imageurl)
//                        }
//                        
                        //Configuration.ShareInstance.WriteCurrentImage(FSCore.ShareInstance.m_ArrayImage[0].m_id!)
                        
                        // 10
                        //                    let indexPaths = (lastItem..<FSCore.ShareInstance.m_ArrayStory.count).map{NSIndexPath(forItem: $0, inSection: 0)}
                        //
                        // 11
                        dispatch_async(dispatch_get_main_queue())
                        {
                            self.ReloadData()
                        }
                    }

                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
                
            }//end dispatch_async
            
            FSCore.ShareInstance.m_IsLoading = false
                
        }//end Alamofire.request
        
        return true
    }
  
}

//Collection delegate
extension HomeViewController
{
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    return FSCore.ShareInstance.m_ArrayImage.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewCell", forIndexPath: indexPath) as! HomeViewCell
    
    let l_Story = FSCore.ShareInstance.m_ArrayImage[indexPath.row]
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
            if imageData?.length > 0
            {
                l_Story.m_image = imageData
                cell.m_Story = l_Story
            }
        }
    }
    
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
      StoryView.m_Story = FSCore.ShareInstance.m_ArrayImage[l_item.row]
    }
  }
  
  
  override func scrollViewDidEndDecelerating(scrollView: UIScrollView)
  {
    //print("scrollViewDidEndDecelerating")
    if (scrollView.contentOffset.y < 0)
    {
      //reach top
      print("Here is top")
        if FSCore.ShareInstance.m_ArrayImage.count > 0
        {
            GETImages(FSCore.ShareInstance.m_ArrayImage[0].m_id!, p_type: 1)
        }
    }
    else if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
    {
      //reach bottom
        print("Here is button")
        if FSCore.ShareInstance.m_ArrayImage.count > 0
        {
            GETImages(FSCore.ShareInstance.m_ArrayImage.last!.m_id!, p_type: 0)
        }

    }
    
  }
  
  override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
  {
    print("scrollViewDidEndDragging")
  }
  
  override func scrollViewDidScrollToTop(scrollView: UIScrollView)
  {
    print("scrollViewDidScrollToTop")
  }
  
  override func scrollViewDidScroll(scrollView: UIScrollView)
  {
    if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8
    {
//        print("Load more image")
//        if FSCore.ShareInstance.m_ArrayStory.count > 0
//        {
//            GETImages((FSCore.ShareInstance.m_ArrayStory.lastObject as! Story).m_id!)
//        }
    }
  }
  
  override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
  {
    print("scrollViewDidEndScrollingAnimation")
  }
}


extension HomeViewController : LayoutDelegate
{
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      //return ((SCREEN_WIDTH / 3) - 8)
      let l_Story = FSCore.ShareInstance.m_ArrayImage[indexPath.row]
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
        
        Alamofire.request(.GET, l_imageURL!).response()
        {
            (_,_,imageData,_) in
            
            if imageData?.length > 0
            {
                l_Story.m_image = imageData
                
                if (indexPath.row == (FSCore.ShareInstance.m_ArrayImage.count - 1)) || (indexPath.row == 0)
                {
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.ReloadData()
                    }
                }
                
            }

        }

      }
    
      return (SCREEN_WIDTH / 3)
  }
  
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  {
      //let annotationPadding = CGFloat(5)
      return FSDesign.ShareInstance.HEIGTH_FAVORITE

  }
}


