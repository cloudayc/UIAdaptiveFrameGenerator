//
//  Utility.h
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Utility : NSObject

@property (nonatomic) NSPoint currentOpViewOrigin;
@property (nonatomic) NSSize currentOpViewSize;
@property (nonatomic) NSRect currentOpViewRect;

+ (Utility *)sharedUtility;


+(CGRect)AFGRectMake:(CGFloat)x y:(CGFloat)y width:(CGFloat)w height:(CGFloat)h;

@end
