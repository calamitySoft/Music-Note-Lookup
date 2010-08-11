//
//  FirstViewController.m
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"


@implementation FirstViewController

@synthesize delegate;
@synthesize notePickerView, outputLabel, pickerViewLetterArray;



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {

    }
    return self;
}
/**/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	pickerViewLetterArray = [[NSArray arrayWithObjects:
							  @"C", @"C# / Db",
							  @"D", @"D# / Eb",
							  @"E",
							  @"F", @"F# / Gb",
							  @"G", @"G# / Ab",
							  @"A", @"A# / Bb",
							  @"B",
							  nil] retain];
}
/**/

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[notePickerView release];
	[outputLabel release];
	[pickerViewLetterArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

/*
 *	pickerView:didSelectRow:inComponent
 *
 *	Purpose:	Reaction to moving the picker.
 *	Strategy:	From note/octave selected, get the number representing half-steps up from A0 plus octaves*12.
 *				Get the note's frequency from delegate's noteToFreq:
 *				Set the label to display that frequency.
 *
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView == notePickerView)	// show selection for the note picker
	{
		// report the selection to the UI label		
		/*
		 outputLabel.text = [[NSString stringWithFormat:@"%@ - %d",
							[pickerViewLetterArray objectAtIndex:[notePickerView selectedRowInComponent:0]],
							[notePickerView selectedRowInComponent:1]]
							
							stringByAppendingFormat:@" - %@ - %1.2f", [delegate freqToNote:440.12345], [delegate noteToFreq:@"A"]];
		 */
		
		NSInteger noteInteger = [notePickerView selectedRowInComponent:0] +
								[notePickerView selectedRowInComponent:1] * 12;
		outputLabel.text = [NSString stringWithFormat:@"%1.4f Hz",
							[delegate noteToFreq:noteInteger]];
	}
}


#pragma mark -
#pragma mark UIPickerViewDataSource

/*
 *	pickerView:titleForRow:forComponent
 *	
 *	Returns:	Text of the picker element at row/component.
 *	Strategy:	(Row) Selects from the pickerViewLetterArray.
 *				(Component) Converts the requested row's index to a str.
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	if (pickerView == notePickerView)
	{
		// Letter picker
		if (component == 0)	{
			returnStr = [pickerViewLetterArray objectAtIndex:row];
		}
		// Octave picker
		else {
			// Converts NSInteger to NSNumber to NSString
			returnStr = [[NSNumber numberWithInteger:row] stringValue];
		}
	}
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
	
	NSLog(@"component = %d", component);
	
	if (component == 0)
		componentWidth = 280.0*kNotePickerRatio;	// first column size is wider to hold names
	else
		componentWidth = 280-(280*kNotePickerRatio);	// second column is narrower to show numbers
	
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	// Note letter
	if (component == 0) {
		return [pickerViewLetterArray count];
	}
	// Number of octaves
	else {
		return kNumOctaves;
	}

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}


@end
