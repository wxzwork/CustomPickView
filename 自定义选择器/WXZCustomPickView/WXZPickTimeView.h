//
//  WXZPickTimeView.h
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"
@class WXZPickTimeView;

@protocol  PickTimeViewDelegate<NSObject>
- (void)pickerTimeView:(WXZPickTimeView *)pickerTimeView selectHour:(NSInteger)hour selectMinute:(NSInteger)minute ;

@end
@interface WXZPickTimeView : WXZBasePickView
@property(nonatomic, weak)id <PickTimeViewDelegate>delegate ;

-(void)setDefaultHour:(NSInteger)hour defaultMinute:(NSInteger)minute  ;
@end
