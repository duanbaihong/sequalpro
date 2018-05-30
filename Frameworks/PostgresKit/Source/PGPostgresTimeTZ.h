//
//  $Id: PGPostgresTimeTZ.h 3827 2012-09-09 00:51:43Z stuart02 $
//
//  PGPostgresTimeTZ.h
//  PostgresKit
//
//  Created by Stuart Connolly (stuconnolly.com) on September 8, 2012.
//  Copyright (c) 2012 Stuart Connolly. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

/**
 * @class PGPostgresTimeTZ PGPostgresTimeTZ.h
 *
 * @author Stuart Connolly http://stuconnolly.com
 *
 * Simple wrapper to represet a time or timestamp with an associated time zone.
 */
@interface PGPostgresTimeTZ : NSObject 
{
	BOOL _hasDate;
	
	NSDate *_date;
	NSTimeZone *_timeZone;
}

@property (readwrite, assign) BOOL hasDate;

/**
 * @property date The date instance that holds the time.
 */
@property (readwrite, retain) NSDate *date;

/**
 * @property timeZone The time zone of the associated time.
 */
@property (readwrite, retain) NSTimeZone *timeZone;

+ (PGPostgresTimeTZ *)timeWithDate:(NSDate *)date timeZoneGMTOffset:(NSUInteger)offset;

- (id)initWithDate:(NSDate *)date timeZoneGMTOffset:(NSUInteger)offset;

@end
