//
//  SLAccountTest.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLAccount.h"
#import "SLAssignment.h"

@interface SLAccountTest : XCTestCase
@property SLAccount *testAccount;

@end

@implementation SLAccountTest

- (void)setUp
{
    [super setUp];
    self.testAccount = [[SLAccount alloc] initWithClassName:@"cs70" username:@"cs70-jm"];
    [_testAccount setPassword:@"That'smypassword!"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOpenSession
{
    if (![_testAccount openSession]){
        return;
    }
    NSError *error = nil;
    NSString* testString = @"hello world\n";
    NMSSHChannel *channel= _testAccount.session.channel;
    NSString *response = [channel execute:@"echo hello world" error:&error];
    DebugLog(@"%@", response);
//    DebugLog(@"%@", error);
    XCTAssert([testString isEqualToString:response], @"Expected: hello world\\\n\tGot: %@", response);

    [_testAccount closeSession];
}

- (void) testUpdateAccounts
{
    if (![_testAccount openSession]){
        return;
    }
    [_testAccount updateAssignments];
    SLAssignment *as1 = _testAccount.assignments[0];
    XCTAssert([as1.name isEqualToString:@"midterm2"], @"Expected midterm2. Got: %@", as1.name);
    XCTAssert([as1.grade isEqualToString:@"131/158"], @"Expected:\t131/158. Got: %@", as1.grade);
    XCTAssert([as1.weight isEqualToString:@"1"], @"Expected: 1\tGot: %@", as1.weight);
    XCTAssert([as1.reader isEqualToString:@"cs70"], @"Expected: cs70\tGot: %@", as1.reader);
    XCTAssert([as1.comments isEqualToString:@""], @"Expected:\"\"\tGot: %@", as1.comments);
    
    NSUInteger length= [_testAccount.assignments count];
    SLAssignment *lastAssignment = _testAccount.assignments[length-1];
    XCTAssert([lastAssignment.name isEqualToString:@"Extrapolated total"], @"Expected: Extrapolated total. Got: %@", lastAssignment.name);
    XCTAssert([lastAssignment.grade isEqualToString:@"1383.81/1686"], @"Expected 1383.81. Got: %@", lastAssignment.grade);
    XCTAssert([lastAssignment.weight isEqualToString:@""], @"Expected: \"\"\tGot: %@", lastAssignment.weight);
    XCTAssert([lastAssignment.reader isEqualToString:@""], @"Expected: \"\"\tGot: %@", lastAssignment.reader);
    XCTAssert([lastAssignment.comments isEqualToString:@""], @"Expected: \"\"\tGot: %@", lastAssignment.comments);
    
    
    [_testAccount closeSession];
}

@end
