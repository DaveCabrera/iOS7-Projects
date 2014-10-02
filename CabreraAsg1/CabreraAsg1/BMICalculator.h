//
//  BMICalculator.h
//  BMI
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMICalculator : NSObject

@property (nonatomic) double heightInFeet;
@property (nonatomic) double heightInInches;
@property (nonatomic) double heightInMeters;
@property (nonatomic) double weight;

- (id) initWithHeightInFeet:(double) feet withInches: (double) inches withWeight:(double) weight;
- (id) initWithHeightInMeters: (double) heightInMeters weithWeight:(double) weight;
- (NSString *) calculateBMI;
- (void) convertHeightToMetric;
- (void) convertWeightToMetric;
@end