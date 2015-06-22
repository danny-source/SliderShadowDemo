//
//  SliderShadow.m
//  SliderShadowDemo
//
//  Created by danny on 2015/6/19.
//  Copyright (c) 2015年 danny. All rights reserved.
//

#import "SliderShadow.h"

@implementation SliderShadow
{
    UIImage *imgShadow;
    ShadowView *shadowViewRight;
    ShadowView *shadowViewLeft;
    float rightShadowValue;
    float leftShadowValue;
    ShadowPopupView *popupViewTop;
    ShadowPopupView *popupViewBottom;
    
}

@synthesize isLeftShadowHide;
@synthesize isRightShadowHide;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self constructSlider];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self constructSlider];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self bringSubviewToFront:shadowViewRight];
    [self bringSubviewToFront:shadowViewLeft];
    [self exchangeSubviewAtIndex:[self subviews].count -3 withSubviewAtIndex:[self subviews].count-1];
}

#pragma mark - UIControl touch event tracking
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Fade in and update the popup view
    CGPoint touchPoint = [touch locationInView:self];
    
    // Check if the knob is touched. If so, show the popup view
    if(CGRectContainsPoint(CGRectInset(self.thumbRect, -12.0, -12.0), touchPoint)) {
        [self positionAndUpdatePopupView];
        [self fadePopupViewInAndOut:YES];
        
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Update the popup view as slider knob is being moved
    [self positionAndUpdatePopupView];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

-(void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Fade out the popup view
    [self fadePopupViewInAndOut:NO];
    [super endTrackingWithTouch:touch withEvent:event];
}


#pragma mark - Helper methods
-(void)constructSlider {
    shadowViewRight = [[ShadowView alloc] initWithFrame:CGRectZero];
    shadowViewRight.backgroundColor = [UIColor clearColor];
    [shadowViewRight setShadowThumb:[UIImage imageNamed:@"ThumbR.png"]];
    [self addSubview:shadowViewRight];
    //
    shadowViewLeft = [[ShadowView alloc] initWithFrame:CGRectZero];
    shadowViewLeft.backgroundColor = [UIColor clearColor];
    [shadowViewLeft setShadowThumb:[UIImage imageNamed:@"ThumbL.png"]];
    [self addSubview:shadowViewLeft];
    
    popupViewTop = [[ShadowPopupView alloc] initWithFrame:CGRectZero withPopupViewToButtom:NO];
    popupViewTop.backgroundColor = [UIColor clearColor];
    [self addSubview:popupViewTop];
    //
    popupViewBottom = [[ShadowPopupView alloc] initWithFrame:CGRectZero withPopupViewToButtom:YES];
    popupViewBottom.backgroundColor = [UIColor clearColor];
    [self addSubview:popupViewBottom];

//
    isRightShadowHide = NO;    
    isLeftShadowHide = NO;
    popupViewTop.alpha = 0.0;
    popupViewBottom.alpha = 0.0;
    shadowViewRight.alpha = 0.0;
    shadowViewLeft.alpha = 0.0;
}

-(void)fadePopupViewInAndOut:(BOOL)aFadeIn {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (aFadeIn) {
        popupViewTop.alpha = 0.0;
        popupViewBottom.alpha = 0.0;
        shadowViewRight.alpha = 0.0;
        shadowViewLeft.alpha = 0.0;
        if (!isRightShadowHide) {
            popupViewTop.alpha = 1.0;
            shadowViewRight.alpha = 0.6;
        }
        if (!isLeftShadowHide) {
            popupViewBottom.alpha = 1.0;
            shadowViewLeft.alpha = 0.6;
        }
    } else {
        popupViewTop.alpha = 0.0;
        popupViewBottom.alpha = 0.0;
        shadowViewRight.alpha = 0.0;
        shadowViewLeft.alpha = 0.0;
    }
    [UIView commitAnimations];
}

-(void)positionAndUpdatePopupView {
    CGRect zeRightThumbRect = self.rightShadowThumbRect;
    CGRect rightPopupRect = CGRectOffset(zeRightThumbRect, 0, -zeRightThumbRect.size.height);//-floor(zeRightThumbRect.size.height * 0.8));
    popupViewTop.frame = CGRectInset(rightPopupRect, -15, -5);
    CGRect zeLeftThumbRect = self.leftShadowThumbRect;
    CGRect leftPopupRect = CGRectOffset(zeLeftThumbRect, 0, zeLeftThumbRect.size.height);//floor(zeLeftThumbRect.size.height * 0.8));
    popupViewBottom.frame = CGRectInset(leftPopupRect, -15, -5);
}


#pragma mark - Property accessors
-(CGRect)thumbRect {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value];
    return thumbR;
}

-(CGRect)rightShadowThumbRect {

    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds trackRect:trackRect value:rightShadowValue];
    return thumbR;
}
-(CGRect)leftShadowThumbRect {
    
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds trackRect:trackRect value:leftShadowValue];
    return thumbR;
}


- (void)setRightShadowValue:(float)value
{
    rightShadowValue = value;
    shadowViewRight.frame = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:rightShadowValue];
    [self bringSubviewToFront:shadowViewRight];
    [self setNeedsDisplay];
}
- (void)setLeftShadowValue:(float)value
{
    leftShadowValue = value;
    shadowViewLeft.frame = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:leftShadowValue];
    [self bringSubviewToFront:shadowViewLeft];
    [self setNeedsDisplay];
}

- (void)setRightShadowPopupText:(NSString*)text
{
    [popupViewTop setShadowPopupText:text];
}
- (void)setLeftShadowPopupText:(NSString*)text
{
    [popupViewBottom setShadowPopupText:text];
}


- (void)setRightShadowThumb:(UIImage*)image
{
    [shadowViewRight setShadowThumb:image];
}
- (void)setLeftShadowThumb:(UIImage*)image
{
    [shadowViewLeft setShadowThumb:image];
}


@end

@implementation ShadowView {
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ThumbR.png"]];
        imageView.frame = CGRectMake(0, 0.0f, imageView.frame.size.width, imageView.frame.size.height);
        [imageView sizeToFit];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        
    }
    return self;
}

- (void)setShadowThumb:(UIImage*)image
{
    [imageView setImage:[image copy]];
    [imageView sizeToFit];
    [self setNeedsDisplay];

}
//
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

@end


@implementation ShadowPopupView
{
    UILabel *textLabel;
    UIImageView *popupView;
}

@synthesize isPopupViewToBottom;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont boldSystemFontOfSize:15.0f];
        if (!isPopupViewToBottom) {
            popupView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popupview_label_top.png"]];
        }else {
            popupView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popupview_label_bottom.png"]];
        }
        
        popupView.alpha = 0.7;
        [self addSubview:popupView];
        
        textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = self.font;
        textLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0];

        textLabel.text = @"";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.frame = CGRectMake(0, -2.0f, popupView.frame.size.width, popupView.frame.size.height);
        [self addSubview:textLabel];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withPopupViewToButtom:(BOOL)y
{
    isPopupViewToBottom = y;
    return [self initWithFrame:frame];
}

- (void)setShadowPopupText:(NSString*)aText
{
    textLabel.text = aText;
    if (!isPopupViewToBottom) {
        popupView.image = [UIImage imageNamed:@"popupview_label_top.png"];
    }else {
        popupView.image = [UIImage imageNamed:@"popupview_label_bottom.png"];
    }
}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


