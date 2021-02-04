#import "RCTAppleHealthKit+Methods_Vitals.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Vitals)


- (void)vitals_getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:heartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting heart rate samples: %@", error);
            callback(@[RCTMakeError(@"error getting heart rate samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyTemperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bodyTemperatureType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting body temperature samples: %@", error);
            callback(@[RCTMakeError(@"error getting body temperature samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *respiratoryRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:respiratoryRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting respiratory rate samples: %@", error);
            callback(@[RCTMakeError(@"error getting respiratory rate samples", nil, nil)]);
            return;
        }
    }];
}

- (void)vitals_getBloodPressureSystolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples", nil, nil)]);
            return;
        }
    }];
}

- (void)vitals_getBloodPressureDiastolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples", nil, nil)]);
            return;
        }
    }];
}

- (void)vitals_getInsulinDelivery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *insulinDelivery = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:insulinDelivery
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting basal getVolume02Max: %@", error);
                                  callback(@[RCTMakeError(@"error getting getVolume02Max", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getVolume02Max:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *volume02Max = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit literUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:volume02Max
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting basal getVolume02Max: %@", error);
                                  callback(@[RCTMakeError(@"error getting getVolume02Max", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getBasalBodyTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyTemperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalBodyTemperature];

        HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
        NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
        BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
        if(startDate == nil){
            callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
            return;
        }
        NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

        [self fetchQuantitySamplesOfType:bodyTemperatureType
                                    unit:unit
                               predicate:predicate
                               ascending:ascending
                                   limit:limit
                              completion:^(NSArray *results, NSError *error) {
            if(results){
                callback(@[[NSNull null], results]);
                return;
            } else {
                NSLog(@"error getting basal body temperature samples: %@", error);
                callback(@[RCTMakeError(@"error getting body temperature samples", nil, nil)]);
                return;
            }
        }];
}
- (void)vitals_saveHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double heartRateAmount = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    
    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];
    
    HKQuantitySample* heartRate = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate]
                                                              quantity:[HKQuantity quantityWithUnit:[count unitDividedByUnit:minute] doubleValue:heartRateAmount]
                                                             startDate:startDate
                                                               endDate:endDate
                                                              metadata:nil];
    
    // Save the water Sample to HealthKit //
    [self.healthStore saveObject:heartRate withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the heartRate sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured saving the heartRate sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @true]);
    }];
}
- (void)vitals_saveBloodPressureSystolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double bloodPressureSystolicAmount = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    
    HKQuantitySample* bloodPressureSystolic = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic]
                                                                  quantity:[HKQuantity quantityWithUnit:[HKUnit millimeterOfMercuryUnit] doubleValue:bloodPressureSystolicAmount]
                                                                 startDate:startDate
                                                                   endDate:endDate
                                                                  metadata:nil];
    
    // Save the water Sample to HealthKit //
    [self.healthStore saveObject:bloodPressureSystolic withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the bloodPressureSystolic sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured saving the bloodPressureSystolic sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @true]);
    }];
}
- (void)vitals_saveBloodPressureDiastolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double bloodPressureDiastolicAmount = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    
    HKQuantitySample* bloodPressureDiastolic = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic]
                                                                              quantity:[HKQuantity quantityWithUnit:[HKUnit millimeterOfMercuryUnit] doubleValue:bloodPressureDiastolicAmount]
                                                                             startDate:startDate
                                                                               endDate:endDate
                                                                              metadata:nil];
    
    // Save the water Sample to HealthKit //
    [self.healthStore saveObject:bloodPressureDiastolic withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the bloodPressureDiastolic sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured saving the bloodPressureDiastolic sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @true]);
    }];
}
@end
