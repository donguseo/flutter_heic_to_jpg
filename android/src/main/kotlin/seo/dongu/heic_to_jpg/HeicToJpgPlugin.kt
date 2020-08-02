package seo.dongu.heic_to_jpg

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** HeicToJpgPlugin */
class HeicToJpgPlugin : FlutterPlugin, MethodCallHandler {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "heic_to_jpg")
        channel.setMethodCallHandler(HeicToJpgPlugin());
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        var applicationContext: Context? = null
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "heic_to_jpg")
            channel.setMethodCallHandler(HeicToJpgPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "convert") {
            if (call.hasArgument("heicPath") && !call.argument<String>("heicPath").isNullOrEmpty()) {
                val handler = Handler(Looper.getMainLooper())
                Thread {
                    var jpgPath = call.argument<String>("jpgPath")
                    if(jpgPath.isNullOrEmpty()){
                        jpgPath = "${applicationContext?.cacheDir}/${System.currentTimeMillis()}.jpg"
                    }
                    val output = convertHeicToJpeg(call.argument<String>("heicPath")!!, jpgPath)
                    handler.post {
                        if (output != null) {
                            result.success(output)
                        } else {
                            result.error("error", "output path is null", null)
                        }
                    }
                }.start()
                return
            }
            result.error("illegalArgument", "heicPath is null or Empty.", null)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
