//
//  SubviewObject.h
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-22.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    subviewView,
    subviewImage,
    subviewLabel
}enum_Subview;

@interface SubviewObject : NSObject

@property (nonatomic, strong) NSView *view;
@property (nonatomic, assign) enum_Subview subviewType;

@property (nonatomic, strong) NSView *superView;

- (void)initWithFrame:(CGRect)frame subviewType:(enum_Subview)type;

@end
