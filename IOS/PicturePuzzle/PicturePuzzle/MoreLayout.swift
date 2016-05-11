//
//  BHPhotoAlbumLayout.swift
//  MyCollectionLayout
//
//  Created by Nguyen The Binh on 4/6/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import UIKit

let KeyMoreCellKind = "MoreCell"

class MoreLayout: UICollectionViewLayout
{
    
    var m_itemInsets: UIEdgeInsets! = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        {
        willSet(newValue)
        {
            if m_itemInsets != newValue
            {
                self.m_itemInsets = newValue
                invalidateLayout()
            }
        }
    }
    
    var m_itemSize: CGSize! = CGSize(width: 0.0, height: 0.0)
        {
        willSet(newValue)
        {
            if m_itemSize != newValue
            {
                self.m_itemSize = newValue
                invalidateLayout()
            }
        }
        
    }
    
    var m_interItemSpacingY: CGFloat = 0.0
        {
        willSet(newValue)
        {
            if m_interItemSpacingY != newValue
            {
                self.m_interItemSpacingY = newValue
                invalidateLayout()
            }
        }
    }
    
    var m_interItemSpacingX: CGFloat! = 0.0
        {
        willSet(newValue)
        {
            if m_interItemSpacingX != newValue
            {
                self.m_interItemSpacingX = newValue
                invalidateLayout()
            }
        }
    }
    
    var m_numberOfColumns: NSInteger! = 0
        {
        
        willSet(newValue)
        {
            if m_numberOfColumns != newValue
            {
                self.m_numberOfColumns = newValue
                invalidateLayout()
            }
        }
        
    }
    
    
    var m_layoutInfo: [String: [NSIndexPath: UICollectionViewLayoutAttributes]]!
    var m_rotations: [NSValue]! = [NSValue]()
    
    override init() {
        super.init()
        self.SetupView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init()
        self.SetupView()
    }
    
    func SetupView() -> Void
    {
        let l_top = 1.0/25 * SCREEN_WIDTH
        let l_left = l_top
        let l_bottom = l_top
        let l_right = l_top
        self.m_itemInsets = UIEdgeInsetsMake(l_top, l_left, l_bottom, l_right)
        self.m_interItemSpacingY = l_top
        self.m_interItemSpacingX = 2 * self.m_interItemSpacingY
        self.m_numberOfColumns = 2
        self.m_itemSize = CGSizeMake(0.0, 0.0);
        self.m_layoutInfo = [String: [NSIndexPath: UICollectionViewLayoutAttributes]]()
    }
    
    
    override func prepareLayout()
    {
        //calculate size of cell
        var l_width:CGFloat = (self.collectionView!.bounds.width)
            - self.m_itemInsets.left * 2
            - (CGFloat(self.m_numberOfColumns) - 1.0) * self.m_interItemSpacingX
        l_width = l_width / CGFloat(self.m_numberOfColumns)
        let l_height = 1.3 * l_width
        
        self.m_itemSize = CGSizeMake(l_width, l_height);
        //print("Size item: \(self.m_itemSize)")
        
        
        //start calculate all cell
        var l_newLayoutInfo = [String: [NSIndexPath: UICollectionViewLayoutAttributes]]()
        var l_cellLayoutInfo = [NSIndexPath: UICollectionViewLayoutAttributes]()
        
        let sectionCount = self.collectionView?.numberOfSections()
        var l_indexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        
        for p_section: NSInteger in 0..<sectionCount!
        {
            let l_itemCount = self.collectionView?.numberOfItemsInSection(p_section)
            
            for p_item: NSInteger in 0..<l_itemCount!
            {
                l_indexPath = NSIndexPath(forItem: p_item, inSection: p_section)
                let l_itemAttributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: l_indexPath)
                l_itemAttributes.frame = self.frameForPhotoAtIndexPath(l_indexPath)
                
                //add to celllayout
                l_cellLayoutInfo[l_indexPath] = l_itemAttributes
            }
        }
        
        //khong hieu
        l_newLayoutInfo[KeyPhotoCellKind] = l_cellLayoutInfo
        
        self.m_layoutInfo = l_newLayoutInfo
    }
    
    
    //
    //Func for calculate View
    //
    func frameForPhotoAtIndexPath(p_indexPath: NSIndexPath) -> CGRect
    {
        let row: NSInteger = p_indexPath.item / self.m_numberOfColumns;
        let column: NSInteger = p_indexPath.item % self.m_numberOfColumns;
        
        var spacingX: CGFloat = self.collectionView!.bounds.size.width - self.m_itemInsets.left - self.m_itemInsets.right - (CGFloat(self.m_numberOfColumns) * self.m_itemSize.width);
        
        if (self.m_numberOfColumns > 1)
        {
            spacingX = spacingX / CGFloat(self.m_numberOfColumns - 1);
        }
        
        let originX: CGFloat = CGFloat(floorf(Float(self.m_itemInsets.left) + Float(self.m_itemSize.width + spacingX) * Float(column)))
        let originY: CGFloat = CGFloat(floor(self.m_itemInsets.top + (self.m_itemSize.height + self.m_interItemSpacingY) * CGFloat(row) ));
        
        return CGRectMake(originX, originY, self.m_itemSize.width, self.m_itemSize.height);
    }
    
    
    //
    //pragma- mark UICollectionViewLayout Delegate
    //
    override func collectionViewContentSize() -> CGSize
    {
        
        var rowCount: NSInteger = (self.collectionView?.numberOfItemsInSection(0))! / self.m_numberOfColumns
        if ((self.collectionView?.numberOfItemsInSection(0))! % (self.m_numberOfColumns) != 0)
        {
            rowCount = rowCount + 1
        }
        
        let l_heigth: CGFloat = self.m_itemInsets.top
            + (CGFloat(rowCount) * self.m_itemSize.height)
            + (CGFloat(rowCount - 1) * self.m_interItemSpacingY)
            + CGFloat(self.m_itemInsets.bottom)
        
        let l_size: CGSize = CGSizeMake((self.collectionView?.bounds.size.width)!, l_heigth)
        
        //print("collectionViewContentSize: \(l_size)")
        return l_size
        
    }
    
    override func layoutAttributesForElementsInRect(p_rect: CGRect) -> [UICollectionViewLayoutAttributes]
    {
        
        var l_allAttributes = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in self.m_layoutInfo[KeyPhotoCellKind]!
        {
            if CGRectIntersectsRect(p_rect, attributes.frame)
            {
                l_allAttributes.append(attributes)
            }
        }
        
        return l_allAttributes;
    }
    
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        return self.m_layoutInfo[KeyPhotoCellKind]![indexPath]
    }
    
}
