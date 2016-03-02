//
//  FSUI.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import Foundation
import UIKit

class FSDesign
{
    static let ShareInstance = FSDesign()
    
    var FONT_NAMES  = ["Avenir-Light", "AvenirNext-Regular","AvenirNext-Bold", "Chalkduster", "Zapfino", "HelveticaNeue-Bold"]
    var FONT_SIZE_COPYRIGHT = 15.0
    var FONT_SIZE_TITLE: CGFloat = 15.0
    
    var CELL_HEIGHT: CGFloat = 50
    var CELL_MARGIN: CGFloat = 4
  
    var COLLECTION_COLUMN_NUMBER = 2

  
    var ICON_WIDTH: CGFloat = 30
    var ICON_HEIGTH: CGFloat = 30
    var ICON_VHSPACE: CGFloat = 10
    
    var AD_HEIGHT: CGFloat  = 60
    var NAVI_HEIGHT: CGFloat  = 64
    
    var HEIGTH_FAVORITE: CGFloat = 56
  
  
    //var COLOR_COLLECTION_BG = UIColor()
    var COLOR_COLLECTION_TEXT = UIColor.blackColor()
    var COLOR_TABBAR_BG = UIColor.whiteColor()//UIColor(red: 76.0/255, green: 113.0/255, blue: 140.0/255, alpha: 0.9)
    var COLOR_TABBAR_TINT = UIColor(red: 88.0/255, green: 144.0/255, blue: 255.0/255, alpha: 0.9)
    var COLOR_CELL_BG = UIColor.whiteColor()
    var COLOR_NAV_HEADER_BG =  UIColor.blackColor()
    
    var COLOR_CONTENT_BG =   UIColor.blackColor()
    var COLOR_CONTROL_BG =   UIColor.blackColor()
    var COLOR_BACKGROUND =  UIColor(red: 76.0/255, green: 113.0/255, blue: 140.0/255, alpha: 0.9)
    var COLOR_TEXTVIEW_BG = UIColor()
  
    let INSET_COLLECTION = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
  
    private init()
    {
      
        if IS_IPHONE_4_OR_LESS
        {
            FONT_SIZE_COPYRIGHT = 16
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 50
          CELL_MARGIN = 4
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
        
          //FAVORITE_HEIGHT = 30
            
          HEIGTH_FAVORITE = 56
        
        }
        else if IS_IPHONE_5
        {
            FONT_SIZE_COPYRIGHT = 16
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else if IS_IPHONE_6
        {
            FONT_SIZE_COPYRIGHT = 17
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          ICON_WIDTH = 40
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else if IS_IPHONE_6P
        {
            FONT_SIZE_COPYRIGHT = 18
          
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          ICON_WIDTH = 50
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else if IS_IPAD_1X
        {
          FONT_SIZE_COPYRIGHT = 19
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 150
          CELL_MARGIN = 4
          
          ICON_WIDTH = 45
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else if IS_IPAD_2X
        {
          FONT_SIZE_COPYRIGHT = 28
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          ICON_WIDTH = 60
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else if IS_IPAD_PRO
        {
          FONT_SIZE_COPYRIGHT = 28
            
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          ICON_WIDTH = 70
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56
          
        }
        else
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 1
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          ICON_WIDTH = 70
          ICON_HEIGTH = ICON_WIDTH
            
          HEIGTH_FAVORITE = 56

        }
        
        //FAVORITE_HEIGHT = ICON_WIDTH
      
        if(SCREEN_HEIGHT <= 400)
        {
            AD_HEIGHT = 32;
        }
        else if (SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
        {
            AD_HEIGHT = 50;
        }
        else if(SCREEN_HEIGHT > 720)
        {
            AD_HEIGHT = 90;
        }

    }
    
}
