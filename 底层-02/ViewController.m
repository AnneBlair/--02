//
//  ViewController.m
//  底层-02
//
//  Created by 区块国际－yin on 16/7/30.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerReplaceMethodsHolder.h"
#import <objc/runtime.h>

#define SYSTEM_VERSION_GREATER_THAN_TO(v) ([[[UIDevice currentDevice]systemVersion]compare:v options:NSNumericSearch]!=NSOrderedAscending)
#define SYSTEM_VERSIOM_LESS_THAN(v) ([[[UIDevice currentDevice]systemVersion]compare:v options:NSNumericSearch]==NSOrderedAscending)


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self class] load];
    
//    [[[UIDevice currentDevice]systemVersion]compare:@"6.0" options:NSNumericSearch]==NSOrderedAscending
    
    //大于9.6是返回1   小于返回-1  相等为0
    NSLog(@"%ld",(long)([[[UIDevice currentDevice]systemVersion]compare:@"6.1" options:NSNumericSearch]==NSOrderedAscending));
    
    //NSOrderedAscending -1
    
    
    
}
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hackForImagePicker];
    });
}


+(void)hackForImagePicker
{
    
    
    //在6.0到6.1版本内才会执行
    if ((SYSTEM_VERSION_GREATER_THAN_TO(@"6.0"))&&(SYSTEM_VERSIOM_LESS_THAN(@"6.1")))
    {
        Method oldMethod1=class_getInstanceMethod([UIImagePickerController class], @selector(shouldAutorotate));
        Method newMethod1=class_getInstanceMethod([ImagePickerReplaceMethodsHolder class], @selector(shouldAutorotate));
        
        method_setImplementation(oldMethod1, method_getImplementation(newMethod1));
        
        
        Method oldMethod2=class_getInstanceMethod([UIImagePickerController class], @selector(preferredInterfaceOrientationForPresentation));
        Method newMethod2=class_getInstanceMethod([ImagePickerReplaceMethodsHolder class], @selector(preferredInterfaceOrientationForPresentation));
        method_setImplementation(oldMethod2, method_getImplementation(newMethod2));
        
        
    }
}

























@end
