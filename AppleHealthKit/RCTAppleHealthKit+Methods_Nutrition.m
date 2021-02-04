//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Nutrition.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Nutrition)

- (void)nutrition_getDietaryEnergyConsumed:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    HKUnit *percentUnit = [HKUnit kilocalorieUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryEnergyConsumed: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryEnergyConsumed", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryFatTotal:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryFatTotal: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryFatTotal", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryFatSaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *fatSaturated = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:fatSaturated
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting fatSaturated: %@", error);
                                  callback(@[RCTMakeError(@"error getting fatSaturated", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryCholesterol:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryCholesterol: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryCholesterol", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryCarbohydrates:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryCarbohydrates: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryCarbohydrates", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryFiber:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryFiber: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryFiber", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietarySugar:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietarySugar: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietarySugar", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryProtein:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryProtein: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryProtein", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryCalcium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryCalcium: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryCalcium", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)nutrition_getDietaryIron:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryIron: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryIron", nil, nil)]);
                                  return;
                              }
                          }];
}
- (void)nutrition_getDietaryPotassium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryPotassium: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryPotassium", nil, nil)]);
                                  return;
                              }
                          }];
}
- (void)nutrition_getDietaryVitaminA:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryVitaminA: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryVitaminA", nil, nil)]);
                                  return;
                              }
                          }];
}
- (void)nutrition_getDietaryVitaminC:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryVitaminC: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryVitaminC", nil, nil)]);
                                  return;
                              }
                          }];
}
- (void)nutrition_getDietaryVitaminD:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD];
    HKUnit *percentUnit = [HKUnit gramUnit];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:type
                                unit:percentUnit
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting nutrition_getDietaryVitaminD: %@", error);
                                  callback(@[RCTMakeError(@"error getting nutrition_getDietaryVitaminD", nil, nil)]);
                                  return;
                              }
                          }];
}
@end

