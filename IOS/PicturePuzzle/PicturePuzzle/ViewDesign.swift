//
//  FSUI.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/22/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import Foundation
import UIKit

let NAME_APP = String("ANIMAL PUZZLE")
class ViewDesign
{
    static let ShareInstance = ViewDesign()
    
//    let COLOR_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
//    let COLOR_HEADER_BG = UIColor(red: 102.0/255, green: 205.0/255, blue: 204.0/255, alpha: 1)
//    let COLOR_SUBHEADER_BG = UIColor(red: 123.0/255, green: 86.0/255, blue: 79.0/255, alpha: 1)
//    let COLOR_FOOTER_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
//    let COLOR_BODY_BG = UIColor(red: 85.0/255, green: 137.0/255, blue: 125.0/255, alpha: 1)
//    let COLOR_COIN_TITLE = UIColor(red: 200.0/255, green: 81.0/255, blue: 2.0/255, alpha: 1)
//    let COLOR_BG_WIN = UIColor.init(red: 65.0/255, green: 65.0/255, blue: 65.0/255, alpha: 0.7)
    
//    let COLOR_BG = UIColor(red: 208/255.0, green: 219/255.0, blue: 203/255.0, alpha: 1)
//    let COLOR_HEADER_BG = UIColor(red: 116/255.0, green: 158/255.0, blue: 170/255.0, alpha: 1)
//    let COLOR_SUBHEADER_BG = UIColor(red: 71/255.0, green: 61/255.0, blue: 72/255.0, alpha: 1)
//    let COLOR_BTN_BG = UIColor(red: 139/255.0, green: 87/255.0, blue: 91/255.0, alpha: 1)
//    let COLOR_BTN_BORDER = UIColor(red: 232/255.0, green: 189/255.0, blue: 196/255.0, alpha: 1)
//    let COLOR_FOOTER_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
//    //let COLOR_BODY_BG = UIColor(red: 85.0/255, green: 137.0/255, blue: 125.0/255, alpha: 1)
//    let COLOR_COIN_TITLE = UIColor(red: 0, green: 118/255.0, blue: 163/255.0, alpha: 1)
//    let COLOR_BG_WIN = UIColor.init(red: 65.0/255, green: 65.0/255, blue: 65.0/255, alpha: 0.7)
//    let COLOR_TEXT_WIN = UIColor(red: 235/255.0, green: 222/255.0, blue: 9/255.0, alpha: 1)
    
    let COLOR_BG = UIColor(red: 31/255.0, green: 37/255.0, blue: 53/255.0, alpha: 1)
    let COLOR_HEADER_BG = UIColor(red: 28/255.0, green: 27/255.0, blue: 32/255.0, alpha: 1)
    let COLOR_SUBHEADER_BG = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    let COLOR_BTN_BG = UIColor(red: 132/255.0, green: 184/255.0, blue: 1/255.0, alpha: 1)
    let COLOR_BTN_MORE_BG = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
    let COLOR_BTN_BORDER = UIColor(red: 70/255.0, green: 101/255.0, blue: 10/255.0, alpha: 1)
    let COLOR_BTN_MORE_BORDER = UIColor(red: 126/255.0, green: 126/255.0, blue: 127/255.0, alpha: 1)
    let COLOR_BTN_TEXT = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
    let COLOR_BTN_MORE_TEXT = UIColor(red: 54/255.0, green: 57/255.0, blue: 70/255.0, alpha: 1)
    let COLOR_FOOTER_BG = UIColor(red: 66.0/255, green: 84.0/255, blue: 83.0/255, alpha: 1)
    let COLOR_TEXT_HEADER = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
    let COLOR_TEXT_COIN = UIColor(red: 133/255.0, green: 148/255.0, blue: 164/255.0, alpha: 1)
    let COLOR_BG_WIN = UIColor.init(red: 65.0/255, green: 65.0/255, blue: 65.0/255, alpha: 0.7)
    let COLOR_TEXT_WIN =  UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
    let COLOR_IMGV_BORDER = UIColor(red: 90/255.0, green: 95/255.0, blue: 102/255.0, alpha: 1)
    
    let COLOR_CELL_BG = UIColor(red: 52/255.0, green: 55/255.0, blue: 72/255.0, alpha: 1)
    
    
    var HEIGHT_ADS: CGFloat  = 60
    var HEIGHT_HEADER: CGFloat = 1.0/13 * SCREEN_HEIGHT
    var HEIGHT_SUBHEADER: CGFloat = 0
    var HEIGHT_BTN_SOCIAL = 1.0/20 * SCREEN_HEIGHT
    var HEIGHT_BTN_START = 1.0/5 * SCREEN_HEIGHT
    var WIDTH_VIEW_PHOTO = 19.0/20 * SCREEN_WIDTH //18.0/20 * SCREEN_WIDTH
    var WIDTH_BTN_NEXT = 1.0/5 * SCREEN_WIDTH
    var WIDTH_PURCHASE = 0.9 * SCREEN_WIDTH
  
    var FONT_NAMES  = ["Avenir-Light", "AvenirNext-Regular","AvenirNext-Bold", "Chalkduster", "Zapfino", "HelveticaNeue-Bold", "Noteworthy-Bold", "Phosphate"]
    var FONT_SIZE_HEADER: CGFloat = 16
    var FONT_SIZE_COIN: CGFloat = 15.0
    var FONT_SIZE_NEXT: CGFloat = 15.0
    
    let FONT_SIZE_TEXTVIEW_DELTA: CGFloat    = 2
    var FONT_SIZE_COPYRIGHT = 15.0
    
  
    let INSET_COLLECTION = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
  
    private init()
    {
        print("width:\(SCREEN_WIDTH) and heigh:\(SCREEN_HEIGHT)")
      
        HEIGHT_SUBHEADER = 1.0/20 * HEIGHT_HEADER
      
        if IS_IPHONE
        {
            if IS_IPHONE_4_OR_LESS
            {
              
                FONT_SIZE_HEADER = 16
                FONT_SIZE_COPYRIGHT = 16
                FONT_SIZE_COIN = 12
              
            }
            else if IS_IPHONE_5
            {
                
                FONT_SIZE_HEADER = 16
                FONT_SIZE_COPYRIGHT = 16
                FONT_SIZE_COIN = 12
        
            }
            else if IS_IPHONE_6
            {

                FONT_SIZE_HEADER = 18
                FONT_SIZE_COPYRIGHT = 17
                FONT_SIZE_COIN = 14
              
            }
            else if IS_IPHONE_6P
            {
              
                FONT_SIZE_HEADER = 20
                FONT_SIZE_COPYRIGHT = 20
                FONT_SIZE_COIN = 16

              
            }
        }
        else if IS_IPAD
        {
            if IS_IPAD_1X
            {
                
               FONT_SIZE_HEADER = 20
               FONT_SIZE_COPYRIGHT = 20
                FONT_SIZE_COIN = 17
                
                
            }
            else if IS_IPAD_2X
            {
                FONT_SIZE_HEADER = 24
                FONT_SIZE_COPYRIGHT = 24
                FONT_SIZE_COIN = 21
                
            }
            else if IS_IPAD_PRO
            {
                
                FONT_SIZE_HEADER = 30
                FONT_SIZE_COPYRIGHT = 30
                FONT_SIZE_COIN = 27
                
            }
            
            WIDTH_VIEW_PHOTO = 16.0/20 * SCREEN_WIDTH
            
        }//end ipad
        else
        {
            FONT_SIZE_HEADER = 30
            FONT_SIZE_COPYRIGHT = 30
            FONT_SIZE_COIN = 27

        }
      
        
        FONT_SIZE_NEXT = FONT_SIZE_COIN
        
        //ads
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
