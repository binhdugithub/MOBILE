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
    var m_coin: Int = 0
    {
        didSet(newValue)
        {
            if self.m_coin <= 0
            {
                self.m_coin = 0
            }
            
        }
        
        
    }
    
    var m_level: Int!
    var m_array_indexpath_reload: [NSIndexPath]!
    var m_ArrayApp = [App]()
    
    // TODO:  Change this to the BundleID chosen when registering this app's App ID in the Apple Member Center.
    private static let Prefix = "com.cusiki.picturepuzzleanimal."
    private static let m_buy200coin = Prefix + "200coins"
    private static let m_buy600coin = Prefix + "600coins"
    private static let m_buy1500coin = Prefix + "1500coins"
    private static let m_buy3500coin = Prefix + "3500coins"
    private static let productIdentifiers: Set<ProductIdentifier> = [PPCore.m_buy200coin, PPCore.m_buy600coin, PPCore.m_buy1500coin,PPCore.m_buy3500coin]
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