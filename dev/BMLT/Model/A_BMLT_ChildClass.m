//
//  A_BMLT_ChildClass.m
//  BMLT
//
//  Created by MAGSHARE on 8/13/11.
//  Copyright 2011 MAGSHARE. All rights reserved.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  BMLT is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this code.  If not, see <http://www.gnu.org/licenses/>.
//
/***************************************************************\**
 \file      A_BMLT_ChildClass.m
 \brief     This file implements a class meant as a superclass for
            classes that can instances contained within other instances
            that implmenent the BMLT_ParentProtocol protocol.
 *****************************************************************/

#import "A_BMLT_ChildClass.h"

@implementation A_BMLT_ChildClass

#pragma mark - Override Functions -

/***************************************************************\**
 \brief     Initializer
 \returns   self
 *****************************************************************/
- (id)init
{
    return [self initWithParent:nil];
}

/***************************************************************\**
 \brief de-initializer
 *****************************************************************/
-(void)dealloc
{
    [parentObject release];
    [super dealloc];
}

#pragma mark - Class-Specific Functions -

/***************************************************************\**
 \brief     Initializer with a parent object
 \returns   self
 *****************************************************************/
- (id)initWithParent:(id)inParent
{
    self = [super init];
    
    if (self)
        {
        [self setParentObject:inParent];
        }
    
    return self;
}

/***************************************************************\**
 \brief Accessor - set the parent object
 *****************************************************************/
- (void)setParentObject:(id)inParentObject
{
    [inParentObject retain];
    [parentObject release];
    
    parentObject = inParentObject;
}

/***************************************************************\**
 \brief     Accessor - get the parent object
 \returns   the parent object
 *****************************************************************/
- (NSObject *)getParentObject
{
    return parentObject;
}

@end