//
//  ViewController.m
//  snake
//
//  Created by Yencheng on 2018/1/29.
//  Copyright © 2018年 GJTeam. All rights reserved.
//

#import "ViewController.h"
#import "SnakeModel.h"
#import "coordinate.h"
#import "Quartz2DView.h"
#import "fruitModel.h"

@interface ViewController () {
    NSTimer *timer;
    SnakeModel* snake;
    FruitModel* fruit;
    Quartz2DView *snakeView;
    
    int w_range;
    int h_range;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    w_range = 9;
    h_range = 16;
    
    int max_unit = 1;
    while ( 16 * max_unit < self.view.frame.size.height ) {
        max_unit++;
    }
    
    snakeView = [[Quartz2DView alloc] initWithFrame:CGRectMake(0, 0, 9*max_unit, 16*max_unit)];
    snakeView.center = self.view.center;
    snakeView.unit = max_unit;
    [self.view addSubview:snakeView];

    [self addGestureRecognizer:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:UISwipeGestureRecognizerDirectionLeft];
}

- (void)viewDidAppear:(BOOL)animated {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"開始"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         [self startGame];
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addGestureRecognizer:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDirection:)];
    gr.direction = direction;
    [self.view addGestureRecognizer:gr];
}

- (void)initSnake {
    Coordinate* startPoint = [[Coordinate alloc] initWithPointX:w_range/2 + 1 PointY:h_range/2];
    snake = [[SnakeModel alloc] initWithSnakeCoordinate:startPoint];
    snake.max_y = h_range;
    snake.max_x = w_range;
}

- (void)initFruit {
    fruit = [[FruitModel alloc] init];
    [self generateNewFruit];
}

- (void)startGame {
    [self initSnake];
    [self initFruit];
    snakeView.snakeBody = snake.position;
    snakeView.fruit = fruit;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                             target:self
                                           selector:@selector(refresh)
                                           userInfo:nil
                                            repeats:self];
}

- (void)endGame {
    [timer invalidate];
    timer = nil;
    NSInteger score = snake.position.count/2 - 1;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:[NSString stringWithFormat:@"吃了%ld個",score]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重玩"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         [self startGame];
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)swipeDirection:(UISwipeGestureRecognizer *)gr {
    UISwipeGestureRecognizerDirection direction = gr.direction;
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            snake.direction = SnakeDirectionUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            snake.direction = SnakeDirectionDown;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            snake.direction = SnakeDirectionRight;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            snake.direction = SnakeDirectionLeft;
            break;
        default:
            break;
    }
}

- (void)refresh {
    [snake moveOneStep];
    
    if([snake checkIfHitBody]) {
        [self endGame];
    }
    
    if([snake checkIfHitPoint:fruit]) {
        [snake addBodyLength];
        [self generateNewFruit];
    }
    
    [snakeView reloadData];
}

- (void)generateNewFruit {
    do {
        fruit.x = arc4random() % w_range;
        fruit.y = arc4random() % h_range;
    } while ([self checkIfOverlap]);
}

- (BOOL)checkIfOverlap {
    for(int i=0; i<snake.position.count-1; i++) {
        Coordinate *bodyPart = (Coordinate*)[snake.position objectAtIndex:i];
        if(fruit.x == bodyPart.x && fruit.y == bodyPart.y) {
            NSLog(@"Overlap");
            return true;
        }
    }
    return false;
}

#pragma mark - Log

- (void)showSnakePosition:(SnakeModel*)snakeModel {
    for (int i=0; i<snakeModel.position.count; i++) {
        NSLog(@"i=%d,x.y = (%ld,%ld)", i, ((Coordinate *)[snakeModel.position objectAtIndex:i]).x, ((Coordinate *)[snakeModel.position objectAtIndex:i]).y);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
