#import "OmniCorePlugin.h"
#if __has_include(<omni_core/omni_core-Swift.h>)
#import <omni_core/omni_core-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "omni_core-Swift.h"
#endif

@implementation OmniCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOmniCorePlugin registerWithRegistrar:registrar];
}
@end
