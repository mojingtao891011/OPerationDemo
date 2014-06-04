//
//  URLOperation.m
//  iSpace
//
//  Created by bear on 14-6-3.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "URLOperation.h"
#import "SBJsonWriter.h"
#import "HandleRequestResult.h"
#import "NetServer.h"

#define  SVR_URL  @"http://115.29.199.95:21000/iSpaceSvr/ios"
@implementation URLOperation
- (id)initWithParam:(NSMutableDictionary*)paramDict andCommand:(NSString*)command
{
    if (self = [self init]) {
        
        _data = [NSMutableData data];
        _command = command ;
        [self _initRequest:paramDict ];
                
    }
    return self ;
}
- (void)_initRequest:(NSMutableDictionary*)paramDict
{
    //把字典转化为json
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *jsonStr = [jsonWriter stringWithObject:paramDict];
    
    
    _request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:SVR_URL]];
    [_request setHTTPMethod:@"POST"];
    [_request setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    [_request setTimeoutInterval:60];
    
        
}
- (void)start
{
    if (![self isCancelled]) {
        _connection = [NSURLConnection connectionWithRequest:_request delegate:self];
        while (_connection != nil) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            static int i = 0 ;
            NSLog(@"%d" ,i++);
        }
        
}
}
#pragma mark------NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (_data == nil) {
        _data = [NSMutableData data];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    id json = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    //把从网络获取的数据交给HandleRequestResult类处理
    [[HandleRequestResult shareManager] HandleData];
    if ([_command isEqualToString:@"0"]) {
        [HandleRequestResult shareManager].handleSubmitBlock(json);
    }else{
        [HandleRequestResult shareManager].handleGetBlock(json , _command);
    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail");
    [NetServer shareManager].failBlock(@"网络请求失败");
}
@end
