//
//  NoteToFreqAppDelegate.h
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface NoteToFreqAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, AppViewControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	NSMutableArray *noteBank;	// The key to the universe
	NSArray *noteLetterArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *noteBank;
@property (nonatomic, retain) NSArray *noteLetterArray;

-(NSString *)freqToNote:(float)freq;
-(NSInteger)freqToNoteEQScale:(float)freq;
-(NSString *)numStepsToNoteName:(NSInteger)numHalfStepsRelative;

-(float)noteToFreq:(NSInteger)note;
-(float)noteToFreqEQScale:(NSInteger)note;


@end
