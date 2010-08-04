//
//  FirstViewController.h
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright calamitySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {

	UIPickerView *notePickerView;
	UILabel *outputLabel;
	
	NSArray *pickerViewLetterArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *notePickerView;
@property (nonatomic, retain) IBOutlet UILabel *outputLabel;

@property (nonatomic, retain) NSArray *pickerViewLetterArray;

@end
