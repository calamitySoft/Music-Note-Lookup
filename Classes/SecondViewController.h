//
//  SecondViewController.h
//  NoteToFreq
//
//  Created by Sam on 8/2/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppViewControllerDelegate;

@interface SecondViewController : UIViewController {
	id <AppViewControllerDelegate> delegate;

	UITextField *freqTextField;
	UILabel *noteText;
	UIButton *converter;
}

@property (nonatomic, assign) <AppViewControllerDelegate> delegate;
@property(nonatomic, retain) IBOutlet UITextField *freqTextField;
@property(nonatomic, retain) IBOutlet UILabel *noteText;

-(void)keyboardWillShow:(NSNotification *)note;
-(void)addButtonToKeyboard;
-(void)decimal:(id)sender;
-(IBAction)convertFreqToNote;
@end



@protocol AppViewControllerDelegate
-(NSArray *)getNoteLetterArray;
-(NSString *)freqToNote:(float)freq;
-(NSInteger)freqToNoteEQScale:(float)freq;
-(float)noteToFreq:(NSInteger)note;
@end
