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

        NSDictionary *dic = responseObject;
        NSArray *tmpArr1 = [dic objectForKey:@"data"];
        
        NSArray *tmparr2 = @[@"timetable_one",@"timetable_two",@"timetable_three",@"timetable_four",@"timetable_five",@"timetable_six",@"timetable_seven",@"timetable_eight",@"9",@"10"];
        
        NSMutableArray * tmpArr2 = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < 10; i ++) {
            
            [tmpArr2 addObject:[NSString stringWithFormat:@"%d",i +1]];
        
            for (int j = 0; j < tmpArr1.count; j ++) {
                
                NSDictionary *tmpDic1 = tmpArr1[j];
                
                if ([[tmpDic1 objectForKey:tmparr2[i]]isEqualToString:subject]) {
                    
                    [tmpArr2 addObject:subject];
                    
                }else{
                    
                    [tmpArr2 addObject:@""];
                    
                }
            }
        }
        
        success (tmpArr2);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail (@"查询失败");
    }];
}
@end