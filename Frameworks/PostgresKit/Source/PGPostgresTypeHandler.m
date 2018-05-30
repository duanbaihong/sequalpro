//
//  $Id: PGPostgresTypeHandler.m 3848 2012-09-12 12:19:31Z stuart02 $
//
//  PGPostgresTypeHandler.h
//  PostgresKit
//
//  Created by Stuart Connolly (stuconnolly.com) on July 27, 2012.
//  Copyright (c) 2012 Stuart Connolly. All rights reserved.
// 
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not 
//  use this file except in compliance with the License. You may obtain a copy of 
//  the License at
// 
//  http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software 
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the 
//  License for the specific language governing permissions and limitations under
//  the License.

#import "PGPostgresTypeHandler.h"

@implementation PGPostgresTypeHandler

@synthesize connection = _connection;

#pragma mark -

- (id)initWithConnection:(PGPostgresConnection *)connection 
{	
	if ((self = [super init])) {
		_connection = [connection retain];
	}
	
	return self;
}

#pragma mark -

- (void)dealloc 
{	
	if (_connection) [_connection release], _connection = nil;
	
	[super dealloc];
}

@end
