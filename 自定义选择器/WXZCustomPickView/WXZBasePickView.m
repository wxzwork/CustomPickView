//
//  WXZBasePickView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation WXZBasePickView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        _pickerViewHeight      = 250;
        
  
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.64];
        self.layer.opacity = 0.0;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        
 
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.pickerView];
        [self.contentView addSubview:self.cancelButton];
        [self.contentView addSubview:self.confirmButton];
        
        [self initPickView];
     }
    return self;
}

-(void)initPickView{
    
}

- (void)clickConfirmButton
{
    [self disMiss];
}

- (void)clickCancelButton
{
    [self disMiss];
}

 


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    
        CGRect frameContent =  self.contentView.frame;
 
        frameContent.origin.y -= self.contentView.frame.size.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
            
        } completion:^(BOOL finished) {
        }];
    
    }

- (void)disMiss
{
 
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.frame.size.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    
}



- (void)setPickerViewHeight:(CGFloat)pickerViewHeight
{
    _pickerViewHeight = pickerViewHeight;
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, pickerViewHeight);
}

- (UIView *)contentView
{
    if (!_contentView) {
 
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.pickerViewHeight)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}


- (UIPickerView *)pickerView
{
    if (!_pickerView) {
  
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,  0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
         
    }
    return _pickerView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
      
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(16, 0, 44, 44)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
  
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
    
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - self.cancelButton.frame.size.width - self.cancelButton.frame.origin.x, self.cancelButton.frame.origin.y, self.cancelButton.frame.size.width, self.cancelButton.frame.size.height)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
      
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}




@end
