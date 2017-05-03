//
//  WXZPickTimeView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZPickTimeView.h"
@interface WXZPickTimeView () <UIPickerViewDataSource, UIPickerViewDelegate>{
    UIDatePicker    *_datePicker;
}

@property (nonatomic, assign)NSInteger selectHour;

@property (nonatomic, assign)NSInteger selectMinute;


@property (nonatomic, assign)NSInteger day;
@property (nonatomic, assign)NSInteger defaultHour;
@property (nonatomic, assign)NSInteger defaultMinute;

@end

@implementation WXZPickTimeView

 

- (void)initPickView
{
    [super initPickView];
    
   
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    
    _selectHour=comp.hour;
    _selectMinute=comp.minute;
    
    
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    [self.pickerView selectRow:_selectHour inComponent:0 animated:NO];
    [self.pickerView selectRow:_selectMinute inComponent:1 animated:NO];
    
    
}
-(void)setDefaultHour:(NSInteger)hour defaultMinute:(NSInteger)minute{
 
    if (hour!=0) {
        
     _defaultHour=hour;
 
        
    }else{
        _defaultHour=_selectHour;
  
    }
    if (minute!=0) {
        
 
        _defaultMinute = minute;
 
    }else{
       
        _defaultMinute=_selectMinute;
    }
    [self.pickerView selectRow:_defaultHour inComponent:0 animated:NO];
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:_defaultMinute inComponent:1 animated:NO];
    [self refreshPickTimeViewData];
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 24;
    }else {
        return 60;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            
            break;
        case 1:
            
        default:
            break;
    }
    
    [self refreshPickTimeViewData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        if (row<10) {
            text =  [NSString stringWithFormat:@"0%zd时", row];
        }else{
            text =  [NSString stringWithFormat:@"%zd时", row];
        }
    }else if (component == 1){
        if (row<10) {
            text =  [NSString stringWithFormat:@"0%zd分", row ];
        }else{
            text =  [NSString stringWithFormat:@"%zd分", row ];
        }
    }else{
        
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    return label;
}

- (void)clickConfirmButton
{
    if ([self.delegate respondsToSelector:@selector(pickerTimeView:selectHour:selectMinute:)]) {
        
        [self.delegate pickerTimeView:self selectHour:self.selectHour selectMinute:self.selectMinute];
        
    }
    
    [super clickConfirmButton];
}



- (void)refreshPickTimeViewData
{
    self.selectHour  = [self.pickerView selectedRowInComponent:0];
    self.selectMinute = [self.pickerView selectedRowInComponent:1];
    
}




@end
