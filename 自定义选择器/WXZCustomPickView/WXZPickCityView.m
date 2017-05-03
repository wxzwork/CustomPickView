//
//  WXZPickCityView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/5/3.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZPickCityView.h"
@interface WXZPickCityView()<UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong, nullable)NSArray *areaDataSource;

@property (nonatomic, strong, nullable)NSMutableArray *provinceArray;

@property (nonatomic, strong, nullable)NSMutableArray *cityArray;

@property (nonatomic, strong, nullable)NSMutableArray *selectedArray;//当前选中的数组

@property (nonatomic, strong, nullable)NSString *selectProvince;

@property (nonatomic, strong, nullable)NSString *selectCity;

@end

@implementation WXZPickCityView


- (void)initPickView
{
    [super initPickView];
    for (NSDictionary *dic in self.areaDataSource) {
        [self.provinceArray addObject:dic[@"state"]];
    }
    
    NSMutableArray *citysArr = [NSMutableArray arrayWithArray:[self.areaDataSource firstObject][@"cities"]];
    
    
    for (NSDictionary *dic in citysArr) {
        [self.cityArray addObject:dic[@"city"]];
    }
    
    self.selectProvince = self.provinceArray[0];
    self.selectCity = self.cityArray[0];
    
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}

//设置默认显示的省市
-(void)setDefaultCity:(NSString *)defaultCity DefaultProvience:(NSString *)defaultProvience{
    
    for (NSInteger i = 0; i<_provinceArray.count; i++) {
        
        if ([_provinceArray[i] isEqualToString:defaultProvience]) {
            
            [self.pickerView selectRow:i inComponent:0 animated:NO];
            self.selectedArray = self.areaDataSource[i][@"cities"];
            
            [self.cityArray removeAllObjects];
            [self.selectedArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.cityArray addObject:obj[@"city"]];
            }];
            for (NSInteger j= 0; j<_cityArray.count; j++) {
                
                if ([defaultCity isEqualToString:_cityArray[j]]) {
                    
                    [self.pickerView selectRow:i inComponent:0 animated:NO];
                    [self.pickerView reloadComponent:1];
                    [self.pickerView selectRow:j inComponent:1 animated:NO];
                    [self refreshSelectAreaData];
                }
            }
        }
        
        
    }
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else  {
        return self.cityArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.selectedArray = self.areaDataSource[row][@"cities"];
        
        [self.cityArray removeAllObjects];
        [self.selectedArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityArray addObject:obj[@"city"]];
        }];
        
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        
    }else if (component == 1) {
        if (self.selectedArray.count == 0) {
            self.selectedArray = [self.areaDataSource firstObject][@"cities"];
        }
        
    }else{
    }
    
    [self refreshSelectAreaData];
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
    NSString *text;
    if (component == 0) {
        text =  self.provinceArray[row];
    }else if (component == 1){
        text =  self.cityArray[row];
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
    
    [self.delegate pickerArea:self selectProvince:self.selectProvince selectCity:self.selectCity];
    
    [super clickConfirmButton];
}


- (void)refreshSelectAreaData
{
    NSInteger provienceIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:1];
    
    self.selectProvince = self.provinceArray[provienceIndex];
    self.selectCity = self.cityArray[cityIndex];
    
    
}



- (NSArray *)areaDataSource
{
    if (!_areaDataSource) {
        NSString *path = [[NSBundle bundleForClass:[WXZPickCityView class]] pathForResource:@"area" ofType:@"plist"];
        _areaDataSource = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _areaDataSource;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}



- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}



@end
