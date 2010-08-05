//
//  NoteToFreqAppDelegate.m
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright calamitySoft 2010. All rights reserved.
//

#import "NoteToFreqAppDelegate.h"
#import "Constants.h"


@implementation NoteToFreqAppDelegate

@synthesize window;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the tab bar controller's view to the window and display.
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark Note Delegation

-(NSString *)freqToNote:(float)freq {
	NSString *retStr = [NSString stringWithFormat:@"freqToNote: %1.4f", freq];
	return retStr;
}

/*
 *	noteToFreq:
 *
 *	Arguments:	(NSInteger note) Number representing half-steps up from A0 plus octaves*12.
 *	Returns:	(float) Hertz value of note.
 */
-(float)noteToFreq:(NSInteger)note {
	float retVal = [self noteToFreqEQScale:note];
	return retVal;
}

/*
 *	noteToFreqEQScale:
 *
 *	Purpose:	Implements formula for finding frequency based on the equal tempered scale (i.e. not "just").
 *	Strategy:	Frequency = fixedNote * a^n
 *					fixedNote = kFixedNoteA = 440 Hz
 *					a = the twelfth root of 2
 *					n = number of half steps from fixedNote
 *	Returns:	(float) Hertz value of note.
 *
 *	Resources:	Frequency formula http://www.phy.mtu.edu/~suits/NoteFreqCalcs.html
 */
-(float)noteToFreqEQScale:(NSInteger)note {
	
	// A4 (kFixedNoteA 440Hz) is 57 half steps above C0
	NSInteger numHalfSteps = note - 57;
	
	// frequency = fixedNote * a^n, where n = number of half steps from fixedNote
	float retVal = kFixedNoteA * pow(M_12RT_OF_2, numHalfSteps);
	return retVal;
	
//	NSLog(@"FREQUENCY %1.2f, %d", retVal, numHalfSteps);	
//	return [[NSNumber numberWithInteger:note] floatValue];
}



@end
