//
//  PPCore.swift
//  PicturePuzzle
//
//  Created by Nguyen The Binh on 4/17/16.
//  Copyright © 2016 Nguyen The Binh. All rights reserved.
//

import Foundation
import StoreKit


class PPCore
{
    static let ShareInstance = PPCore()
    var m_ArrayPhoto = [Photo]()
    var m_complete_photo = false
    var m_coin: Int!
    var m_level: Int!
    var m_array_indexpath_reload: [NSIndexPath]!
    var m_ArrayApp = [App]()
    
    // TODO:  Change this to the BundleID chosen when registering this app's App ID in the Apple Member Center.
    private static let Prefix = "com.cusiki.picturepuzzleanimal."
    private static let m_buy200coin = Prefix + "200coins"
    private static let m_buy400coin = Prefix + "400coins"
    private static let m_buy600coin = Prefix + "600coins"
    private static let m_buy800coin = Prefix + "800coins"
    private static let productIdentifiers: Set<ProductIdentifier> = [PPCore.m_buy200coin, PPCore.m_buy400coin, PPCore.m_buy600coin,PPCore.m_buy800coin]
    var m_iaphelper = IAPHelper(productIds: PPCore.productIdentifiers)
    var m_products = [SKProduct]()
    
    private init()
    {
        m_array_indexpath_reload = [NSIndexPath]()
    }
    
       
    func DiaplayArray() -> Void
    {
        for p_photo in m_ArrayPhoto
        {
            print("id: \(p_photo.m_id)")
        }
    }
    
}