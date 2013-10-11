//
//  AdapterWindow.h
//  UIAdaptiveFrameGenerator
//
//  Created by wyq on 13-9-25.
//  Copyright (c) 2013年 cloudayc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AdapterWindow : NSWindow
{
    IBOutlet NSTabView *menuView;
    
    IBOutlet NSTextField *txt_x;
    IBOutlet NSTextField *txt_y;
    IBOutlet NSTextField *txt_w;
    IBOutlet NSTextField *txt_h;
    
    NSMutableArray *_screens;
}

- (IBAction)addScreen:(id)sender;

- (IBAction)addAdaptiveRootView:(id)sender;


@end
