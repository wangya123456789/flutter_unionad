package com.gstory.flutter_unionad.drawfeedad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.mediation.MediationConstant
import com.bytedance.sdk.openadsdk.mediation.ad.MediationAdSlot
import com.bytedance.sdk.openadsdk.mediation.ad.MediationExpressRenderListener
import com.bytedance.sdk.openadsdk.mediation.manager.MediationNativeManager
import com.gstory.flutter_unionad.EcpmUtil
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.UIUtils
import com.qq.e.ads.cfg.VideoOption
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 个性化模板draw广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/7 10:31
 */
internal class DrawFeedAdView(
    var context: Context,
    var activity: Activity,
    messenger: BinaryMessenger,
    id: Int,
    params: Map<String?, Any?>
) : PlatformView {
    private val TAG = "DrawFeedAdView"
    private var mDrawFeedAd: TTDrawFeedAd? = null
    private var mContainer: FrameLayout? = null

    //广告所需参数
    private var mCodeId: String?
    var supportDeepLink: Boolean? = true
    var viewWidth: Float
    var viewHeight: Float
    var isMuted: Boolean? = true
    private var channel: MethodChannel?

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["width"] as Double
        var height = params["height"] as Double
        isMuted = params["isMuted"] as Boolean
        viewWidth = width.toFloat()
        viewHeight = height.toFloat()
        mContainer = FrameLayout(activity)
        loadDrawFeedAd()
        channel = MethodChannel(messenger, FlutterunionadViewConfig.drawFeedAdView + "_" + id)
    }

    override fun getView(): View {
        return mContainer!!
    }

    /**
     * 加载广告
     */
    private fun loadDrawFeedAd() {
        val adSlot = AdSlot.Builder()
            .setCodeId(mCodeId) //广告位id
            .setAdCount(1) //请求广告数量为1到3条
            .setMediationAdSlot(
                MediationAdSlot.Builder()
                    .setExtraObject(
                        MediationConstant.KEY_GDT_VIDEO_OPTION,
                        VideoOption.Builder().setAutoPlayMuted(true)
                            .setAutoPlayPolicy(VideoOption.AutoPlayPolicy.ALWAYS)
                            .build()
                    )
                    .setMuted(true)
                    .setVolume(0f)
                    .build()
            )
            .setExpressViewAcceptedSize(
               viewWidth,
               0f
            )
            .build()
        val mTTAdNative = TTAdSdk.getAdManager().createAdNative(activity)
        mTTAdNative.loadDrawFeedAd(adSlot, object : TTAdNative.DrawFeedAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "load error : $code, $message")
                channel?.invokeMethod("onFail", message);
            }

            override fun onDrawFeedAdLoad(ads: MutableList<TTDrawFeedAd>?) {
                if (ads == null || ads.isEmpty()) {
                    channel?.invokeMethod("onFail", "ads is empty")
                    return
                }
                mDrawFeedAd = ads[0]
                showDrawFeedAd()
            }
        })
    }

    /**
     * 展示广告
     */
    private fun showDrawFeedAd() {
        val manager = mDrawFeedAd?.mediationManager
        if (manager != null) {
            if (manager.isExpress) { // --- 模板feed流广告
                bindAdListener()
                mDrawFeedAd?.render(); // 调用render方法进行渲染，在onRenderSuccess中展示广告
            } else {
                Log.e(TAG, "自渲染信息流广告 暂不支持")
                channel?.invokeMethod("onFail", "自渲染信息流广告 暂不支持")
            }
        }
    }

    /**
     * 绑定事件
     */
    private fun bindAdListener() {
        mDrawFeedAd?.setExpressRenderListener(object : MediationExpressRenderListener {
            override fun onRenderSuccess(p0: View?, p1: Float, p2: Float, p3: Boolean) {
                Log.e(TAG, "广告渲染成功")
                mContainer?.removeAllViews()
                mContainer?.addView(mDrawFeedAd?.adView)
                var map: MutableMap<String, Any?> =
                    mutableMapOf("width" to p1, "height" to p2)
                channel?.invokeMethod("onShow", map)
                //获取ecpm·
                var ecpmMap = EcpmUtil.toMap(mDrawFeedAd?.mediationManager?.showEcpm)
                Log.d(TAG, "ecpm: $ecpmMap")
                channel?.invokeMethod("onEcpm", ecpmMap)
            }

            override fun onRenderFail(p0: View?, p1: String?, p2: Int) {
                Log.e(TAG, "广告渲染失败 $p1 $p2")
                channel?.invokeMethod("onFail", p1)
            }

            override fun onAdClick() {
                Log.e(TAG, "广告点击")
                channel?.invokeMethod("onClick", null)
            }

            override fun onAdShow() {
                Log.e(TAG, "广告显示")
            }

        })
    }

    override fun dispose() {
        Log.e(TAG, "广告释放")
        mContainer?.removeAllViews()
        mDrawFeedAd?.destroy()
    }
}