//
//  SLAssignment.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAssignment.h"


@implementation SLAssignment

-(id)initWithName:(NSString *)name grade:(NSString *)grade weight:(NSString *)weight reader:(NSString *)reader comments:(NSString *)comments assignmentType:(AssignmentType)assignmentType account:(SLAccount *)account
{
    self = [super init];
    if (self) {
        self.name = name;
        self.grade = grade;
        self.weight = weight;
        self.reader = reader;
        self.comments = comments;
        self.type = assignmentType;
        self.account = account;
        self.distribution = nil;
    }
    return self;
}

-(id)initFromDictionary:(NSMutableDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.grade = [dictionary objectForKey:@"grade"];
        self.weight = [dictionary objectForKey:@"weight"];
        self.reader = [dictionary objectForKey:@"reader"];
        self.comments = [dictionary objectForKey:@"comments"];
        NSString *typeString = [dictionary objectForKey:@"type"];
        if ([typeString isEqualToString:@"RegularAssignment"]) {
            self.type = RegularAssignment;
        } else {
            self.type = TotalAssignment;
        }
        self.account = [dictionary objectForKey:@"account"];
        self.distribution = [[SLDistribution alloc] initFromDictionary:[dictionary objectForKey:@"distribution"]];
    }
    
    return self;
}

-(void)updateDistribution
{
    if (!_account.session.isConnected) {
        if (![_account openSession]) {
            return;
        }
    }
    NSError *error = nil;
    NMSSHChannel *channel = _account.session.channel;
    
    //Come up for a solution if errors happen
    NSString *rankCommand = [NSString stringWithFormat:@"glookup -s %@ | head -n 2 | tail -n 1 | cut -d '#' -f2 | cut -d ' ' -f1", _name ];
    NSString *infoDataCommand = [NSString stringWithFormat:@"glookup -s %@ | head -n 11 | tail -n +2 | cut -d ':' -f2 |tr -s ' ' | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//' | cut -d ' ' -f1", _name];
    NSString *upperBoundCommand = [NSString stringWithFormat:@"glookup -s %@ | tail -n +13 | sed -e 's/://' -e 's/-//' -e 's/^[ \t]*//' -e 's/[ \t]*$//' | tr -s ' ' | cut -d ' ' -f2", _name];
    NSString *numInBinsCommand = [NSString stringWithFormat:@"glookup -s %@ | tail -n +13 | sed -e 's/://' -e 's/-//' -e 's/^[ \t]*//' -e 's/[ \t]*$//' | tr -s ' ' | cut -d ' ' -f3", _name];
    
    NSString *rankString = [channel execute:rankCommand error:&error];
    NSString *infoDataString = [channel execute:infoDataCommand error:&error];
    NSString* upperBoundString = [channel execute:upperBoundCommand error:&error];
    NSString *numInBinsString = [channel execute:numInBinsCommand error:&error];
    
    NSArray* infoDataStringArray = [infoDataString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* upperBoundsStringArray = [upperBoundString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* numInBinsStringArray = [numInBinsString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setMaximumFractionDigits:2];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    self.distribution = [[SLDistribution alloc] init];
    
    self.distribution.rank = [rankString integerValue];
    self.distribution.yourScore = [f numberFromString:[infoDataStringArray objectAtIndex:0]];
    self.distribution.mean = [f numberFromString:[infoDataStringArray objectAtIndex:1]];
    self.distribution.mode = [f numberFromString:[infoDataStringArray objectAtIndex:2]];
    self.distribution.standardDeviation = [f numberFromString:[infoDataStringArray objectAtIndex:3]];
    self.distribution.minimum = [f numberFromString:[infoDataStringArray objectAtIndex:4]];
    self.distribution.firstQuartile = [f numberFromString:[infoDataStringArray objectAtIndex:5]];
    self.distribution.secondQuartile = [f numberFromString:[infoDataStringArray objectAtIndex:6]];
    self.distribution.thirdQuartile = [f numberFromString:[infoDataStringArray objectAtIndex:7]];
    self.distribution.maximum = [f numberFromString:[infoDataStringArray objectAtIndex:8]];
    self.distribution.nominalMaxPossible = [f numberFromString:[infoDataStringArray objectAtIndex:9]];
    self.distribution.upperBounds = [upperBoundsStringArray valueForKey:@"floatValue"];
    self.distribution.numInBin = [numInBinsStringArray valueForKey:@"intValue"];
}

-(NSMutableDictionary *)assignmentToDictionary
{
    NSMutableDictionary *outDictionary = [[NSMutableDictionary alloc] initWithCapacity:8];
    [outDictionary setObject:_name forKey:@"name"];
    [outDictionary setObject:_grade forKey:@"grade"];
    [outDictionary setObject:_weight forKey:@"weight"];
    [outDictionary setObject:_reader forKey:@"reader"];
    [outDictionary setObject:_comments forKey:@"comments"];
    if (_type == RegularAssignment) {
        [outDictionary setObject:@"RegularAssignment" forKey:@"type"];
    } else {
        [outDictionary setObject:@"TotalAssignment" forKey:@"type"];
    }
    [outDictionary setObject:_account forKey:@"account"];
    [outDictionary setObject:[_distribution distributionToDictionary] forKey:@"distribution"];
    return outDictionary;
}

@end
