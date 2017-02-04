//
//  GADMasterViewController.swift
//  Funny Stories
//
//  Created by Nguyễn Thế Bình on 12/23/15.
//  Copyright © 2015 Nguyễn Thế Bình. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GADMasterViewController: NSObject, GADBannerViewDelegate, GADInterstitialDelegate
{
    static let ShareInstance = GADMasterViewController()
    
    var m_Banner: GADBannerView?
    var m_Interstitial: GADInterstitial?
    var m_IsLoaded: Bool
    
    
    fileprivate override init()
    {
        NSLog("GADMaster:Init")
        m_IsLoaded = false
        super.init()
        self.GETInterstitialAds()
    }

    
    func ResetBannerView(_ p_view: UIViewController?, p_frame: CGRect) -> Bool
    {
        if p_view != nil
        {
            print("GADMaster:resetAdBannerView with frame:%f-%f",p_frame.size.width,p_frame.size.height)
          
            if m_IsLoaded
            {
                m_Banner!.rootViewController = p_view
                p_view!.view.addSubview(m_Banner!)
            }
            else
            {
                m_Banner = GADBannerView()
                m_Banner!.delegate   =   self
                m_Banner!.rootViewController = p_view
                m_Banner!.adUnitID   =   AMOD_BANNER_FOOTER_UNIT
                m_Banner!.load(GADRequest())
                m_Banner!.frame = p_frame
                p_view!.view.addSubview(m_Banner!)
            }
            
            return true
        }
        else
        {
            return false
        }
    }
  
    func ResetBannerView(_ p_view: UIViewController?, p_ads: UIView) -> Bool
    {
      if p_view != nil
      {
        //print("GADMaster:resetAdBannerView with frame:%f-%f",p_frame.size.width,p_frame.size.height)
        
        if m_IsLoaded
        {
          m_Banner!.rootViewController = p_view
          p_ads.addSubview(m_Banner!)
          //p_view!.view.addSubview(m_Banner!)
        }
        else
        {
          m_Banner = GADBannerView()
          m_Banner!.delegate   =   self
          m_Banner!.rootViewController = p_view
          m_Banner!.adUnitID   =   AMOD_BANNER_FOOTER_UNIT
          m_Banner!.load(GADRequest())
          var l_frame = p_ads.frame
          l_frame.origin.x = 0
          l_frame.origin.y = 0
          m_Banner!.frame = l_frame
          p_ads.addSubview(m_Banner!)
        }
        
        return true
      }
      else
      {
        return false
      }
      
    }
    
  
    func GETInterstitialAds()
    {
        NSLog("GADMaster:GetInterstitialAds")
        m_Interstitial = GADInterstitial(adUnitID:AMOD_INTERSTITIAL_UNIT)
        m_Interstitial!.delegate = self
        m_Interstitial!.load(GADRequest())
    }
    
    
    func ResetInterstitialView(_ p_view: UIViewController)
    {
        NSLog("GADMaster:ResetAdInterstitialView")
        if m_Interstitial!.hasBeenUsed
        {
            NSLog("GADMaster:Interstitial has been used")
            
        }
        else
        {
            if m_Interstitial!.isReady
            {
                m_Interstitial!.present(fromRootViewController: p_view)
                
            }
            else
            {
                NSLog("GADInterstitial not ready")
                self.GETInterstitialAds()
                
                sleep(1)
                if m_Interstitial!.isReady
                {
                    m_Interstitial!.present(fromRootViewController: p_view)
                }
                
            }
            
        }
        
    }
    
    //
    // GADelegate
    //
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial!)
    {
        print("GADMaster:WillDismissScreen")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial!)
    {
        print("GADMaster:DidDismissinterstitial")
        self.GETInterstitialAds()
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!)
    {
   
        NSLog("GADMaster:adViewDidReceiveAd")
        bannerView.alpha=0
        UIView.animate(withDuration: 1, animations:
        {
            bannerView.alpha=1
        })
        
        m_IsLoaded = true
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView!)
    {
         NSLog("GADMaster:adViewWillDismissScreen")
    }

    func adViewDidDismissScreen(_ bannerView: GADBannerView!)
    {
        NSLog("GADMaster:adViewDidDismissScreen")
        m_IsLoaded = false
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView!)
    {
        NSLog("adViewWillPresentScreen")
    }
 
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!)
    {
        NSLog(error.localizedFailureReason!)
        print("Rootview: ", m_Banner!.rootViewController)
        
        m_IsLoaded = false
        
        //bannerView.loadRequest(GADRequest())
    }
}
