#import "OmniVideoCallPlugin.h"
#if __has_include(<omni_video_call/omni_video_call-Swift.h>)
#import <omni_video_call/omni_video_call-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "omni_video_call-Swift.h"
#endif

@implementation OmniVideoCallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOmniVideoCallPlugin registerWithRegistrar:registrar];
}
@end
