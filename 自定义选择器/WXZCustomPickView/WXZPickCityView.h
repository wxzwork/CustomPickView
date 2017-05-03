//
//  WXZPickCityView.h
//  自定义选择器
//
//  Created by WOSHIPM on 2017/5/3.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZBasePickView.h"
@class WXZPickCityView;

@protocol  PickerCityViewDelegate<NSObject>

- (void)pickerArea:(WXZPickCityView *)pickerArea selectProvince:(NSString *)province selectCity:(NSString *)city;

@end
@interface WXZPickCityView : WXZBasePickView
@property(nonatomic, weak)id <PickerCityViewDelegate>delegate ;

/**设置默认的省市*/

-(void)setDefaultCity:(NSString *)defaultCity  DefaultProvience:(NSString *)defaultProvience;
@end
