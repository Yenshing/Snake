//
//  Quartz2DView.m
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import "Quartz2DView.h"

@implementation Quartz2DView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.snakeBody = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    NSInteger unit = self.unit * [[UIScreen mainScreen] scale];
    
    //(step 1) 取得得目前的圖像內文，並將其保存起來
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    //
    CGContextSaveGState(context);
    CGRect drawRect = CGRectMake(rect.origin.x, rect.origin.y,rect.size.width, rect.size.height);
    CGContextSetRGBFillColor(context, 50.0f/255.0f, 50.0f/255.0f, 50.0f/255.0f, 1.0f);
    CGContextFillRect(context, drawRect);
    CGContextRestoreGState(context);
    
    
    CGContextSaveGState(context);
    
    //(step 2) 取得目前轉換矩陣，將矩陣倒置後存到圖像內文中
    CGAffineTransform t0 = CGContextGetCTM( context );
    t0 = CGAffineTransformInvert(t0);
    CGContextConcatCTM(context, t0);

    //(step 3-1) 開始繪製矩形
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextSetLineWidth(context, 4.0);
    for (int i=0; i<self.snakeBody.count; i++) {
        CGContextAddRect( context , CGRectMake([self.snakeBody objectAtIndex:i].x*unit, [self.snakeBody objectAtIndex:i].y*unit, unit, unit));
    }
    CGContextClosePath(context);
    CGContextDrawPath(context,kCGPathFill);
    
    //(step 4) 恢復保存的內文
    CGContextRestoreGState(context);

    if(self.fruit) {
        CGContextSaveGState(context);
        
        t0 = CGContextGetCTM( context );
        t0 = CGAffineTransformInvert(t0);
        CGContextConcatCTM(context, t0);
        
        CGContextBeginPath(context);
        CGContextSetRGBFillColor(context, 0, 1, 0, 1);
        CGContextAddRect( context , CGRectMake(self.fruit.x*unit, self.fruit.y*unit, unit, unit));
        CGContextClosePath(context);
        CGContextDrawPath(context,kCGPathFill);
        
        CGContextRestoreGState(context);
    }
    
    
}

#pragma mark - method

- (void)reloadData {
    [self setNeedsDisplay];
}

@end
