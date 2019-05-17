//
//  ProvinceCityDistrict.m
//  chooseCity
//
//  Created by renshen on 2017/6/23.
//  Copyright © 2017年 renshen. All rights reserved.
//

#import "ProvinceCityDistrictView.h"



#define TitleHeight 40.f

#define RGBcolor(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface ProvinceCityDistrictView ()
<
UIPickerViewDataSource,
UIPickerViewDelegate
>
//UI
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *handerView;

@property (nonatomic, assign) CGFloat ViewWidth;

@property (nonatomic, assign) CGFloat ViewHeight;
//data
@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) NSArray *ProvinceArray;

@property (nonatomic, strong) NSArray *CityArray;

@property (nonatomic, strong) NSArray *districtArray;

@property (nonatomic, strong)NSDictionary *selectProvinceDic;

@property (nonatomic, strong)NSDictionary *selectCityDic;

@property (nonatomic, strong)NSDictionary *selectDistrictDic;

@end

@implementation ProvinceCityDistrictView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
-(void)initData{
    self.ViewWidth  = self.frame.size.width;
    self.ViewHeight = self.frame.size.height;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 9;
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _handerView.backgroundColor = [UIColor blackColor];
    _handerView.alpha = 0.3;
    self.data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"]];
    self.ProvinceArray = self.data[Key_Division];
    [self addSubview:self.titleView];
    [self addSubview:self.pickerView];
    _animate = YES;
    _animateTime = 0.3;
}
-(UIPickerView *)pickerView
{
    if (_pickerView!= nil) {
        return _pickerView;
    }
    
    _pickerView = [[UIPickerView alloc] initWithFrame:[self getMainViewFrame]];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    return _pickerView;
}



-(CGRect)getMainViewFrame
{
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = 40;
    rect.size.width = self.ViewWidth;
    rect.size.height = self.ViewHeight;
    return rect;
}

-(UIView *)titleView
{
    if (_titleView!=nil) {
        return _titleView;
    }
    CGRect rect;
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = self.ViewWidth;
    rect.size.height = TitleHeight;
    _titleView = [[UIView alloc] initWithFrame:rect];
    _titleView.backgroundColor = RGBcolor(249, 249, 249,1);

    UIButton * quxiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaobtn.frame = CGRectMake(5, 9, 55, 24);
    quxiaobtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [quxiaobtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaobtn setTitleColor:RGBcolor(165, 164, 160, 1) forState:UIControlStateNormal];
    quxiaobtn.backgroundColor = [UIColor clearColor];
    quxiaobtn.layer.cornerRadius = 5;
    [quxiaobtn addTarget:self action:@selector(btnDownCancel) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:quxiaobtn];
    [_titleView bringSubviewToFront:quxiaobtn];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.ViewWidth-60, 9, 55, 24);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    
    [btn setTitleColor:RGBcolor(240, 131, 0, 1) forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:btn];
    
    [_titleView bringSubviewToFront:btn];
    
    return _titleView;
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_handerView];
    [window addSubview:self];
    if (!_animate) {
        self.alpha = 1;
        return;
    }
    self.handerView.alpha = 0.f;
    if (_animateType == 0) {
        self.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        [UIView animateWithDuration:_animateTime animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 1;
            self.handerView.alpha = 0.3;
        }];
    }else{
        self.alpha = 1;
        
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
        [UIView animateWithDuration:_animateTime delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear  animations:^{
      
         self.transform = CGAffineTransformIdentity;
            self.handerView.alpha = 0.3;
        } completion:^(BOOL finished) {
          
            
            
        }];
    }
 
    
}


-(void)showPickerViewWithProvince:(NSString *)province Andcity:(NSString *)city AndDistrict:(NSString *)district;
{
    [self DefultSelct:province And:city And:district];
    [self show];
}


-(void)dismiss
{
//    if (self.SelectPCD) {
//        
//        self.SelectPCD(_selectProvinceDic,_selectCityDic,_selectDistrictDic);
//    }
    [self dismiss:_animate];
}

-(void)dismiss:(BOOL)animate
{
    
   
    if (!animate) {
        [_handerView removeFromSuperview];
        [self removeFromSuperview];
        
        return;
    }
    if (_animateType ==0) {

    [UIView animateWithDuration:_animateTime animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
        _handerView.alpha = 0;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
        [self removeFromSuperview];
    }];
        
    }else{
        
        [UIView animateWithDuration:_animateTime animations:^{
            _handerView.alpha = 0;
            self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
        } completion:^(BOOL finished) {
            [_handerView removeFromSuperview];
            [self removeFromSuperview];
        }];

        
    }
    
}

-(void)btnDown
{
    if (self.SelectPCD) {
        
        self.SelectPCD(_selectProvinceDic,_selectCityDic,_selectDistrictDic);
    }
    [self dismiss:_animate];
}

-(void)btnDownCancel
{
    
    [self dismiss:_animate];
}
-(void)DefultSelct:(NSString *)province And:(NSString *)city And:(NSString *)district{
    //通过谓词找到默认选择省市区位置
    
    //省
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"DivisionName  contains [cd] %@" , province];
    NSArray *searchArry =[self.ProvinceArray filteredArrayUsingPredicate:pred];
    if (searchArry.count>0) {
       _selectProvinceDic = searchArry[0];
    }else{
        _selectProvinceDic = self.ProvinceArray[0];
    }
    NSInteger index = [self.ProvinceArray indexOfObject:_selectProvinceDic];
    
    
    
    //市
    _CityArray = _selectProvinceDic[Key_DivisionSub];
    NSPredicate* pred2 = [NSPredicate predicateWithFormat:
                         @"DivisionName  contains [cd] %@" , city];
    NSArray *searchArry2 =[self.CityArray filteredArrayUsingPredicate:pred2];
    if (searchArry2.count>0) {
        _selectCityDic = searchArry2[0];
    }else{
        _selectCityDic = self.CityArray[0];
    }
    NSInteger index2 = [self.CityArray indexOfObject:_selectCityDic];
    
    
    //区
    _districtArray = _selectCityDic[Key_DivisionSub];
    NSPredicate* pred3 = [NSPredicate predicateWithFormat:
                          @"DivisionName  contains [cd] %@" , district];
    NSArray *searchArry3 =[self.districtArray filteredArrayUsingPredicate:pred3];
    if (searchArry3.count>0) {
        _selectDistrictDic = searchArry3[0];
    }else{
        _selectDistrictDic = self.districtArray[0];
    }
    NSInteger index3 = [self.districtArray indexOfObject:_selectDistrictDic];
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:index inComponent:0 animated:NO];
    [self.pickerView selectRow:index2 inComponent:1 animated:NO];
    [self.pickerView selectRow:index3 inComponent:2 animated:NO];
}


#pragma mark -
#pragma mark Picker Data Source Methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return self.ProvinceArray.count;
    }
    else if(component==1)
    {

            
            return self.CityArray.count;
        
    }
    else
    {
       
            return self.districtArray.count;
        
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    if (component==0)
    {
        NSDictionary *ProvinceDict = self.ProvinceArray[row];
        title = [ProvinceDict objectForKey:Key_DivisionName];
        
    }
    else if(component ==1)
    {
        NSDictionary *CityDict = self.CityArray[row];
        title = [CityDict objectForKey:Key_DivisionName];
    }
    else
    {
        NSDictionary *DistrictDict = self.districtArray[row];
        title = [DistrictDict objectForKey:Key_DivisionName];
    }
    return title ? title : @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        _selectProvinceDic = _ProvinceArray[row];
        _CityArray = _selectProvinceDic[Key_DivisionSub];
        _selectCityDic = _CityArray[0];
        _districtArray = _selectCityDic[Key_DivisionSub];
        _selectDistrictDic = _districtArray[0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
         [pickerView selectRow:0 inComponent:1 animated:NO];
         [pickerView selectRow:0 inComponent:2 animated:NO];
        
    }
    else if(component==1)
    {
        _selectCityDic = _CityArray[row];
        _districtArray = _selectCityDic[Key_DivisionSub];
        if (_districtArray.count == 0) {
            _districtArray = [NSArray arrayWithObject:_selectCityDic];
        }
        _selectDistrictDic = _districtArray[0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
    }
    else
    {
        _selectDistrictDic = _districtArray[row];
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return _rowHeight>0?_rowHeight:40;
}

@end
