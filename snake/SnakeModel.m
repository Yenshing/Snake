//
//  snakeModel.m
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import "SnakeModel.h"

@interface SnakeModel()

@property (nonatomic, strong) Coordinate *directionAxis;
@property (nonatomic, assign) NSInteger addLength;
@property (nonatomic, assign) BOOL lock;

@end

@implementation SnakeModel

- (instancetype)init {
    if (self = [super init]) {
        // Initialize self
        self.addLength = 0;
        [self initDirection];
        [self initPosition:nil];
    }
    return self;
}

- (instancetype)initWithSnakeCoordinate:(Coordinate*)point {
    if (self = [super init]) {
        // Initialize self
        self.addLength = 0;
        [self initDirection];
        [self initPosition:point];
    }
    return self;
}

- (void)initPosition:(Coordinate *)point {
    
    if(point==nil) {
        point  = [[Coordinate alloc] initWithPointX:1 PointY:0];
    }
    
    self.position = [[NSMutableArray alloc] init];
    [self.position addObject:point];
    
    Coordinate *b = [[Coordinate alloc] initWithPointX:point.x-1 PointY:point.y];
    [self.position addObject:b];
    
    NSLog(@"self.position=%@",self.position);
}

- (void)initDirection {
    self.directionAxis = [[Coordinate alloc] init];
    self.direction = SnakeDirectionLeft;
}

- (void)setDirection:(SnakeDirection)direction {
    switch (direction) {
        case SnakeDirectionLeft:
            if(self.direction == SnakeDirectionRight) {
                return;
            }
            self.directionAxis.x = -1;
            self.directionAxis.y = 0;
            break;
        case SnakeDirectionRight:
            if(self.direction == SnakeDirectionLeft) {
                return;
            }
            self.directionAxis.x = 1;
            self.directionAxis.y = 0;
            break;
        case SnakeDirectionUp:
            if(self.direction == SnakeDirectionDown) {
                return;
            }
            self.directionAxis.x = 0;
            self.directionAxis.y = 1;
            break;
        case SnakeDirectionDown:
            if(self.direction == SnakeDirectionUp) {
                return;
            }
            self.directionAxis.x = 0;
            self.directionAxis.y = -1;
            break;
        default:
            break;
    }
    _direction = direction;
}

#pragma mark - method

//要求蛇移動一格
- (void)moveOneStep {
    Coordinate *nextPosition = [[Coordinate alloc] init];
    nextPosition.x = ((Coordinate *)self.position.lastObject).x + self.directionAxis.x;
    if(nextPosition.x >= self.max_x) {
        nextPosition.x = 0;
    } else if (nextPosition.x < 0) {
        nextPosition.x = self.max_x-1;
    }
    
    nextPosition.y = ((Coordinate *)self.position.lastObject).y + self.directionAxis.y;
    if(nextPosition.y >= self.max_y) {
        nextPosition.y = 0;
    } else if (nextPosition.y < 0) {
        nextPosition.y = self.max_y-1;
    }
    
    if(self.addLength) {
        self.addLength--;
    } else {
        [self.position queuePop];
    }
    [self.position queuePush:nextPosition];
}

//要求蛇增加長度
- (void)addBodyLength {
    self.addLength = 2;
}

//詢問蛇現在頭是否碰到自己的身體
- (BOOL)checkIfHitBody {
    Coordinate *head = (Coordinate*)self.position.lastObject;
    for(int i=0; i<self.position.count-1; i++) {
        Coordinate *bodyPart = (Coordinate*)[self.position objectAtIndex:i];
        if(head.x == bodyPart.x && head.y == bodyPart.y) {
            return true;
        }
    }
    return false;
}

//詢問蛇的頭是否剛好碰到某個點
- (BOOL)checkIfHitPoint:(Coordinate*)point {
    Coordinate *head = (Coordinate*)self.position.lastObject;
    if(head.x == point.x && head.y == point.y) {
        return true;
    }
    return false;
}

@end
