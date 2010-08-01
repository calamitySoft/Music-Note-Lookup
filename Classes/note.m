//
//  note.m
//  NoteToFreq
//
//  Created by Sam on 7/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "note.h"


@implementation note

@synthesize hertz, noteName;

-(id)init
{
	note *newNote = [[note alloc]initWithNoteName:@"A" withHertz:440];

	return newNote;
}

-(id)initWithNoteName:(NSString *) doe withHertz:(float)re
{
	self = [super init];
	
	if(!self)
		return nil;
	
	[self setNoteName:doe];
	[self setHertz:re];

	return self;
}
	
	
@end
