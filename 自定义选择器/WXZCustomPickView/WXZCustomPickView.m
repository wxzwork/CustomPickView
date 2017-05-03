//
//  WXZCustomPickView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZCustomPickView.h"



@interface WXZCustomPickView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.选中的字符串 */
@property (nonatomic, strong, nullable)NSString *selectedTitle;

@end

@implementation WXZCustomPickView

 
- (void)initPickView
{
    [super initPickView];
    
    _dataArray=[NSMutableArray mutableCopy];
 
  
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
    
    
    
}

-(void)setDefalutSelectRowStr:(NSString *)defalutSelectRowStr{
    _defalutSelectRowStr=defalutSelectRowStr;
    
    for (NSInteger i = 0; i<_dataArray.count; i++) {
        
        
        if ([_dataArray[i] isEqualToString:_defalutSelectRowStr]) {
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:i inComponent:0 animated:NO];
            
        }
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return self.frame.size.width;
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTitle = self.dataArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor =[UIColor grayColor];
        }
    }
 
    UILabel *label = [[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment = 1;
  
    label.text=self.dataArray[row];
    
        return label;
    
    
    
}
#pragma mark -点击确定按钮
- (void)clickConfirmButton
{
    [self.delegate customPickView:self selectedTitle:self.selectedTitle];
 
    [super clickConfirmButton];
}


- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    _selectedTitle = dataArray.firstObject;
    [self.pickerView reloadAllComponents];
    
}



@end
