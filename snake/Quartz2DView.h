//
//  Quartz2DView.h
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coordinate.h"

@interface Quartz2DView : UIView

@property (nonatomic, strong) NSMutableArray<Coordinate *> *snakeBody;
@property (nonatomic, strong) Coordinate *fruit;
@property (nonatomic, assign) NSInteger unit;

- (void)reloadData;

@end
