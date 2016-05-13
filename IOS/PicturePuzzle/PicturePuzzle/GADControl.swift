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
    
    
    private override init()
    {
        NSLog("GADMaster:Init")
        m_IsLoaded = false
        super.init()
        self.GETInterstitialAds()
    }

    
    func ResetBannerView(p_view: UIViewController?, p_frame: CGRect) -> Bool
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
                m_Banner!.loadRequest(GADRequest())
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
  
    func ShowBannerView(p_controller: UIViewController?, p_ads_b: UIView!) -> Bool
    {
      if p_controller != nil && p_ads_b != nil
      {
        if m_IsLoaded
        {
          m_Banner!.rootViewController = p_controller
          p_ads_b.addSubview(m_Banner!)
        }
        else
        {
          m_Banner = GADBannerView()
          m_Banner!.delegate   =   self
          m_Banner!.rootViewController = p_controller
          m_Banner!.adUnitID   =   AMOD_BANNER_FOOTER_UNIT
          m_Banner!.loadRequest(GADRequest())
          var l_frame = p_ads_b.frame
          l_frame.origin.x = 0
          l_frame.origin.y = 0
          m_Banner!.frame = l_frame
          p_ads_b.addSubview(m_Banner!)
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
        m_Interstitial = GADInterstitial(adUnitID:AMOD_INTERSTITIAL_UNIT)
        m_Interstitial!.delegate = self
        m_Interstitial!.loadRequest(GADRequest())
    }
    
    
    func ShowInterstitialView(p_controller: UIViewController?) -> Bool
    {
        NSLog("GADMaster:ResetAdInterstitialView")
        if m_Interstitial!.hasBeenUsed
        {
            NSLog("GADMaster:Interstitial has been used")
            return false
        }
        else
        {
            if m_Interstitial!.isReady
            {
                m_Interstitial!.presentFromRootViewController(p_controller)
            }
            else
            {
                self.GETInterstitialAds()
                sleep(1)
                if m_Interstitial!.isReady
                {
                    m_Interstitial!.presentFromRootViewController(p_controller)
                }
                else
                {
                    print("Please check internet")
                    return false
                }
                
            }
        }
        
        
        return true
    }
    
    //
    // GADelegate
    //
    
    func interstitialWillDismissScreen(ad: GADInterstitial!)
    {
        print("GADMaster:WillDismissScreen")
    }
    
    func interstitialDidDismissScreen(ad: GADInterstitial!)
    {
        print("GADMaster:DidDismissinterstitial")
        self.GETInterstitialAds()
    }
    
    
    func adViewDidReceiveAd(bannerView: GADBannerView!)
    {
   
        NSLog("GADMaster:adViewDidReceiveAd")
        bannerView.alpha=0
        UIView.animateWithDuration(0.5, animations:
        {
            bannerView.alpha=1
        })
        
        m_IsLoaded = true
    }
    
    func adViewWillDismissScreen(bannerView: GADBannerView!)
    {
         NSLog("GADMaster:adViewWillDismissScreen")
    }

    func adViewDidDismissScreen(bannerView: GADBannerView!)
    {
        NSLog("GADMaster:adViewDidDismissScreen")
        m_IsLoaded = false
    }
    
    func adViewWillPresentScreen(bannerView: GADBannerView!)
    {
        NSLog("adViewWillPresentScreen")
    }

    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!)
    {
        NSLog(error.localizedFailureReason!)
        print("Rootview: ", m_Banner!.rootViewController)
        m_IsLoaded = false
    }
}
