## 穿山甲广告忽略
-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep class com.bytedance.frameworks.** { *; }

-keep class ms.bd.c.Pgl.**{*;}
-keep class com.bytedance.mobsec.metasec.ml.**{*;}

-keep class com.ss.android.**{*;}

-keep class com.bytedance.embedapplog.** {*;}
-keep class com.bytedance.embed_dr.** {*;}

-keep class com.bykv.vk.** {*;}

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn android.app.Activity$TranslucentConversionListener
-dontwarn android.os.SystemProperties
-dontwarn com.bytedance.JProtect
-dontwarn com.bytedance.component.sdk.annotation.AnyThread
-dontwarn com.bytedance.component.sdk.annotation.CallSuper
-dontwarn com.bytedance.component.sdk.annotation.ColorInt
-dontwarn com.bytedance.component.sdk.annotation.DungeonFlag
-dontwarn com.bytedance.component.sdk.annotation.FloatRange
-dontwarn com.bytedance.component.sdk.annotation.HungeonFlag
-dontwarn com.bytedance.component.sdk.annotation.IntRange
-dontwarn com.bytedance.component.sdk.annotation.Keep
-dontwarn com.bytedance.component.sdk.annotation.MainThread
-dontwarn com.bytedance.component.sdk.annotation.RawRes
-dontwarn com.bytedance.component.sdk.annotation.RequiresApi
-dontwarn com.bytedance.component.sdk.annotation.RestrictTo$Scope
-dontwarn com.bytedance.component.sdk.annotation.RestrictTo
-dontwarn com.bytedance.component.sdk.annotation.UiThread
-dontwarn com.bytedance.component.sdk.annotation.WorkerThread
-dontwarn com.bytedance.embed_dr.OaidVivoImpl$Type
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitor$IGetExtendParams
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitor
-dontwarn com.bytedance.framwork.core.sdkmonitor.SDKMonitorUtils
-dontwarn com.bytedance.keva.Keva
-dontwarn com.bytedance.keva.KevaBuilder
-dontwarn com.bytedance.keva.KevaMonitor
-dontwarn com.bytedance.sdk.openadsdk.TTDownloadEventLogger
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.DialogBuilder
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.IDialogStatusChangedListener
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTDownloadAdapter$OnEventLogHandler
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTDownloadVisitor
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTHttpCallback
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.ITTPermissionCallback
-dontwarn com.bytedance.sdk.openadsdk.downloadnew.core.TTDownloadEventModel
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient$Info
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn org.apache.commons.net.ntp.NTPUDPClient
-dontwarn org.apache.commons.net.ntp.NtpV3Packet
-dontwarn org.apache.commons.net.ntp.TimeInfo
-dontwarn org.apache.commons.net.ntp.TimeStamp