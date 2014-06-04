//
//  DevicesInfoModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-15.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "DevicesInfoModel.h"

@implementation DevicesInfoModel
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                           
                           @"dev_idx" :                     @"dev_idx" ,
                           @"dev_online" :                @"dev_online" ,
                           @"dev_sn" :                       @"dev_sn",
                           @"dev_city" :                     @"dev_city",
                           @"dev_name" :                  @"dev_name",
                           
                           };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
    NSDictionary *alarmDict = dataDic[@"alarm_info"] ;
    NSString *totalStr = alarmDict[@"total"] ;
    int total = totalStr.intValue ;
    //说明设备有设定闹钟（total != 0）
    if (total != 0) {
        NSArray *alarmInfoList = alarmDict[@"list"];
        for (NSDictionary *alarmInfoDict in alarmInfoList) {
        self.alermInfo = [[AlarmInfoModel alloc]initWithDataDic:alarmInfoDict];
        if (_alermInfoArr == nil) {
            _alermInfoArr = [[NSMutableArray alloc]initWithCapacity:4];
        }
        [_alermInfoArr addObject:self.alermInfo];
        //通过index排序
            NSSortDescriptor *indexSort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
            NSArray *indexSortArray = [NSArray arrayWithObject:indexSort];
            NSArray *sortedArray = [_alermInfoArr sortedArrayUsingDescriptors:indexSortArray];
            [_alermInfoArr removeAllObjects];
            [_alermInfoArr addObjectsFromArray:sortedArray];
            
    }

    }
    //fm信息
    int fmTotal = [dataDic[@"fm_info"][@"total"] intValue] ;
    if (fmTotal != 0) {
        self.fm_list = dataDic[@"fm_info"][@"list"];
    }
    //管理员信息
    self.owerInfo = [[FriendInfoModel alloc]initWithDataDic:dataDic[@"owner"]];
    //密友信息
    self.friendInfo = [[FriendInfoModel alloc]initWithDataDic:dataDic[@"friend"]];
}


@end
