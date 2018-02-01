//
//  snakeTests.m
//  snakeTests
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SnakeModel.h"

@interface snakeTests : XCTestCase

@end

@implementation snakeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHit {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Coordinate *start = [[Coordinate alloc] initWithPointX:1 PointY:1];
    SnakeModel *snake = [[SnakeModel alloc] initWithSnakeCoordinate:start];
    snake.max_x = 10;
    snake.max_y = 10;
    [snake moveOneStep];
    [snake addBodyLength];
    snake.direction = SnakeDirectionUp;
    [snake moveOneStep];
    [snake addBodyLength];
    snake.direction = SnakeDirectionRight;
    [snake moveOneStep];
    [snake addBodyLength];
    snake.direction = SnakeDirectionDown;
    [snake moveOneStep];
    snake.direction = SnakeDirectionLeft;
    XCTAssertEqual([snake checkIfHitBody], YES, @"must hit the body.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
