//
//  sercice.h
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sercice : NSObject

+(void)GETRequiceAFNetworkingWithURL:(NSString *)url parameters:(NSMutableDictionary *)dic  successHUDTitle:(NSString *)title faileHUDTitle:(NSString *)faileTitle   sendMessage:(void (^)(NSDictionary *responseObject))success;

+(void)POSTRequiceAFNetworkingWithURL:(NSString *)url parameters:(NSMutableDictionary *)dic  successHUDTitle:(NSString *)title faileHUDTitle:(NSString *)faileTitle   sendMessage:(void (^)(NSDictionary *responseObject))success;

@end
