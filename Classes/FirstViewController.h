//
//  FirstViewController.h
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright 2010 calamitySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppViewControllerDelegate;

@interface FirstViewController : UIViewController {
	id <AppViewControllerDelegate> delegate;
	
	UIPickerView *notePickerView;
	UILabel *outputLabel;
	NSArray *pickerViewLetterArray;
}

@property (nonatomic, assign) <AppViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIPickerView *notePickerView;
@property (nonatomic, retain) IBOutlet UILabel *outputLabel;
@property (nonatomic, retain) NSArray *pickerViewLetterArray;

@end



@protocol AppViewControllerDelegate
-(NSArray *)getNoteLetterArray;
-(NSString *)freqToNote:(float)freq;
-(float)noteToFreq:(NSInteger)note;
@end
