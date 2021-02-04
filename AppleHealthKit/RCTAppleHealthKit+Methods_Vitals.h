#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Vitals)

- (void)vitals_getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getBloodPressureSystolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getBloodPressureDiastolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getInsulinDelivery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getVolume02Max:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_getBasalBodyTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_saveHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_saveBloodPressureSystolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)vitals_saveBloodPressureDiastolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
@end
