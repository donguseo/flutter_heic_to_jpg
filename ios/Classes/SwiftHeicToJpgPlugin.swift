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
        let dic = call.arguments as! Dictionary<String, Any>
        let heicPath = dic["heicPath"] as! String
        var jpgPath :String?
        if(!(dic["jpgPath"] is NSNull)){
            jpgPath = dic["jpgPath"] as! String?
        }

        if(jpgPath == nil || jpgPath!.isEmpty){
            jpgPath = NSTemporaryDirectory().appendingFormat("%d.jpg", Date().timeIntervalSince1970 * 1000)
        }

        var compressionQuality :Int?
        if(!(dic["compressionQuality"] is NSNull)){
            compressionQuality = dic["compressionQuality"] as! Int?
        }

        if(compressionQuality==nil){
            compressionQuality=100
        }
        result(fromHeicToJpg(heicPath: heicPath, jpgPath: jpgPath!,compressionQuality:compressionQuality!))
    }
  }
    
    func fromHeicToJpg(heicPath: String, jpgPath: String,compressionQuality:Int) -> String? {
        let heicImage : UIImage? = UIImage(named:heicPath)
        if heicImage == nil {
          return nil
        }
        let jpgImageData = heicImage!.jpegData(compressionQuality: CGFloat(compressionQuality/100))
        FileManager.default.createFile(atPath: jpgPath, contents: jpgImageData, attributes: nil)
        return jpgPath
    }
}
