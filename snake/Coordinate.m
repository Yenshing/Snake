//
//  coordinate.m
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate

- (instancetype)initWithPointX:(NSInteger)x PointY:(NSInteger)y {
    if (self = [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

@end
