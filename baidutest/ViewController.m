//
//  ViewController.m
//  baidutest
//
//  Created by CMiOS on 2017/6/30.
//  Copyright © 2017年 CMiOS. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>



@interface ViewController ()<BMKPoiSearchDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mapView;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 30)];
    [btn setTitle:@"xxx" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(startPOISearch) forControlEvents:UIControlEventTouchDown];
    
}

/**
 开始周边检索
 */
-(void)startPOISearch{
    BMKPoiSearch *searcher = [[BMKPoiSearch alloc]init];
    searcher.delegate = self;
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageIndex = 1;
    option.pageCapacity = 10;
    NSString *city = @"武汉";
    option.city = city;
    option.keyword = @"彩票";
    BOOL flag = [searcher poiSearchInCity:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }

}


/**
 周边检索的查询结果

 @param searcher don't know
 @param poiResultList 包含的返回结果
 @param error 错误信息
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
       
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
