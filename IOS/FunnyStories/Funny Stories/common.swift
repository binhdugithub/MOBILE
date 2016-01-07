//
//  TestDefine.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/15/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import Foundation
import UIKit

let YOUR_APP_ID: String             = "1070241747"
let AMOD_BANNER_FOOTER_UNIT :String = "ca-app-pub-2735696870763171/5172236840"
let AMOD_INTERSTITIAL_UNIT :String  = "ca-app-pub-2735696870763171/6648970044"

let FILECONFIG:String = "/data.plist"
let TEXT_COPYRIGHT:String = "CUSIKI @2015"

let IS_IPAD:Bool               =     (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
let IS_IPHONE: Bool            =     (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
let IS_RETINA: Bool            =     (UIScreen.mainScreen().scale >= 2.0)

let SCREEN_WIDTH:CGFloat       =     UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:CGFloat      =     UIScreen.mainScreen().bounds.size.height
let SCREEN_MAX_LENGTH:CGFloat  =     max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH:CGFloat  =     min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS:Bool   =     (IS_IPHONE && (SCREEN_MAX_LENGTH < 568.0))
let IS_IPHONE_5:Bool           =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 568.0))
let IS_IPHONE_6:Bool           =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 667.0))
let IS_IPHONE_6P:Bool          =     (IS_IPHONE && (SCREEN_MAX_LENGTH == 736.0))

let VERSION: String            =     (UIDevice.currentDevice().systemVersion)

