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
  
  
  override var preferredStatusBarStyle : UIStatusBarStyle
  {
    return UIStatusBarStyle.lightContent
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    if let layout = collectionView?.collectionViewLayout as? HomeLayout
    {
      layout.delegate = self
    }
    
    collectionView!.backgroundColor = UIColor.clear
    collectionView!.contentInset = FSDesign.ShareInstance.INSET_COLLECTION
    
    
    var l_rect = CGRect(x: 0, y: 0, width: 0, height: 0)
    l_rect.size.width = 1.0/5 * SCREEN_WIDTH
    l_rect.size.height = l_rect.size.width
    l_rect.origin.x = 0.5 * (SCREEN_WIDTH - l_rect.size.width)
    l_rect.origin.y  = 0.5 * (SCREEN_HEIGHT - l_rect.size.height)
    m_Indicator = UIActivityIndicatorView(frame: l_rect)
    m_Indicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    self.view.addSubview(m_Indicator!)
    
    FSCore.ShareInstance.m_IndexStoryStartDisplayed =  FSCore.ShareInstance.m_IndexStoryStartDisplayed > (FSCore.ShareInstance.m_ArrayStory.count - 1) ? FSCore.ShareInstance.m_ArrayStory.count - 1 : FSCore.ShareInstance.m_IndexStoryStartDisplayed
    
  
    
    FSDesign.ShareInstance.NAVIGATOR_HEIGHT = (self.navigationController?.navigationBar.bounds.size.height)!
    FSDesign.ShareInstance.STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
    
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.isHidden = false
    self.navigationController?.isNavigationBarHidden = true
  
    m_TxtSearch.isHidden = true

  }
  
  override func viewDidAppear(_ animated: Bool)
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
  
  func doSomething(_ p_param: AnyObject)
  {
    let l_indexParam = p_param as! Int
    //print("scrool to: \(l_indexParam)")
    
    let l_array = self.collectionView?.indexPathsForVisibleItems
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
        
        Thread(target: self, selector: #selector(HomeViewController.doSomething(_:)), object: Int(l_row.row)).start()
      }
      else if l_row.row < FSCore.ShareInstance.m_IndexStoryStartDisplayed
      {
        //NSThread.sleepForTimeInterval(0.5)
        Thread(target: self, selector: #selector(HomeViewController.doSomething(_:)), object: Int(l_indexParam)).start()
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
  
  func ScrollToRow(_ p_row: IndexPath)
  {
 
    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async
    {
        DispatchQueue.main.async
        {
          self.collectionView?.layoutIfNeeded()
          self.collectionView?.scrollToItem(at: p_row, at: .top, animated: false)
        }
    }
    
  }
  
  
  func ReloadData()
  {
    if let layout = collectionView?.collectionViewLayout as? HomeLayout
    {
      if Thread.isMainThread
      {
        layout.clearCache()
        self.collectionView!.reloadData()
        if (self.m_Indicator!.isAnimating)
        {
          self.m_Indicator!.stopAnimating()
        }
      }
      else
      {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async
          {
          // do your task
          
          DispatchQueue.main.async
          {
              layout.clearCache()
              self.collectionView!.reloadData()
            if (self.m_Indicator!.isAnimating)
            {
              self.m_Indicator!.stopAnimating()
            }
          }
        }
        
      }
      
    }
  }
  
  
  func ShowToast(_ p_title: String)
  {
    var l_frm = CGRect(x: 0, y: 0, width: 0, height: 0)
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
    toastLabel.backgroundColor = UIColor.black
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = NSTextAlignment.center;
    self.view.addSubview(toastLabel)
    toastLabel.text = p_title
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            toastLabel.removeFromSuperview()
            })

    
  }
  
}

//Collection delegate
extension HomeViewController
{

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {
    //highlightCell(indexPath, flag: true)
    self.performSegue(withIdentifier: "Segue2Story", sender: indexPath)
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any!)
  {
    if segue.identifier == "Segue2Story"
    {
      let StoryView = segue.destination as! StoryViewController
      let l_item: IndexPath = sender as! IndexPath
      StoryView.m_Story = FSCore.ShareInstance.m_ArrayStory[l_item.row]
      StoryView.m_IsHomeView = true
    }
  }
  
  
  func highlightCell(_ indexPath : IndexPath, flag: Bool)
  {
    
    let cell = collectionView!.cellForItem(at: indexPath)
    
    if flag
    {
      cell?.contentView.backgroundColor = UIColor.magenta
    }
    else
    {
      cell?.contentView.backgroundColor = nil
    }
  }
  
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
  {
    
   // print("****scrollViewDidEndDecelerating****")
    
//    
//    let l_visibles: [NSIndexPath] = (collectionView?.indexPathsForVisibleItems())!
//    
//    var l_row = l_visibles[0].row
//    for l_indexpath in l_visibles
//    {
//      if l_indexpath.row < l_row
//      {
//        l_row = l_indexpath.row
//      }
//    }
//    
//    Configuration.ShareInstance.m_CurrentStory = l_row
//    
//    
//    if (scrollView.contentOffset.y < 0)
//    {
//
//    }
//    else if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
//    {
//
//      var l_frame = m_Indicator?.frame;
//      l_frame?.origin.y = SCREEN_HEIGHT - 49 - ((l_frame?.size.height)! / 2.0)
//      m_Indicator?.frame = l_frame!;
//      self.view.bringSubviewToFront(m_Indicator!)
//      m_Indicator!.startAnimating()
//
//    }

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    
    return FSCore.ShareInstance.m_ArrayStory.count
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
    cell.m_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.row]
    
    return cell
  }
  
}

extension HomeViewController : LayoutDelegate
{
  // 1
  func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
  {
      let l_Story = FSCore.ShareInstance.m_ArrayStory[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    
      if let image = UIImage(contentsOfFile: l_Story.m_imageurl!)
      {
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
      }
    
      return 0
  }
  
  // 2
  func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
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
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    // 1
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
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



