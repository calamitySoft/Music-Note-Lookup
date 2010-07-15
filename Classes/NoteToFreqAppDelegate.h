//
//  NoteToFreqAppDelegate.h
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright calamitySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteToFreqAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
