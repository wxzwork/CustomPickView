//
//  WXZCustomPickView.h
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"

@class WXZCustomPickView;

@protocol  CustomPickViewDelegate<NSObject>
- (void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle;
@end

@interface WXZCustomPickView :WXZBasePickView

@property (nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, copy)NSString *defalutSelectRowStr;
@property(nonatomic, weak)id <CustomPickViewDelegate>delegate;
@end
