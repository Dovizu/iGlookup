//
//  SLAssignmentTest.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/9/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLAccount.h"
#import "SLAssignment.h"

@interface SLAssignmentTest : XCTestCase

@property SLAccount *testAccount;
@property SLAssignment *testAssignment;

@end

@implementation SLAssignmentTest

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

- (void)testUpdateDistribution
{
    if (![_testAccount openSession]){
        return;
    }
    [_testAccount updateAssignments];
    NSUInteger length = [_testAccount.assignments count];
    self.testAssignment = [_testAccount.assignments objectAtIndex:length-2];
    [_testAssignment updateDistribution];
    XCTAssertEqual((int) _testAssignment.distribution.rank, 13, @"Expected: 13\t Got: %i",(int) _testAssignment.distribution.rank);
    XCTAssertTrue([[_testAssignment.distribution.yourScore stringValue] isEqualToString:@"1328"], @"Expected: 1328\t Got: %@", [_testAssignment.distribution.yourScore stringValue]);
    [_testAccount closeSession];
}

@end
