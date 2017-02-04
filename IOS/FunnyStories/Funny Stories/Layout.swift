//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by Nguyễn Thế Bình on 12/28/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

protocol LayoutDelegate
{
  // 1
  func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath,
    withWidth:CGFloat) -> CGFloat
  // 2
  func collectionView(_ collectionView: UICollectionView,
    heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class CommonLayout: UICollectionViewLayout
{
  // 1
  var delegate: LayoutDelegate!
  fileprivate var cache = [LayoutAttributes]()
  // 4
  fileprivate var contentHeight: CGFloat  = 0.0
  fileprivate var contentWidth: CGFloat
  {
      let insets = collectionView!.contentInset
      return collectionView!.bounds.width - (insets.left + insets.right)
  }
  
  
  
  override var collectionViewContentSize : CGSize
  {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
  {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache
    {
      if attributes.frame.intersects(rect)
      {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
  
  override class var layoutAttributesClass : AnyClass
  {
    return LayoutAttributes.self
  }
  
  
  func clearCache()
  {
    cache.removeAll(keepingCapacity: false)
  }
}

//
//Home Layout
//

class HomeLayout: CommonLayout
{

  // 2
  var numberOfColumns: Int = FSDesign.ShareInstance.COLLECTION_COLUMN_NUMBER
  var cellPadding: CGFloat = 4.0
  
  // 3

  override func prepare()
  {
    // 1
    if cache.isEmpty
    {
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      //print("content width:\(contentWidth)")
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns
      {
        xOffset.append(CGFloat(column) * columnWidth )
      }
      var column = 0
      var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
      
      // 3
      for item in 0 ..< collectionView!.numberOfItems(inSection: 0)
      {
        
        let indexPath = IndexPath(item: item, section: 0)
        
        // 4
        let width = columnWidth - cellPadding * 2
        
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth:width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding +  photoHeight + annotationHeight + cellPadding
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // 5
        let attributes = LayoutAttributes(forCellWith: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        
        column = column >= (numberOfColumns - 1) ? 0 : (column + 1)
      }
    }
  }


}


//
//Faovrite Layout
//
class FavoriteLayout: CommonLayout
{
  // 2
  var numberOfColumns = FSDesign.ShareInstance.COLLECTION_COLUMN_NUMBER
  var cellPadding: CGFloat = 4.0
  
  override func prepare()
  {
    // 1
    if cache.isEmpty
    {
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns
      {
        xOffset.append(CGFloat(column) * columnWidth )
      }
      var column = 0
      var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
      
      // 3
      for item in 0 ..< collectionView!.numberOfItems(inSection: 0)
      {
        
        let indexPath = IndexPath(item: item, section: 0)
        
        // 4
        let width = columnWidth - cellPadding * 2

        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth:width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding +  photoHeight + annotationHeight + cellPadding
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // 5
        let attributes = LayoutAttributes(forCellWith: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        
        column = column >= (numberOfColumns - 1) ? 0 : (column + 1)
      }
    }
  }
  
 
  
}
