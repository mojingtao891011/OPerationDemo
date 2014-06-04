//
//  ViewController.m
//  OPerationDemo
//
//  Created by bear on 14-6-3.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ViewController.h"
#import "NetServer.h"
#import "URLOperation.h"
#import "DevicesInfoModel.h"
#import "RecordModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
        

    [[NetServer shareManager]getNeedCommand:@"2074" andNeedUserId:@"50" AndNeedBobyArrKey:@[@"req_id"] andNeedBobyArrValue:@[@"-1"] needFininshBlock:^(id result){
       
        NSLog(@"%@" , result);
        
    }needFailBlock:^(id fail){
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
