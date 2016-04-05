//
//  timeTabelservice.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "timeTabelservice.h"
#import "AFNetworking.h"


#define TIMETABEL_URL @"http://localhost:8888/iuu-teacher/index.php/home/classTabel/classTabel"

@implementation timeTabelservice

+ (void)timeTabelClass:(int)classid andSubject:(NSString *)subject andSuccess:(void (^)(NSArray *))success andFail:(void (^)(NSString *))fail{
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *urlPath = [NSString stringWithFormat:@"%@?class=%d",TIMETABEL_URL,classid];
    
    [manage GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        {
//            code = 200;
//            data =     (
//                        {
//                            "iuu_class_class_id" = 1;
//                            "timetable_eight" = "\U82f1\U8bed";
//                            "timetable_five" = "\U82f1\U8bed";
//                            "timetable_four" = "\U8bed\U6587";
//                            "timetable_id" = 1;
//                            "timetable_one" = "\U8bed\U6587";
//                            "timetable_seven" = "\U8bed\U6587";
//                            "timetable_six" = "\U6570\U5b66";
//                            "timetable_three" = "\U6570\U5b66";
//                            "timetable_two" = "\U82f1\U8bed";
//                            "timetable_week" = 1;
//                        },
//                        {
//                            "iuu_class_class_id" = 1;
//                            "timetable_eight" = "\U82f1\U8bed";
//                            "timetable_five" = "\U82f1\U8bed";
//                            "timetable_four" = "\U8bed\U6587";
//                            "timetable_id" = 2;
//                            "timetable_one" = "\U8bed\U6587";
//                            "timetable_seven" = "\U8bed\U6587";
//                            "timetable_six" = "\U6570\U5b66";
//                            "timetable_three" = "\U6570\U5b66";
//                            "timetable_two" = "\U82f1\U8bed";
//                            "timetable_week" = 2;
//                        }
//                        );
//        }
//
        
        
        NSDictionary *dic = responseObject;
        NSLog(@"%@",dic);
        
        NSArray *tmpArr1 = [dic objectForKey:@"data"];
        NSMutableArray *arr1 = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",nil];
        for (int i = 0; i < tmpArr1.count; i ++) {
            
            NSDictionary *tmpDic1 = tmpArr1[i];
            
            int week = (int)[tmpDic1 objectForKey:@"timetable_week"];
            
            [arr1 replaceObjectAtIndex:week withObject:tmpDic1];
            
            
//            NSMutableArray * tmpArr2 = [NSMutableArray arrayWithCapacity:0];
//            if ([[tmpDic1 objectForKey:@"timetable_one"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_tow"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_three"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_four"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_five"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_six"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
//            if ([[tmpDic1 objectForKey:@"timetable_one"]isEqualToString:subject]) {
//                [tmpArr2 addObject:subject];
//            }else{
//                [tmpArr2 addObject:@""];
//            }
            
        }
        success (arr1);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail (@"查询失败");
    }];
}
@end
