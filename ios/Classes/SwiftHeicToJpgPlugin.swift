import Flutter
import UIKit

public class SwiftHeicToJpgPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "heic_to_jpg", binaryMessenger: registrar.messenger())
    let instance = SwiftHeicToJpgPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "convert"){
        let dic = call.arguments as! NSDictionary
        let heicPath = dic["heicPath"] as! String
        let jpegPath = NSTemporaryDirectory().appendingFormat("%d.jpg", Date().timeIntervalSince1970 * 1000)
        result(fromHeicToJpg(heicPath: heicPath, jpgPath: jpegPath))
    }
  }
    
    func fromHeicToJpg(heicPath: String, jpgPath: String) -> String? {
        let heicImage = UIImage(named:heicPath)
        let jpgImageData = heicImage!.jpegData(compressionQuality: 1.0)
        FileManager.default.createFile(atPath: jpgPath, contents: jpgImageData, attributes: nil)
        return jpgPath
    }
}
