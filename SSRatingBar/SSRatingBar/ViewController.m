//
//  ViewController.m
//  SSRatingBar
//
//  Created by Sharma, Shrutesh on 11/5/15.
//  Copyright © 2015 Sharma, Shrutesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SSRatingBar *ratingBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.ratingBar setMaxValue:10];
    [self.ratingBar setRating:2];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
