//
//  SLDistribution.h
//  iGlookup
//
//  Created by Leonino Colobong on 5/9/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLDistribution : NSObject

@property NSInteger rank;
@property NSNumber *yourScore;
@property NSNumber *mean;
@property NSNumber *mode;
@property NSNumber *standardDeviation;
@property NSNumber *minimum;
@property NSNumber *firstQuartile;
@property NSNumber *secondQuartile;
@property NSNumber *thirdQuartile;
@property NSNumber *maximum;
@property NSNumber *nominalMaxPossible;
@property NSMutableArray *upperBounds;
@property NSMutableArray *numInBin;

- (id)initFromDictionary:(NSMutableDictionary *)dictionary;

-(NSMutableDictionary *)distributionToDictionary;


@end
