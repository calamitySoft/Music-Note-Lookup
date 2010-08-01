//
//  note.h
//  NoteToFreq
//
//  Created by Sam on 7/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface note : NSObject {
	
	float hertz;
	NSString *noteName;

}

@property (nonatomic) float hertz;
@property (nonatomic, copy) NSString *noteName;

-(id)initWithNoteName:(NSString *)doe withHertz:(float)re;


@end
