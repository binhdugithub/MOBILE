//
//  FSUI.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import Foundation
import UIKit

class ViewDesign
{
    static let ShareInstance = ViewDesign()
    var HEIGHT_ADS: CGFloat  = 60
    var HEIGHT_HEADER: CGFloat = 1.0/14 * SCREEN_HEIGHT
    var HEIGHT_SUBHEADER: CGFloat = 0
    var HEIGHT_BTN_SOCIAL = 1.0/16 * SCREEN_HEIGHT
    var HEIGHT_BTN_START = 1.0/5 * SCREEN_HEIGHT
    
    var WIDTH_VIEW_PHOTO = 18.0/20 * SCREEN_WIDTH
    
    let COLOR_BG = UIColor(red: 85.0/255, green: 137.0/255, blue: 125.0/255, alpha: 1)
    let COLOR_HEADER_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
    let COLOR_SUBHEADER_BG = UIColor(red: 123.0/255, green: 86.0/255, blue: 79.0/255, alpha: 1)
    let COLOR_FOOTER_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
    let COLOR_BODY_BG = UIColor(red: 85.0/255, green: 137.0/255, blue: 125.0/255, alpha: 1)
  
    var FONT_NAMES  = ["Avenir-Light", "AvenirNext-Regular","AvenirNext-Bold", "Chalkduster", "Zapfino", "HelveticaNeue-Bold"]

    //
    var FONT_CELL_SIZE: CGFloat = 12
    var FONT_SIZE_TEXTVIEW: CGFloat = 16
    let FONT_SIZE_TEXTVIEW_DELTA: CGFloat    = 2
    var FONT_SIZE_COPYRIGHT = 15.0
    var FONT_SIZE_TITLE: CGFloat = 15.0
  
    let INSET_COLLECTION = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
  
    private init()
    {
        print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
        
//        let l_image = UIImage(named: "bg_textview")
//        //COLOR_COLLECTION_BG = UIColor(patternImage: l_image!)
//        COLOR_CELL_BG = UIColor(patternImage: l_image!)
      
        HEIGHT_SUBHEADER = 1.0/10 * HEIGHT_HEADER
      
        if IS_IPHONE_4_OR_LESS
        {
          
          FONT_CELL_SIZE = 12
          FONT_SIZE_TEXTVIEW = 16
          FONT_SIZE_COPYRIGHT = 16
          
        }
        else if IS_IPHONE_5
        {
            
            FONT_CELL_SIZE = 12
          FONT_SIZE_TEXTVIEW = 17
          FONT_SIZE_COPYRIGHT = 16
    
        }
        else if IS_IPHONE_6
        {
4
          FONT_SIZE_TEXTVIEW = 18
          FONT_SIZE_COPYRIGHT = 17

          
        }
        else if IS_IPHONE_6P
        {
          
          FONT_CELL_SIZE = 15
          FONT_SIZE_TEXTVIEW = 20
          FONT_SIZE_COPYRIGHT = 18

          
        }
        else if IS_IPAD_1X
        {

          FONT_CELL_SIZE = 15
          FONT_SIZE_TEXTVIEW = 20
          FONT_SIZE_COPYRIGHT = 19

          
        }
        else if IS_IPAD_2X
        {
          FONT_CELL_SIZE = 20
          FONT_SIZE_TEXTVIEW = 27
          FONT_SIZE_COPYRIGHT = 22

        }
        else if IS_IPAD_PRO
        {
          
          FONT_CELL_SIZE = 28
          FONT_SIZE_TEXTVIEW = 35
          FONT_SIZE_COPYRIGHT = 28
          
        }
        else
        {
          FONT_CELL_SIZE = 26
          FONT_SIZE_TEXTVIEW = 30
          FONT_SIZE_COPYRIGHT = 28

        }
      
        FONT_SIZE_TITLE = FONT_SIZE_TEXTVIEW
      
        if(SCREEN_HEIGHT <= 400)
        {
            HEIGHT_ADS = 32;
        }
        else if (SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
        {
            HEIGHT_ADS = 50;
        }
        else if(SCREEN_HEIGHT > 720)
        {
            HEIGHT_ADS = 90;
        }
        
       

    }
    
}
