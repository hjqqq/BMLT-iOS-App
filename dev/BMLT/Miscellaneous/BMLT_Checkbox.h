//
//  BMLT_CheckBox.h
//  BMLT
//
//  Created by MAGSHARE.
//  Copyright 2012 MAGSHARE. All rights reserved.
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

#import <UIKit/UIKit.h>

/******************************************************************/
/**
 \class BrassCheckBox
 \brief This implements a special "checkbox" interface element.
 *****************************************************************/
@interface BMLT_Checkbox : UIButton
@property (nonatomic, readwrite)   BOOL    isChecked;
- (BOOL)toggleState;
- (void)buttonClickedInside:(id)sender;
@end
