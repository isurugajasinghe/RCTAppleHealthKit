//
//  RCTAppleHealthKit+Methods_Characteristic.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-29.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Characteristic.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Characteristic)


- (void)characteristic_getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKBiologicalSexObject *bioSex = [self.healthStore biologicalSexWithError:&error];
    NSString *value;

    switch (bioSex.biologicalSex) {
        case HKBiologicalSexNotSet:
            value = @"unknown";
            break;
        case HKBiologicalSexFemale:
            value = @"female";
            break;
        case HKBiologicalSexMale:
            value = @"male";
            break;
        case HKBiologicalSexOther:
            value = @"other";
            break;
    }

    if(value == nil){
        NSLog(@"error getting biological sex: %@", error);
        callback(@[RCTMakeError(@"error getting biological sex", error, nil)]);
        return;
    }

    NSDictionary *response = @{
            @"value" : value,
    };

    callback(@[[NSNull null], response]);
}


- (void)characteristic_getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    NSDate *dob = [self.healthStore dateOfBirthWithError:&error];

    if(error != nil){
        NSLog(@"error getting date of birth: %@", error);
        callback(@[RCTMakeError(@"error getting date of birth", error, nil)]);
        return;
    }
    if(dob == nil) {
        NSDictionary *response = @{
                                   @"value" : [NSNull null],
                                   @"age" : [NSNull null]
                                   };
        callback(@[[NSNull null], response]);
        return;
    }

    NSString *dobString = [RCTAppleHealthKit buildISO8601StringFromDate:dob];

    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dob toDate:now options:NSCalendarWrapComponents];
    NSUInteger ageInYears = ageComponents.year;

    NSDictionary *response = @{
            @"value" : dobString,
            @"age" : @(ageInYears),
    };

    callback(@[[NSNull null], response]);
}

- (void)characteristic_getBloodType:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKBloodTypeObject *bloodType = [self.healthStore bloodTypeWithError:&error];
    NSString *value;
    
    switch (bloodType.bloodType) {
        case HKBloodTypeNotSet:
            value = @"unknown";
            break;
        case HKBloodTypeAPositive:
            value = @"A+";
            break;
        case HKBloodTypeANegative:
            value = @"A-";
            break;
        case HKBloodTypeBPositive:
            value = @"B+";
            break;
        case HKBloodTypeBNegative:
            value = @"B-";
            break;
        case HKBloodTypeABPositive:
            value = @"AB+";
            break;
        case HKBloodTypeABNegative:
            value = @"AB-";
            break;
        case HKBloodTypeOPositive:
            value = @"O+";
            break;
        case HKBloodTypeONegative:
            value = @"O-";
            break;
    }
    
    if(value == nil){
        NSLog(@"error getting blood type sex: %@", error);
        callback(@[RCTMakeError(@"error getting blood type", error, nil)]);
        return;
    }
    
    NSDictionary *response = @{
                               @"value" : value,
                               };
    
    callback(@[[NSNull null], response]);
}

- (void)characteristic_getFitzpatrickSkin:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKFitzpatrickSkinTypeObject *fitzpatrickSkinType = [self.healthStore fitzpatrickSkinTypeWithError:&error];
    NSString *value;
    
    switch (fitzpatrickSkinType.skinType) {
        case HKFitzpatrickSkinTypeNotSet:
            value = @"unknown";
            break;
        case HKFitzpatrickSkinTypeI:
            value = @"TypeI";
            break;
        case HKFitzpatrickSkinTypeII:
            value = @"TypeII";
            break;
        case HKFitzpatrickSkinTypeIII:
            value = @"TypeIII";
            break;
        case HKFitzpatrickSkinTypeIV:
            value = @"TypeIV";
            break;
        case HKFitzpatrickSkinTypeV:
            value = @"TypeV";
            break;
        case HKFitzpatrickSkinTypeVI:
            value = @"TypeVI";
            break;
    }
    
    if(value == nil){
        NSLog(@"error getting fitzpatrickSkinType: %@", error);
        callback(@[RCTMakeError(@"error getting fitzpatrickSkinType", error, nil)]);
        return;
    }
    
    NSDictionary *response = @{
                               @"value" : value,
                               };
    
    callback(@[[NSNull null], response]);
}

- (void)characteristic_getWheelchairUse:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKWheelchairUseObject *wheelchairUse = [self.healthStore wheelchairUseWithError:&error];
    NSString *value;
    
    switch (wheelchairUse.wheelchairUse) {
        case HKWheelchairUseNo:
            value = @"No";
            break;
        case HKWheelchairUseYes:
            value = @"Yes";
            break;
        case HKWheelchairUseNotSet:
            value = @"unknown";
            break;
    }
    
    if(value == nil){
        NSLog(@"error getting wheelchairUse: %@", error);
        callback(@[RCTMakeError(@"error getting wheelchairUse", error, nil)]);
        return;
    }
    
    NSDictionary *response = @{
                               @"value" : value,
                               };
    
    callback(@[[NSNull null], response]);
}

@end
