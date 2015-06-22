//
//  SliderShadow.h
//  SliderShadowDemo
//
//  Created by danny on 2015/6/19.
//  Copyright (c) 2015年 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderShadow : UISlider
- (void)setRightShadowValue:(float)value;
- (void)setLeftShadowValue:(float)value;
- (void)setRightShadowPopupText:(NSString*)text;
- (void)setLeftShadowPopupText:(NSString*)text;
- (void)setRightShadowThumb:(UIImage*)image;
- (void)setLeftShadowThumb:(UIImage*)image;


@property BOOL isLeftShadowHide;
@property BOOL isRightShadowHide;


@end

@interface ShadowView : UIView
- (void)setShadowThumb:(UIImage*)image;
@end

@interface ShadowPopupView : UIView
- (id)initWithFrame:(CGRect)frame withPopupViewToButtom:(BOOL)y;
@property (nonatomic, strong) UIFont *font;
@property BOOL isPopupViewToBottom;
- (void)setShadowPopupText:(NSString*)aText;
@end