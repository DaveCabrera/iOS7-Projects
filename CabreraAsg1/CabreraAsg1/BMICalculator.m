//
//  BMICalculator.m
//  BMI
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "BMICalculator.h"

@implementation BMICalculator

// initialize the BMI Calculatir with the measurement in feet
// and inches
- (id) initWithHeightInFeet:(double)feet withInches:(double)inches withWeight:(double)weight
{
    self = [super init];
    if (self)
    {
        self.heightInFeet = feet;
        self.heightInInches = inches;
        self.weight = weight;
    }
    return self;
}

// initialize the BMI Calculator with the measurement in meters
- (id) initWithHeightInMeters:(double)heightInMeters weithWeight:(double)weight
{
    self = [super init];
    if (self)
    {
        self.heightInMeters = heightInMeters;
        self.weight = weight;
    }
    return self;
}

// method to convert the height in feet and inches to meters
// Sets the heightInMeters variable
- (void) convertHeightToMetric
{
    // convert feet to inches
    double feetToInches = self.heightInFeet * 12.00;
    double totalInches = feetToInches + self.heightInInches;
    
    // convert inches to centimeters
    double centimeters = totalInches * 2.54;
    
    // convert to meters
    self.heightInMeters = (centimeters / 100);
}

- (void) convertWeightToMetric
{
    // convert weight to kilograms
    self.weight = (self.weight / 2.2046);

}

// calculate the BMI
- (NSString *) calculateBMI
{
    // to calculate BMI, BMI = Kilograms / height ^2
    double heightSquared = self.heightInMeters * self.heightInMeters;
    double BMI = self.weight / heightSquared;
    
    NSNumber *BMIConversion = [[NSNumber alloc] initWithDouble:BMI];
    // output the message indicating the BMI
    if (BMI < 18.50)
    {
        NSString *outputString = [[NSString alloc] initWithFormat:@"You are Underweight with BMI: %1.2f", [BMIConversion doubleValue]];
        return outputString;
    }
    if (BMI <= 24.90 && BMI >= 18.50)
    {
        NSString *outputString = [[NSString alloc] initWithFormat:@"You are Normal with BMI: %1.2f", [BMIConversion doubleValue]];
        return outputString;
    }
    if (BMI < 30.00 && BMI > 24.90)
    {
        NSString *outputString = [[NSString alloc] initWithFormat:@"You are Overweight with BMI: %1.2f", [BMIConversion doubleValue]];
        return outputString;
    }
    if (BMI >= 30.00)
    {
        NSString *outputString = [[NSString alloc] initWithFormat:@"You are Obese with BMI: %1.2f", [BMIConversion doubleValue]];
        return outputString;
    }
    return nil;
}

@end
