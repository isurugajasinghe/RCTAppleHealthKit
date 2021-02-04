//
//  RCTAppleHealthKit+Methods_Activity.h
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//
#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Nutrition)

- (void)nutrition_getDietaryEnergyConsumed:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryFatTotal:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryFatSaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryCholesterol:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryCarbohydrates:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryFiber:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietarySugar:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryProtein:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryCalcium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryIron:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryPotassium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryVitaminA:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryVitaminC:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)nutrition_getDietaryVitaminD:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
