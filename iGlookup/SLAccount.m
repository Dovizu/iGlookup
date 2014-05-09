//
//  SLAccount.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAccount.h"

@implementation SLAccount

-(id)initWithClassName:(NSString *)className username:(NSString *)username
{
    self = [super init];
    if (self) {
        self.assignments = [[NSMutableArray alloc] init];
        self.className = className;
        self.username = username;
        self.keychain = [FXKeychain defaultKeychain];
        self.session = nil;

    }
    return self;
}

-(id)initFromDictionary:(NSMutableDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.assignments = [dictionary objectForKey:@"assignments"];
        self.className = [dictionary objectForKey:@"className"];
        self.username = [dictionary objectForKey:@"username"];
        self.keychain = [FXKeychain defaultKeychain];
        self.session = nil;

    }
    return self;
}

// Updates assignments to have the latest attributes by connecting through SSH
-(void)updateAssignments
{
    if (!_session.isConnected) {
        if (![self openSession]) {
            return;
        }
    }
    NSError *error = nil;
    NMSSHChannel *channel = _session.channel;
    
    //Come up for a solution if errors happen
    NSString* assignmentNamesString = [channel execute:@"glookup | tail -n +3 | sed 's/^[ \t]*//' | sed 's/://' | tr -s ' ' | cut -d ' ' -f1 | sed 's/[ \t]*$//'" error:&error];
    NSString* gradesString = [channel execute:@"glookup | tail -n +3 | sed 's/^[ \t]*//' | tr -s ' ' | cut -d ' ' -f2 | sed 's/[ \t]*$//'" error:&error];
    NSString *weightsString = [channel execute:@"glookup | tail -n +3 | sed 's/^[ \t]*//' | tr -s ' ' | cut -d ' ' -f3 | sed 's/[ \t]*$//'" error:&error];
    NSString *readersString = [channel execute:@"glookup | tail -n +3 | sed 's/^[ \t]*//' | tr -s ' ' | cut -d ' ' -f4 | sed 's/[ \t]*$//'" error:&error];
    NSString* commentsString = [channel execute:@"glookup | tail -n +3 | sed 's/^[ \t]*//' | tr -s ' ' | cut -d ' ' -f5- | sed 's/[ \t]*$//'" error:&error];
    
    NSArray* assignmentNames = [assignmentNamesString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* grades = [gradesString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* weights = [weightsString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* readers = [readersString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSArray* comments = [commentsString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    NSUInteger length = [assignmentNames count];
    self.assignments = [[NSMutableArray alloc] initWithCapacity:length-1]; //The last row had no data
    for (NSUInteger i = 0; i < length-1; i++) {
        NSString *name = [assignmentNames objectAtIndex:i];
        NSString *grade = [grades objectAtIndex:i];
        NSString *weight = [weights objectAtIndex:i];
        NSString *reader = [readers objectAtIndex:i];
        NSString *comment = [comments objectAtIndex:i];
        [_assignments addObject:[[SLAssignment alloc] initWithName:name
                                                             grade:grade
                                                            weight:weight
                                                            reader:reader
                                                          comments:comment
                                                    assignmentType:RegularAssignment
                                                           account:self]];
    }
    //Note that the last line will be an empty line. Thus, the second to last line holds Extrapolated total
    
    NSString *totalGrade = [grades objectAtIndex:(length-3)];
    NSString *extrapolatedTotalGrade = [weights objectAtIndex:(length-2)]; //Since Extrapolated total has a space, it is split by the parser and erroneously placed in weights
    [_assignments addObject:[[SLAssignment alloc] initWithName:@"Total"
                                                         grade:totalGrade
                                                        weight:@""
                                                        reader:@""
                                                      comments:@""
                                                assignmentType:TotalAssignment
                                                       account:self]];
    [_assignments addObject:[[SLAssignment alloc] initWithName:@"Extrapolated total"
                                                         grade:extrapolatedTotalGrade
                                                        weight:@""
                                                        reader:@""
                                                      comments:@""
                                                assignmentType:TotalAssignment
                                                       account:self]];
}

//Updates username and password for account
-(void)updateUsername:(NSString *)username password:(NSString *)password
{
    [_keychain removeObjectForKey:self.username];
    if ([_keychain setObject:password forKey:username])
        self.username = username;
}

//Sets password for account
-(void)setPassword:(NSString *)password
{
    //Add check for wether or not password is valid.
    [_keychain setObject:password forKey:_username];
}

// Opens ssh connection to a hive server
-(BOOL)openSession
{
    self.session = [NMSSHSession connectToHost:@"hive6.cs.berkeley.edu" withUsername:_username]; //Randomize this in future
    if (self.session.isConnected) {
        [_session authenticateByPassword:[_keychain objectForKey:_username]];
    }
    
    if (_session.isAuthorized) {
        DebugLog(@"Authentication succeeded");
        return YES;
    }
    return NO;
}

// Closes ssh connection to a hive server
-(void)closeSession
{
    [_session disconnect];
}

-(NSMutableDictionary *)accountToDictionary
{
    NSMutableDictionary *outDictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *assignmentsArray = [NSMutableArray arrayWithCapacity:[_assignments count]];
    for (NSInteger i = 0; i < [_assignments count]; ++i) {
        assignmentsArray[i] = [_assignments[i] assignmentToDictionary];
    }
    [outDictionary setObject:assignmentsArray forKey:@"assignments"];
    [outDictionary setObject:_className forKey:@"className"];
    [outDictionary setObject:_username forKey:@"username"];
    return outDictionary;
}

@end
