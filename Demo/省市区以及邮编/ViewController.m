//
//  ViewController.m
//  省市区以及邮编
//
//  Created by renshen on 2017/6/27.
//  Copyright © 2017年 renshen. All rights reserved.
//

#import "ViewController.h"
#import "ProvinceCityDistrictView.h"

#define  UISCreenW  [UIScreen mainScreen].bounds.size.width

#define  UISCreenH  [UIScreen mainScreen].bounds.size.height


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *province;

@property (weak, nonatomic) IBOutlet UILabel *city;

@property (weak, nonatomic) IBOutlet UILabel *district;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)touch:(id)sender {
    
    ProvinceCityDistrictView * _pcdView = [[ProvinceCityDistrictView alloc] initWithFrame:CGRectMake(5, UISCreenH-255, UISCreenW-10, 250) ];
    
    _pcdView.animateType = AnimateTypebottom;
    _pcdView.animateTime = 0.5;
    [_pcdView showPickerViewWithProvince:_province.text Andcity:_city.text AndDistrict:_district.text];
    
    __weak typeof(self) weakself =  self;
    _pcdView.SelectPCD = ^(NSDictionary *provinceDIC, NSDictionary *cityDIC, NSDictionary *districtDIC) {
        NSLog(@"选择省市区");
        weakself.province.text = provinceDIC[Key_DivisionName];
        weakself.city.text = cityDIC[Key_DivisionName];
        weakself.district.text = districtDIC[Key_DivisionName];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",weakself.province,weakself.city,weakself.district]);
        NSLog(@"zipCode----%@",cityDIC[Key_DivisionCode]);
       
    };

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
