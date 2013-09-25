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
    IBOutlet NSTextField *txt_x;
    IBOutlet NSTextField *txt_y;
    IBOutlet NSTextField *txt_w;
    IBOutlet NSTextField *txt_h;
}

- (IBAction)addAdaptiveRootView:(id)sender;


@end
