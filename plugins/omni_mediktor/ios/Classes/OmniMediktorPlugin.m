#import "OmniMediktorPlugin.h"
#if __has_include(<omni_mediktor/omni_mediktor-Swift.h>)
#import <omni_mediktor/omni_mediktor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "omni_mediktor-Swift.h"
#endif

@implementation OmniMediktorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOmniMediktorPlugin registerWithRegistrar:registrar];
}
@end
