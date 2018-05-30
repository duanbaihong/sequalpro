//
//  PSMTabDragWindowController.h
//  PSMTabBarControl
//
//  Created by Kent Sutherland on 6/18/07.
//  Copyright 2007 Kent Sutherland. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSMTabBarControl.h"

#define kPSMTabDragWindowAlpha 0.75f
#define kPSMTabDragAlphaInterval 0.15f

@class PSMTabDragView;

@interface PSMTabDragWindowController : NSWindowController {
	PSMTabBarTearOffStyle _tearOffStyle;
	PSMTabDragView *_view;
	NSAnimation *_animation;
	NSTimer *_timer;
	
	BOOL _showingAlternate;
	NSRect _originalWindowFrame;
}
- (id)initWithImage:(NSImage *)image styleMask:(NSUInteger)styleMask tearOffStyle:(PSMTabBarTearOffStyle)tearOffStyle initialAlpha:(CGFloat)initialAlpha;

- (NSImage *)image;
- (NSImage *)alternateImage;
- (void)setAlternateImage:(NSImage *)image;
- (BOOL)isAnimating;
- (void)switchImages;
- (void)animateTimer:(NSTimer *)timer;
@end
