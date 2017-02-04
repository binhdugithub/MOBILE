//
//  SecondViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/14/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import AVFoundation

class FavoriteViewController: UICollectionViewController
{
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
      return UIStatusBarStyle.lightContent
    }
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let layout = collectionView?.collectionViewLayout as? FavoriteLayout
        {
          layout.delegate = self
        }
      
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.contentInset = FSDesign.ShareInstance.INSET_COLLECTION
    }
  
    override func viewWillAppear(_ animated: Bool)
    {
      super.viewWillAppear(animated)
      
      self.tabBarController?.tabBar.isHidden = false
      self.navigationController?.isNavigationBarHidden = true

      self.ReloadData()

    }
  
    override func viewDidAppear(_ animated: Bool)
    {
      super.viewDidAppear(animated)

    }
  
    func ReloadData()
    {
      if let layout = collectionView?.collectionViewLayout as? FavoriteLayout
      {
          layout.clearCache()
          self.collectionView!.reloadData()
      }
    }

}

extension FavoriteViewController
{
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    var l_count = 0
    for p_story in FSCore.ShareInstance.m_ArrayStory
    {
      if p_story.m_liked == true
      {
        l_count += 1
      }
    }
    
    return l_count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
 
    cell.m_Story = FSCore.ShareInstance.GetStoryAtIndexFavorite(indexPath.row)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {
    self.performSegue(withIdentifier: "SegueFavorite2Story", sender: indexPath)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any!)
  {
    if segue.identifier == "SegueFavorite2Story"
    {
      let StoryView = segue.destination as! StoryViewController
      let l_index = (sender as! IndexPath).row
      
      StoryView.m_Story = FSCore.ShareInstance.GetStoryAtIndexFavorite(l_index)!
      StoryView.m_IsHomeView = false
    }
  }
  
}

extension FavoriteViewController : LayoutDelegate
{
  // 1
  func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
  {
      
    let l_Story = FSCore.ShareInstance.GetStoryAtIndexFavorite(indexPath.row)!
    let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
   
      let image = UIImage(contentsOfFile: l_Story.m_imageurl!)
      let rect = AVMakeRect(aspectRatio: image!.size, insideRect: boundingRect)
      return rect.size.height
 
  }
  
  // 2
  func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
  {
    let annotationPadding = CGFloat(15)
    let l_Story = FSCore.ShareInstance.GetStoryAtIndexFavorite(indexPath.row)!

    let font = UIFont(name: FSDesign.ShareInstance.FONT_NAMES[1], size: FSDesign.ShareInstance.FONT_CELL_SIZE)!
    
    //height title
    let annotationHeaderHeight = l_Story.heightForTitle(font, width: width)
    let height = annotationPadding + annotationHeaderHeight /*+ commentHeight*/ + annotationPadding
    
    return height
  }
}

