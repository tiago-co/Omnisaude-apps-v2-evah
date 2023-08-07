#import "OmniMeasurementPlugin.h"
#if __has_include(<omni_measurement/omni_measurement-Swift.h>)
#import <omni_measurement/omni_measurement-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "omni_measurement-Swift.h"
#endif

@implementation OmniMeasurementPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOmniMeasurementPlugin registerWithRegistrar:registrar];
}
@end
