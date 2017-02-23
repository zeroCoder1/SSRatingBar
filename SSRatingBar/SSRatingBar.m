//
//  SSRatingBar.m
//  testFeedback
//
//  Created by Sharma, Shrutesh on 11/5/15.
//  Copyright © 2015 Sharma, Shrutesh. All rights reserved.
//

#import "SSRatingBar.h"
#define BARCOUNT 10

@interface SSRatingBar(){
    

    
    
}

@property (strong, nonatomic) NSMutableArray *colorArray;
@property (nonatomic, strong) IBOutletCollection(UIView) NSMutableArray *viewsArray;
@property (nonatomic) NSInteger max;
@end

@implementation SSRatingBar



- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpDefaults];
        UILongPressGestureRecognizer *r = [[UILongPressGestureRecognizer alloc] init];
        [self addGestureRecognizer:r];
        r.minimumPressDuration = 0;
        [r addTarget:self action:@selector(recognize:)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpDefaults];
        UILongPressGestureRecognizer *r = [[UILongPressGestureRecognizer alloc] init];
        [self addGestureRecognizer:r];
        r.minimumPressDuration = 0;
        [r addTarget:self action:@selector(recognize:)];
    }
    return self;
}


- (void)setMaxValue:(NSInteger)maxValue{
    _max = maxValue;
    [self setUpViews];
}

- (void)setUpDefaults{
    self.viewsArray = [[NSMutableArray alloc]init];
    self.colorArray = [[NSMutableArray alloc]init];
}


- (void)setUpViews{
    
    for (int i = 0; i < _max; i++) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [self.colorArray addObject:color];
    }
    
    int xPosition = 0;
    for (int i = 0; i < _max; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(xPosition, 0, (self.frame.size.width/_max), self.frame.size.height)];
        view.tag = i+1;
        [self.viewsArray addObject:view];
        view.backgroundColor = [self.colorArray objectAtIndex:i];
        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
        [self addSubview:view];
        view.transform = CGAffineTransformMakeScale(0.9, 0.9);
        xPosition += (self.frame.size.width/_max);
    }
    
}


- (void)setRating:(NSInteger)tag{
    for (NSInteger x=0; x < tag; x++) {
        UIView *firstView = [self.viewsArray objectAtIndex:x];
       firstView.backgroundColor = [self.colorArray objectAtIndex:x];
    }
    for (NSInteger x = tag; x< [self.viewsArray count]; x++) {
        UIView *firstView = [self.viewsArray objectAtIndex:x];
        firstView.backgroundColor = [UIColor colorWithWhite:0.2576 alpha:1.0];
    }
    NSLog(@"percentage %.f",((float)tag/_max)*10);
}

- (void)recognize:(id)sender {
    UILongPressGestureRecognizer *gesture = sender;
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture locationInView:self];
        for (UIView *view in self.viewsArray) {
            CGRect relativeFrame = [view convertRect:view.bounds toView:self];
            int xAxis = relativeFrame.origin.x + relativeFrame.size.width;
            if (point.x >= relativeFrame.origin.x && point.x <= xAxis){
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    NSInteger end = view.tag;
                    [self setRating:end];
                } completion:^(BOOL finished) {
                    view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }];
            }
        }
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        CGPoint point = [gesture locationInView:self];
        for (UIView *view in self.viewsArray) {
            CGRect relativeFrame = [view convertRect:view.bounds toView:self];
            int xAxis = relativeFrame.origin.x + relativeFrame.size.width;
            if (point.x >= relativeFrame.origin.x && point.x <= xAxis){
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    NSInteger end = view.tag;
                    [self setRating:end];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                    } completion:^(BOOL finished) {
                        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
 
                    }];
                }];
                
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }];
            }
        }
    }else if (gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self];
        for (UIView *view in self.viewsArray) {
            
            CGRect relativeFrame = [view convertRect:view.bounds toView:self];
            int xAxis = relativeFrame.origin.x + relativeFrame.size.width;
            if (point.x >= relativeFrame.origin.x && point.x <= xAxis){
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                    NSInteger end = view.tag;
                    [self setRating:end];
                    
                } completion:^(BOOL finished) {
                    view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }];
            }
        }
    }
}



@end
