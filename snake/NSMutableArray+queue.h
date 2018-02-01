//
//  NSMutableArray+queue.h
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (queue)

- (id)queuePop;
- (void)queuePush:(id)obj;

@end
