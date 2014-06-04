//
//  URLOperation.h
//  iSpace
//
//  Created by bear on 14-6-3.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLOperation : NSOperation<NSURLConnectionDataDelegate , NSURLConnectionDelegate>
{
    NSMutableURLRequest *_request ;
    NSURLConnection *_connection ;
    NSMutableData *_data ;
    NSString *_command ;
    
}

- (id)initWithParam:(NSMutableDictionary*)paramDict andCommand:(NSString*)command;

@end
