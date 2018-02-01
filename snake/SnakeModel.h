//
//  snakeModel.h
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "NSMutableArray+queue.h"

typedef NS_ENUM(NSInteger, SnakeDirection) {
    SnakeDirectionLeft = 0,
    SnakeDirectionRight = 1,
    SnakeDirectionUp = 2,
    SnakeDirectionDown = 3
};

@interface SnakeModel : NSObject

@property (nonatomic, assign) SnakeDirection direction;
@property (nonatomic, strong) NSMutableArray<Coordinate *> *position;

@property (nonatomic,assign) NSInteger max_x;
@property (nonatomic,assign) NSInteger max_y;

//初始化
- (instancetype)initWithSnakeCoordinate:(Coordinate*)point;

//要求蛇移動一格
- (void)moveOneStep;

//要求蛇增加長度
- (void)addBodyLength;

//詢問蛇現在頭是否碰到自己的身體
- (BOOL)checkIfHitBody;

//詢問蛇的頭是否剛好碰到某個點
- (BOOL)checkIfHitPoint:(Coordinate*)point;

@end
