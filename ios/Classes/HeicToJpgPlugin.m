#import "HeicToJpgPlugin.h"
#if __has_include(<heic_to_jpg/heic_to_jpg-Swift.h>)
#import <heic_to_jpg/heic_to_jpg-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "heic_to_jpg-Swift.h"
#endif

@implementation HeicToJpgPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHeicToJpgPlugin registerWithRegistrar:registrar];
}
@end
