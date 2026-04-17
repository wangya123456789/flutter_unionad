//banner广告
//  BannerExpressAdView.swift
//  flutter_unionad
// 个性化模板Banner广告
//  Created by gstory0404@gmail on 2020/9/4.
//
import Foundation
import BUAdSDK
import Flutter

public class BannerAdView : NSObject,FlutterPlatformView{
    private let container : ADContainerView
    private var bannerAdView : BUNativeExpressBannerView?
    private var channel : FlutterMethodChannel?
    var frame: CGRect;
    //广告需要的参数
    var mCodeId :String?
    var viewWidth : Float?
    var viewHeight :Float?
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = ADContainerView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.viewWidth = Float(dict.value(forKey: "width") as! Double)
        self.viewHeight = Float(dict.value(forKey: "height") as! Double)
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.bannerAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadBannerAd()
    }
    
    public func view() -> UIView {
        return self.container
    }
    
    private func loadBannerAd(){
        let width:CGFloat = CGFloat(self.viewWidth!)
        let heigh:CGFloat = CGFloat(self.viewHeight!)
        let size = CGSize(width: width, height: heigh)
        self.bannerAdView = BUNativeExpressBannerView.init(slotID: self.mCodeId!, rootViewController: MyUtils.getVC(), adSize: size)
        self.bannerAdView!.delegate = self
        self.bannerAdView!.frame = CGRect(x: 0, y: 0, width: width, height: heigh)
        self.bannerAdView!.center = CGPoint(x: width / 2, y: heigh / 2)
        self.bannerAdView!.loadAdData()
    }
    
    private func disposeView() {
        self.container.removeFromSuperview()
    }
    
    deinit {
        container.removeFromSuperview()
    }
}

extension BannerAdView: BUNativeExpressBannerViewDelegate {
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner加载成功")
        self.container.addSubview(bannerAdView)
    }

    public func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        LogUtil.logInstance.printLog(message:error)
        self.channel?.invokeMethod("onFail", arguments:error?.localizedDescription)
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message:error)
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        LogUtil.logInstance.printLog(message:"点击了不感兴趣")
        if(filterwords != nil && !filterwords!.isEmpty){
            self.channel?.invokeMethod("onDislike", arguments: filterwords?[0].name)
        }else{
            self.channel?.invokeMethod("onDislike", arguments: "")
        }
        self.disposeView()
    }
    
    public func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner渲染成功")
        let map : NSDictionary = ["width":bannerAdView.frame.size.width,
                                  "height":bannerAdView.frame.size.height]
        self.channel?.invokeMethod("onShow", arguments: map)
        let ecpmInfo : BUMRitInfo? = bannerAdView.mediation?.getShowEcpmInfo();
        LogUtil.logInstance.printLog(message:"ecpm获取成功：\(ecpmInfo?.toDictionary())");
        self.channel?.invokeMethod("onEcpm", arguments: ecpmInfo?.toDictionary())
    }
    
    public func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner点击了")
        self.channel?.invokeMethod("onClick", arguments: "")
    }
    
    public func nativeExpressBannerAdViewDidRemoved(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner移除了")
        self.disposeView()
    }
}
