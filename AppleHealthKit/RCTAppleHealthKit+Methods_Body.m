//
//  RCTAppleHealthKit+Methods_Body.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Body.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Body)


- (void)body_getLatestWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(unit == nil){
        unit = [HKUnit poundUnit];
    }

    [self fetchMostRecentQuantitySampleOfType:weightType
                                    predicate:nil
                                   completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"error getting latest weight: %@", error);
            callback(@[RCTMakeError(@"error getting latest weight", error, nil)]);
        }
        else {
            // Determine the weight in the required unit.
            double usersWeight = [mostRecentQuantity doubleValueForUnit:unit];

            NSDictionary *response = @{
                    @"value" : @(usersWeight),
                    @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                    @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
            };

            callback(@[[NSNull null], response]);
        }
    }];
}


- (void)body_getWeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit poundUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:weightType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting weight samples: %@", error);
            callback(@[RCTMakeError(@"error getting weight samples", nil, nil)]);
            return;
        }
    }];
}


- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double weight = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit poundUnit]];

    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:unit doubleValue:weight];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving the weight sample: %@", error);
            callback(@[RCTMakeError(@"error saving the weight sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(weight)]);
    }];
}


- (void)body_getLatestBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    HKQuantityType *bmiType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    [self fetchQuantitySamplesOfType:bmiType
                                            unit:unit
        predicate:predicate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error getting latest BMI: %@", err);
                                              callback(@[RCTMakeError(@"error getting latest BMI", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}


- (void)body_saveBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double bmi = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];
    HKUnit *unit = [HKUnit countUnit];

    HKQuantity *bmiQuantity = [HKQuantity quantityWithUnit:unit doubleValue:bmi];
    HKQuantityType *bmiType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    HKQuantitySample *bmiSample = [HKQuantitySample quantitySampleWithType:bmiType quantity:bmiQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:bmiSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving BMI sample: %@.", error);
            callback(@[RCTMakeError(@"error saving BMI sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(bmi)]);
    }];
}


- (void)body_getLatestHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(unit == nil){
        unit = [HKUnit inchUnit];
    }

    [self fetchMostRecentQuantitySampleOfType:heightType
                                    predicate:nil
                                   completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"error getting latest height: %@", error);
            callback(@[RCTMakeError(@"error getting latest height", error, nil)]);
        }
        else {
            // Determine the height in the required unit.
            double height = [mostRecentQuantity doubleValueForUnit:unit];

            NSDictionary *response = @{
                    @"value" : @(height),
                    @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                    @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
            };

            callback(@[[NSNull null], response]);
        }
    }];
}


- (void)body_getHeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit inchUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:heightType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
          callback(@[[NSNull null], results]);
          return;
        } else {
          NSLog(@"error getting height samples: %@", error);
          callback(@[RCTMakeError(@"error getting height samples", error, nil)]);
          return;
        }
    }];
}


- (void)body_saveHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double height = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];

    HKUnit *heightUnit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(heightUnit == nil){
        heightUnit = [HKUnit inchUnit];
    }

    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:heightUnit doubleValue:height];
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving height sample: %@", error);
            callback(@[RCTMakeError(@"error saving height sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(height)]);
    }];
}


- (void)body_getLatestBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyFatPercentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    HKUnit *percentUnit = [HKUnit percentUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bodyFatPercentType
                                unit:percentUnit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting BodyFatPercentage: %@", error);
                                  callback(@[RCTMakeError(@"error getting BodyFatPercentage", error, nil)]);
                                  return;
                              }
                          }];
}


- (void)body_getLatestLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *leanBodyMassType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit poundUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:leanBodyMassType
                                unit:unit
                           predicate:predicate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *results, NSError *err){
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting Lean Body Mass: %@", err);
                                              callback(@[RCTMakeError(@"error getting Lean Body Mass", err, nil)]);
                                              return;
                                          }
                                      }];
}

@end
