//
//  FirstViewController.h
//  NoteToFreq
//
//  Created by Logan Moseley on 7/14/10.
//  Copyright calamitySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {

	UIPickerView *noteSelector;
	UIPickerView *octaveSelector;
	
}

@property (nonatomic, retain) UIPickerView *noteSelector;
@property (nonatomic, retain) UIPickerView *octaveSelector;


@end
