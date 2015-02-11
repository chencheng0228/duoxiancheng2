//
//  ViewController.m
//  TestGCD
//
//  Created by admin on 14-12-10.
//  Copyright (c) 2014年 ___CC___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	
    
   //================================dispatch_group_async的用法======================
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");  
    });  
    
    
    
   //==================================== dispatch_async的用法 =============================
    
    //获取一个线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //TODO:
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //TODO:
        });
    });
    
    
    
   //================================dispatch_barrier_async的使用=======================
    
   // dispatch_barrier_async是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
    
     dispatch_queue_t que = dispatch_queue_create("queueTest.ccom.yc", DISPATCH_QUEUE_CONCURRENT);
    
     dispatch_async(que, ^{
        [NSThread sleepForTimeInterval:2];
         NSLog(@"dispatch_async1");
    });
    
    dispatch_async(que, ^{
        [NSThread sleepForTimeInterval:4];
         NSLog(@"dispatch_async2");
    });
    
    dispatch_barrier_async(que, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_barrier_async");
        });
    
    dispatch_async(que, ^{
        [NSThread sleepForTimeInterval:1];
         NSLog(@"dispatch_async3");
    });
    
    
    //=============================dispatch_apply的使用==================================
    //执行某个代码片段N次。
    dispatch_queue_t globalQ = dispatch_queue_create("queueTest.com.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(5, globalQ, ^(size_t index) {
    // 执行5次
    });
    
   
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
