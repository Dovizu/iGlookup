//
//  SLDistribution.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/9/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLDistribution.h"

@implementation SLDistribution

-(id)initFromDictionary:(NSMutableDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.rank = [[dictionary objectForKey:@"rank"] intValue];
        self.yourScore = [dictionary objectForKey:@"yourScore"];
        self.mean = [dictionary objectForKey:@"mean"];
        self.mode = [dictionary objectForKey:@"mode"];
        self.standardDeviation = [dictionary objectForKey:@"standardDeviation"];
        self.minimum = [dictionary objectForKey:@"minimum"];
        self.firstQuartile = [dictionary objectForKey:@"firstQuartile"];
        self.secondQuartile = [dictionary objectForKey:@"secondQuartile"];
        self.thirdQuartile = [dictionary objectForKey:@"thirdQuartile"];
        self.maximum = [dictionary objectForKey:@"maximum"];
        self.nominalMaxPossible = [dictionary objectForKey:@"nominalMaxPossible"];
        self.upperBounds = [dictionary objectForKey:@"upperBounds"];
        self.numInBin = [dictionary objectForKey:@"numInBin"];
    }
    return self;
}

-(NSMutableDictionary *)distributionToDictionary
{
    NSMutableDictionary* outDictionary = [[NSMutableDictionary alloc] initWithCapacity:13];
    [outDictionary setObject:[NSNumber numberWithInteger:_rank] forKey:@"rank"];
    [outDictionary setObject:_yourScore forKey:@"yourScore"];
    [outDictionary setObject:_mean forKey:@"mean"];
    [outDictionary setObject:_mode forKey:@"mode"];
    [outDictionary setObject:_standardDeviation forKey:@"standardDeviation"];
    [outDictionary setObject:_minimum forKey:@"minimum"];
    [outDictionary setObject:_firstQuartile forKey:@"firstQuartile"];
    [outDictionary setObject:_secondQuartile forKey:@"secondQuartile"];
    [outDictionary setObject:_thirdQuartile forKey:@"thirdQuartile"];
    [outDictionary setObject:_maximum forKey:@"maximum"];
    [outDictionary setObject:_nominalMaxPossible forKey:@"nominalMaxPossible"];
    [outDictionary setObject:_upperBounds forKey:@"upperBounds"];
    [outDictionary setObject:_numInBin forKey:@"numInBin"];
    return outDictionary;
}

@end
