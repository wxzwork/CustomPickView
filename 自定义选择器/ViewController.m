//
//  ViewController.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/4/28.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "ViewController.h"
#import "WXZPickDateView.h"
#import "WXZPickCityView.h"
#import "WXZPickTimeView.h"
#import "WXZCustomPickView.h"
@interface ViewController ()<PickerDateViewDelegate,PickerCityViewDelegate,PickTimeViewDelegate,CustomPickViewDelegate>{
    UIButton *dateButton;
    UIButton *selectAreabutton;
    UIButton *selectTimeButton;
    UIButton *singlePickViewSelectButton;
    BOOL isShowDay;//是否显示日信息
}
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UITextField *textField1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//     Do any additional setup after loading the view, typically from a nib.
    dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    dateButton.frame=CGRectMake(50, 100, 200, 50);
    [dateButton setTitle:@"选择日期" forState:UIControlStateNormal];
    [self.view addSubview:dateButton];
    [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateButton addTarget:self action:@selector(pickViewSelect:) forControlEvents:UIControlEventTouchUpInside];
    dateButton.tag = 1000;
    
      selectAreabutton=[UIButton buttonWithType:UIButtonTypeCustom];
    selectAreabutton.frame=CGRectMake(50, 200, 200, 50);
    [selectAreabutton setTitle:@"选择地区" forState:UIControlStateNormal];
    [self.view addSubview:selectAreabutton];
    [selectAreabutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAreabutton addTarget:self action:@selector(pickViewSelect:) forControlEvents:UIControlEventTouchUpInside];
    selectAreabutton.tag = 1001;
    selectTimeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    selectTimeButton.frame=CGRectMake(50, 300, 200, 50);
    [selectTimeButton setTitle:@"选择时间" forState:UIControlStateNormal];
    [self.view addSubview:selectTimeButton];
    [selectTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectTimeButton addTarget:self action:@selector(pickViewSelect:) forControlEvents:UIControlEventTouchUpInside];
    selectTimeButton.tag = 1002;
    
    singlePickViewSelectButton=[UIButton buttonWithType:UIButtonTypeCustom];
    singlePickViewSelectButton.frame=CGRectMake(50, 400, 200, 50);
    [singlePickViewSelectButton setTitle:@"单个数据选择器" forState:UIControlStateNormal];
    [self.view addSubview:singlePickViewSelectButton];
    [singlePickViewSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [singlePickViewSelectButton addTarget:self action:@selector(pickViewSelect:) forControlEvents:UIControlEventTouchUpInside];
    singlePickViewSelectButton.tag = 1003;
    isShowDay=YES;
 

}


-(void)pickViewSelect:(UIButton *)button{
    if (button.tag==1000) {
         isShowDay=YES;
           WXZPickDateView *pickerDate = [[WXZPickDateView alloc]init];
    
            
            [pickerDate setIsAddYetSelect:YES];//是否显示至今选项
            [pickerDate setIsShowDay:isShowDay];//是否显示日信息
            [pickerDate setDefaultTSelectYear:2017 defaultSelectMonth:6 defaultSelectDay:10];//设定默认显示的日期
          [pickerDate setDelegate:self];
           [pickerDate show];
    }else if (button.tag==1001){
        WXZPickCityView *pickerArea = [[WXZPickCityView alloc]init];
  
        [pickerArea setDelegate:self];
        
        [pickerArea setDefaultCity:@"上海" DefaultProvience:@"上海"];
 
        [pickerArea show];
        [self.view endEditing:YES];
    }else if (button.tag==1002){
        WXZPickTimeView *pickerArea = [[WXZPickTimeView alloc]init];
        
        [pickerArea setDelegate:self];
        
        [pickerArea setDefaultHour:14 defaultMinute:20];
        
        [pickerArea show];
        [self.view endEditing:YES];
    }else{
        NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"2k以下",@"2k-5k",@"5k-10k",@"10k-15k",@"15k-25k",@"25k-50k",@"50k以上", nil];
        
        WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
 
        [pickerSingle setDataArray:arrayData];
        [pickerSingle setDefalutSelectRowStr:arrayData[0]];
 
        
        [pickerSingle setDelegate:self];
        
        [pickerSingle show];
        [self.view endEditing:YES];
   
    }
}

-(void)pickerDateView:(WXZBasePickView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    NSLog(@"选择的日期是：%ld %ld %ld",year,month,day);
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    if (isShowDay==YES) {
        if (year>comp.year) {
             [dateButton setTitle:@"至今" forState:UIControlStateNormal];
        }else{
        [dateButton setTitle:[NSString stringWithFormat:@"%ld年 %ld月 %ld日",year,month,day] forState:UIControlStateNormal];
        }
    }else{
        if (year>comp.year) {
            [dateButton setTitle:@"至今" forState:UIControlStateNormal];
        }else{
        [dateButton setTitle:[NSString stringWithFormat:@"%ld年 %ld月",year,month] forState:UIControlStateNormal];
        }
    }
    
}

-(void)pickerArea:(WXZPickCityView *)pickerArea selectProvince:(NSString *)province selectCity:(NSString *)city{
    NSLog(@"省市的选择%@ %@",province,city);
    [selectAreabutton setTitle:[NSString stringWithFormat:@"%@  %@",province,city] forState:UIControlStateNormal];
}

-(void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle{
    NSLog(@"选择%@",selectedTitle);
    [singlePickViewSelectButton setTitle:selectedTitle forState:UIControlStateNormal];
}
-(void)pickerTimeView:(WXZPickTimeView *)pickerTimeView selectHour:(NSInteger)hour selectMinute:(NSInteger)minute{
    NSLog(@"选择的时间：%ld %ld",hour,minute);
    if (hour<10&minute<10) {
         [selectTimeButton setTitle:[NSString stringWithFormat:@"0%ld时 0%ld分",hour,minute] forState:UIControlStateNormal];
    }else if (hour<10){
        [selectTimeButton setTitle:[NSString stringWithFormat:@"0%ld时 %ld分",hour,minute] forState:UIControlStateNormal];
    }else if (minute<10){
         [selectTimeButton setTitle:[NSString stringWithFormat:@"%ld时 0%ld分",hour,minute] forState:UIControlStateNormal];
    }else{
         [selectTimeButton setTitle:[NSString stringWithFormat:@"%ld时 %ld分",hour,minute] forState:UIControlStateNormal];
    }
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
