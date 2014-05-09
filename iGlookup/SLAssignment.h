//
//  SLAssignment.h
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDistribution.h"
@class SLAccount;

typedef enum {
    RegularAssignment,
    TotalAssignment
} AssignmentType;

@interface SLAssignment : NSObject

@property NSString *name;
@property NSString *grade;
@property NSString *weight;
@property NSString *reader;
@property NSString *comments;
@property AssignmentType type;
@property SLAccount *account;
@property SLDistribution *distribution;


- (id)initWithName:(NSString *)name
             grade:(NSString *)grade
            weight:(NSString *)weight
            reader:(NSString *)reader
          comments:(NSString *)comments
    assignmentType:(AssignmentType)assignmentType
           account:(SLAccount *)account;
- (id)initFromDictionary:(NSMutableDictionary *) dictionary;
- (void)updateDistribution;
- (NSMutableDictionary *)assignmentToDictionary;

@end