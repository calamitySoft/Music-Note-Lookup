/*
 *  Constants.h
 *  NoteToFreq
 *
 *  Created by Logan Moseley on 8/2/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

// OPTIONS
#define kNumOctaves			11				// Number of octaves to allow in notePickerView.
#define kNotePickerRatio	3/5				// Ratio of components of notePickerView (left to right).
#define kFixedNoteA			440.00			// Hz to use as the fixed note in frequency calculation.

// MATH CONSTANTS
#define M_12RT_OF_2			1.059463094359	// Used in frequency calculation.
											// In (frequency = kFixedNoteA * a^n), this is a.