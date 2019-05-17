//
//  ProvinceCityDistrict.h
//  chooseCity
//
//  Created by renshen on 2017/6/23.
//  Copyright © 2017年 renshen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimateType) {
    AnimateTypeCenter = 0,
    AnimateTypebottom =1,
    
};
#define Key_Division        @"Division"
#define Key_DivisionCode    @"DivisionCode"
#define Key_DivisionName    @"DivisionName"
#define Key_DivisionSub     @"DivisionSub"
@interface ProvinceCityDistrictView : UIView

@property (nonatomic) NSInteger rowHeight;//row高度

@property (nonatomic)BOOL animate;//是否需要动画

@property (nonatomic)AnimateType animateType;//动画类型

@property (nonatomic) NSTimeInterval animateTime;//动画事件

@property (nonatomic, copy) void(^SelectPCD)(NSDictionary *provinceDIC,NSDictionary *cityDIC,NSDictionary *districtDIC);

-(instancetype)initWithFrame:(CGRect)frame;

//显示方法
-(void)showPickerViewWithProvince:(NSString *)province Andcity:(NSString *)city AndDistrict:(NSString *)district;

@end
