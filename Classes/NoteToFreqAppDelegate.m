//
//  NoteToFreqAppDelegate.m
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import "NoteToFreqAppDelegate.h"
#import "Constants.h"


@implementation NoteToFreqAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize noteBank, noteLetterArray;

- (NSArray *)getNoteLetterArray {
	return noteLetterArray;
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the tab bar controller's view to the window and display.
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	noteLetterArray = [[NSArray arrayWithObjects:
							  @"C", @"C# / Db",
							  @"D", @"D# / Eb",
							  @"E",
							  @"F", @"F# / Gb",
							  @"G", @"G# / Ab",
							  @"A", @"A# / Bb",
							  @"B",
							  nil] retain];

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
	[noteBank release];
	[noteLetterArray release];
    [tabBarController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark Note Delegation


/*
 *	freqToNote:
 *
 *	Purpose:	Convert a frequency to a musical note.
 *	Arguments:	(float freq) Hertz value of target note.
 *	Returns:	(NSString) Note name, including #/b if necessary.
 */
-(NSString *)freqToNote:(float)freq {
	NSInteger numHalfStepsFromA4 = [self freqToNoteEQScale:freq];
	NSString *retStr = [self numStepsToNoteName:numHalfStepsFromA4];
	return retStr;
}


/*
 *	noteToFreqEQScale:
 *
 *	Purpose:	Implements formula for finding frequency based on the equal tempered scale (i.e. not "just").
 *	Strategy:	Frequency = fixedNote * a^n
 *					fixedNote = kFixedNoteA = 440 Hz
 *					a = the twelfth root of 2
 *					n = number of half steps from fixedNote
 *				Above formula derives ours as follows:
 *					freq = fixed * a^n
 *					freq/fixed = a^n
 *					n = log{a}(f)			// log base a of f, where f = frequency/fixedNote
 *					n = log(f)/log(a)		// log base 10 of f / log base 10 of a
 *	Arguments:	(float) Hertz value of note.
 *	Returns:	(NSInteger) Number representing half-steps from A4, positive or negative.
 *
 *	Resources:	Frequency formula http://www.phy.mtu.edu/~suits/NoteFreqCalcs.html
 *				Logarithm usage http://en.wikipedia.org/wiki/Logarithm
 */
-(NSInteger)freqToNoteEQScale:(float)freq {
	double log_f = log(freq/kFixedNoteA);
	double log_a = log(M_12RT_OF_2);
	double n = log_f/log_a;
	/* NSLog(@"freq=%1.4f, n=%1.4f", freq, n);	*/

	// Frequencies are not guaranteed notes, so we must round to the nearest
	//   whole number (half step).
	// Must round() first because numberWithInteger just takes the floor of n.
	n = round(n);
	NSInteger numHalfSteps = [[NSNumber numberWithInteger:n] integerValue];
	return numHalfSteps;
}


/*
 *	numStepsToNoteName:
 *
 *	Purpose:	Convert number of half-steps from A4 to a note name.
 *	Arguments:	(NSInteger) Number representing half-steps from A4, positive or negative.
 *	Returns:	(NSString) Note name, including #/b if necessary.
 */
-(NSString *)numStepsToNoteName:(NSInteger)numHalfStepsRelative {
	
	// A4 (kFixedNoteA 440Hz) is 57 half steps above C0
	NSInteger numHalfStepsAbsolute = numHalfStepsRelative + kFixedNoteHalfSteps;
	NSNumber *n = [NSNumber numberWithUnsignedInteger:[noteLetterArray count]];
	NSInteger noteLetterArrayCount = [n integerValue];
	NSLog(@"noteLetterArrayCount=%d", noteLetterArrayCount);
	
	NSInteger note = numHalfStepsAbsolute % noteLetterArrayCount;
	NSInteger octave = numHalfStepsAbsolute / noteLetterArrayCount;
	NSLog(@"halfSteps=%d, note=%d, octave=%d", numHalfStepsAbsolute, note, octave);
	
	// Account for frequencies below C0.
	// ([NSArray objectAtIndex:uint] requires positive int.)
	if (note<0) {
		note += noteLetterArrayCount;
	}

//	Do I shorten the name of the note? (i.e. 'F# / Gb' -> 'F#')
#if SHORTEN_FOUND_NOTE
	NSString *noteLetter;
	if ([[noteLetterArray objectAtIndex:note] length] > 1) {
		noteLetter = [[noteLetterArray objectAtIndex:note] substringToIndex:2];
	} else {
		noteLetter = [noteLetterArray objectAtIndex:note];
	}
#else
	NSString *noteLetter = [noteLetterArray objectAtIndex:note];
#endif
	
	NSString *noteName = [NSString stringWithFormat:@"%@%d", noteLetter, octave];
	return noteName;
}


/*
 *	noteToFreq:
 *
 *	Purpose:	Convert a musical note to a frequency.
 *	Arguments:	(NSInteger note) Number representing half-steps up from C0 plus octaves*12.
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
 *	Arguments:	(NSInteger note) Number representing half-steps up from C0 plus octaves*12.
 *	Returns:	(float) Hertz value of note.
 *
 *	Resources:	Frequency formula http://www.phy.mtu.edu/~suits/NoteFreqCalcs.html
 */
-(float)noteToFreqEQScale:(NSInteger)note {
	
	// A4 (kFixedNoteA 440Hz) is 57 half steps above C0
	NSInteger numHalfStepsRelative = note - kFixedNoteHalfSteps;
	
	// frequency = fixedNote * a^n, where n = number of half steps from fixedNote
	float retVal = kFixedNoteA * pow(M_12RT_OF_2, numHalfStepsRelative);
	return retVal;
}



@end
