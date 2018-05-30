//
//  $Id: PGPostgresTypeHandler.h 3848 2012-09-12 12:19:31Z stuart02 $
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

#import "PGPostgresTypeHandlerProtocol.h"

@class PGPostgresConnection;

@interface PGPostgresTypeHandler : NSObject
{
	PGPostgresConnection *_connection;
}

/**
 * @property connection The connection this type handler is associated with.
 */
@property (readonly) PGPostgresConnection *connection;

- (id)initWithConnection:(PGPostgresConnection *)connection;

@end
