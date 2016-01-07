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
  
  
    var FONT_NAMES  = ["Avenir-Light", "AvenirNext-Regular", "Chalkduster", "Zapfino"]

    //
    var FONT_SIZE_TEXTVIEW: CGFloat = 17
    let FONT_SIZE_TEXTVIEW_DELTA: CGFloat    = 3
    var CELL_FONT_SIZE: CGFloat = 20
    
    var CELL_HEIGHT: CGFloat = 50
    var CELL_MARGIN: CGFloat = 4
  
  
  
  
    var ICON_WIDTH: CGFloat = 30
    var ICON_HEIGTH: CGFloat = 30
    var ICON_VHSPACE: CGFloat = 10
    
    var AD_HEIGHT: CGFloat  = 60
  
    var NAVI_HEIGHT: CGFloat  = 63
  
  
  
    private init()
    {
        if IS_IPHONE_4_OR_LESS
        {
          CELL_HEIGHT = 50
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 20
          
          FONT_SIZE_TEXTVIEW = 17
          
          ICON_WIDTH = 20
          ICON_HEIGTH = ICON_WIDTH
        
          NAVI_HEIGHT = 63
        }
        else if IS_IPAD
        {
          CELL_HEIGHT = 70
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 30
          FONT_SIZE_TEXTVIEW = 25
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
          
          NAVI_HEIGHT = 63
        }
        else if IS_IPHONE_5
        {
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 25
          FONT_SIZE_TEXTVIEW = 20
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
          
          NAVI_HEIGHT = 63
        }
        else if IS_IPHONE_6
        {
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 25
          FONT_SIZE_TEXTVIEW = 20
          
          ICON_WIDTH = 30
        }
        else if IS_IPHONE_6P
        {
          CELL_HEIGHT = 60
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 25
          FONT_SIZE_TEXTVIEW = 25
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
          
          NAVI_HEIGHT = 63
        }
        else
        {
          CELL_HEIGHT = 50
          CELL_MARGIN = 4
          CELL_FONT_SIZE = 20
          FONT_SIZE_TEXTVIEW = 25
          
          ICON_WIDTH = 30
          ICON_HEIGTH = ICON_WIDTH
          
          NAVI_HEIGHT = 63

        }
        
        
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
