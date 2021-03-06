//
//  Utility.m
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import "Utility.h"

#import "AppDelegate.h"

@implementation Utility

+ (Utility *)sharedUtility
{
    static Utility *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[Utility alloc] init];
    });
    return instace;
}

+(CGRect)AFGRectMake:(CGFloat)x y:(CGFloat)y width:(CGFloat)w height:(CGFloat)h
{
    AppDelegate *delegate = [NSApplication sharedApplication].delegate;
    CGSize winSize = [delegate.window.contentView bounds].size;
    NSRect frame = NSMakeRect(x, winSize.height - y, w, h);
    return frame;
}

@end
