//
//  SecondViewController.m
//  NoteToFreq
//
//  Created by Sam on 8/2/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import "SecondViewController.h"
#import "Constants.h"


@implementation SecondViewController

@synthesize delegate;
@synthesize freqTextField;
@synthesize noteText;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:@"SecondView" bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[noteText release];
	[freqTextField release];
    [super dealloc];
}

-(IBAction)convertFreqToNote
{
	// Parse input and setup formula variables.
	NSString *frequencyStrIn = [freqTextField text];									// freq # input by user.  Only #s can be input.
	NSNumber *frequencyNum = [NSNumber numberWithDouble:[frequencyStrIn doubleValue]];	// # usr_in -> NSNumber
	double frequencyDbl = [frequencyNum doubleValue];									// # usr_in -> double
	
	// Name of note from user frequency input.
	NSString *foundNoteStr = [delegate freqToNote:frequencyDbl];
	
	// usr_in -> half steps from fixed note (A4)
	// Necessary for getting the closest (foundNoteStr) note's frequency.
	// A little hacky using fTNEQScale:  This will have to be changed if
	//   we implement a Just Temperament scaling option.
	NSInteger numHalfStepsRelative = [delegate freqToNoteEQScale:frequencyDbl];
	NSInteger numHalfStepsAbsolute = numHalfStepsRelative + kFixedNoteHalfSteps;	// A4 (kFixedNoteA 440Hz) is 57 half steps above C0
	NSNumber *foundNoteFreq = [NSNumber numberWithFloat:[delegate noteToFreq:numHalfStepsAbsolute]];	// freq of the found note
	
	NSLog(@"Converting frequency %1.4f Hz to note... %@", frequencyDbl, foundNoteStr);

	// Set UI text views.
	freqTextField.text = [[frequencyNum stringValue] stringByAppendingFormat:@" Hz"];
	noteText.text = [NSString stringWithFormat:@"%@ \n(%1.4f Hz)", foundNoteStr, [foundNoteFreq floatValue]];
	
	// Dismiss number pad.
	[freqTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == freqTextField) {
        [freqTextField resignFirstResponder];
    }
    return YES;
}


@end
