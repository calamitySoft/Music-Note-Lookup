//
//  SecondViewController.h
//  NoteToFreq
//
//  Created by Sam on 8/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController {

	UITextView *frequency;
	UIButton *converter;
}

@property(nonatomic, retain) IBOutlet UITextView *frequency;

-(IBAction)convertFreqToNote;

@end
