//
//  NSMutableArray+queue.m
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import "NSMutableArray+queue.h"

@implementation NSMutableArray (queue)

-(id)queuePop {
    @synchronized(self) {
        if ([self count] == 0) {
            return nil;
        }
        id queueObject = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
        return queueObject;
    }
}

// Add to the tail of the queue
-(void)queuePush:(id)anObject {
    @synchronized(self) {
        [self addObject:anObject];
    }
}

@end
