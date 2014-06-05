//
//  HandleRequestResult.m
//  OPerationDemo
//
//  Created by bear on 14-6-4.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HandleRequestResult.h"
#import "NetServer.h"
#import "DevicesInfoModel.h"
#import "RecordModel.h"

@implementation HandleRequestResult
+(HandleRequestResult*)shareManager
{
    static HandleRequestResult *shareManager = nil ;
    static dispatch_once_t once ;
    dispatch_once(&once , ^{
        shareManager = [[self alloc]init];
    });
    
    return shareManager ;
}
- (void)HandleData
{
    self.handleSubmitBlock = ^(id result){
       
        //处理提交数据返回的数据
        NSString *error = result[@"message_body"][@"error"];
        [NetServer shareManager].fininshBlock(error);
        
    };
    
    //处理请求返回的数据
    __unsafe_unretained HandleRequestResult *weakSelf = self;
    self.handleGetBlock = ^(id result , NSString *command){
        int commandInt = command.intValue ;
        switch (commandInt) {
            case 2074:
                [weakSelf createDevicesInfoModel:result];
                break;
                
            default:
                break;
        }
    };
}
//创建设备的数据模型
- (void)createDevicesInfoModel:(id)result
{
    //NSLog(@"%@" , result);
    NSArray *arr = result[@"message_body"][@"info"];
    NSMutableArray *mutableArr = [[NSMutableArray alloc]initWithCapacity:2];
    for (NSDictionary *dict in arr) {
        RecordModel *model = [[RecordModel alloc]initWithDataDic:dict];
      //  model.recordName = dict[@"name"];
        [mutableArr addObject:model];
    }
    [NetServer shareManager].fininshBlock(result);
    
}
@end
