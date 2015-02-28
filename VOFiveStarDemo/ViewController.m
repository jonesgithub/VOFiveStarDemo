//
//  ViewController.m
//  VOFiveStarDemo
//
//  Created by ValoLee on 14/12/31.
//  Copyright (c) 2014年 ValoLee. All rights reserved.
//

#import "ViewController.h"
#import "VOScoreView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *starSizeConstraint;
@property (weak, nonatomic) IBOutlet VOScoreView *scoreView;
@property (weak, nonatomic) IBOutlet UISlider *scoreSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scoreView.backgroundColor = [UIColor lightGrayColor];
    self.scoreView.score = 2.5;
    self.scoreView.starColor = [UIColor redColor];
    self.scoreView.spacing = 0;
    self.scoreView.alignment = VOStarAlignLeft;
    self.scoreSlider.value = 2.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    static int i = 0;
    i ++;
    if (i > 5) {
        i = 1;
    }
    self.starSizeConstraint.constant = 20 * i;
}

- (IBAction)changeScore:(UISlider *)sender {
    self.scoreView.score = sender.value;
}

@end
