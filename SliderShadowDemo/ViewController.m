//
//  ViewController.m
//  SliderShadowDemo
//
//  Created by danny on 2015/6/19.
//  Copyright (c) 2015年 danny. All rights reserved.
//

#import "ViewController.h"
#import "SliderShadow.h"

@interface ViewController ()

@property (nonatomic,strong) IBOutlet SliderShadow *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[_slider setRightShadowThumb:[UIImage imageNamed:@"ThumbR.png"]];
    //[_slider setLeftShadowThumb:[UIImage imageNamed:@"ThumbL.png"]];
    [_slider setRightShadowValue:6.0f];
    [_slider setRightShadowPopupText:@"Right"];
    [_slider setLeftShadowValue:3.0f];
    [_slider setLeftShadowPopupText:@"Left"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(SliderShadow*)sender
{

}
@end
