//
//  RCTAppleHealthKit+Methods_Characteristic.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-29.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Sexual)

- (void)category_getSexualActivity:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)category_getIntermenstrualBleeding:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)category_getMenstrualFlow:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)category_getOvulationTestResult:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)category_getCervicalMucusQuality:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
