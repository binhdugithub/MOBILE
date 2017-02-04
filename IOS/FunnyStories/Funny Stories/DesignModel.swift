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

    //
    var FONT_CELL_SIZE: CGFloat = 12
    var FONT_SIZE_TEXTVIEW: CGFloat = 16
    let FONT_SIZE_TEXTVIEW_DELTA: CGFloat    = 2
    var FONT_SIZE_COPYRIGHT = 15.0
    var FONT_SIZE_TITLE: CGFloat = 15.0
  
    
    var CELL_HEIGHT: CGFloat = 50
    var CELL_MARGIN: CGFloat = 4
  
    var TABBAR_HEIGHT: CGFloat = 0
    var NAVIGATOR_HEIGHT: CGFloat = 0
    var STATUSBAR_HEIGHT: CGFloat = 0
  
    var TEXTVIEW_MARGIN: CGFloat = 2
  
    var COLLECTION_COLUMN_NUMBER = 2

  
    var ICON_WIDTH: CGFloat = 30
    var ICON_HEIGTH: CGFloat = 30
    var ICON_VHSPACE: CGFloat = 10
    
    var AD_HEIGHT: CGFloat  = 60
  
    var NAVI_HEIGHT: CGFloat  = 64
  
  
    //var COLOR_COLLECTION_BG = UIColor()
    let COLOR_STORY_TITLE = UIColor(red: 87.0/255, green: 116.0/255, blue: 189.0/255, alpha: 0.9)
    var COLOR_COLLECTION_TEXT = UIColor.black
    var COLOR_TABBAR_BG = UIColor(red: 215.0/255, green: 215.0/255, blue: 215.0/255, alpha: 0.9)
    var COLOR_TABBAR_TINT = UIColor(red: 103.0/255, green: 152.0/255, blue: 5.0/255, alpha: 1)
    var COLOR_CELL_BG = UIColor()
    var COLOR_NAV_HEADER_BG = UIColor(red: 215.0/255, green: 215.0/255, blue: 215.0/255, alpha: 0.9)
    var COLOR_CONTROL_BG =  UIColor(red: 215.0/255, green: 215.0/255, blue: 215.0/255, alpha: 0.9)
    var COLOR_MOREAPP_BG = UIColor(red: 253.0/255, green: 189.0/255, blue: 190.0/255, alpha: 0.9)
    //UIColor(red: 215.0/255, green: 215.0/255, blue: 215.0/255, alpha: 0.9)
    var COLOR_BACKGROUND = UIColor(red: 182.0/255, green: 180.0/255, blue: 180.0/255, alpha: 0.3)
    var COLOR_BODER_BG = UIColor(red: 241.0/255, green: 241.0/255, blue: 241.0/255, alpha: 1)
  
    var COLOR_TEXTVIEW_BG = UIColor()
  
    let INSET_COLLECTION = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
  
    fileprivate init()
    {
        let l_image = UIImage(named: "bg_textview")
        //COLOR_COLLECTION_BG = UIColor(patternImage: l_image!)
        COLOR_CELL_BG = UIColor(patternImage: l_image!)
      
      
        if IS_IPHONE_4_OR_LESS
        {
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 50
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 12
          FONT_SIZE_TEXTVIEW = 16
          FONT_SIZE_COPYRIGHT = 16
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
        
        }
        else if IS_IPHONE_5
        {
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 12
          FONT_SIZE_TEXTVIEW = 17
          FONT_SIZE_COPYRIGHT = 16
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else if IS_IPHONE_6
        {
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 14
          FONT_SIZE_TEXTVIEW = 18
          FONT_SIZE_COPYRIGHT = 17
          
          ICON_WIDTH = 40
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else if IS_IPHONE_6P
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 15
          FONT_SIZE_TEXTVIEW = 20
          FONT_SIZE_COPYRIGHT = 18
          
          ICON_WIDTH = 50
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else if IS_IPAD_1X
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 150
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 15
          FONT_SIZE_TEXTVIEW = 20
          FONT_SIZE_COPYRIGHT = 19
          
          ICON_WIDTH = 45
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else if IS_IPAD_2X
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 20
          FONT_SIZE_TEXTVIEW = 27
          FONT_SIZE_COPYRIGHT = 22
          
          ICON_WIDTH = 60
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else if IS_IPAD_PRO
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 28
          FONT_SIZE_TEXTVIEW = 35
          FONT_SIZE_COPYRIGHT = 28
          
          ICON_WIDTH = 70
          ICON_HEIGTH = ICON_WIDTH
          
        }
        else
        {
          print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
          COLLECTION_COLUMN_NUMBER = 2
          
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          
          FONT_CELL_SIZE = 26
          FONT_SIZE_TEXTVIEW = 30
          FONT_SIZE_COPYRIGHT = 28
          
          ICON_WIDTH = 70
          ICON_HEIGTH = ICON_WIDTH

        }
      
        FONT_SIZE_TITLE = FONT_SIZE_TEXTVIEW
      
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
