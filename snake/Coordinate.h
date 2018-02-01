//
//  coordinate.h
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (instancetype)initWithPointX:(NSInteger)x PointY:(NSInteger)y;

@end
