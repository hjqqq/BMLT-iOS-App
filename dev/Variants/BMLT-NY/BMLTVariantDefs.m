//
//  BMLTVariantDefs.m
//  BMLT
//
//  Created by MAGSHARE.
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

#import "BMLTVariantDefs.h"

/**************************************************************//**
 \brief  See the "BMLTVariantDefs.h" file for details.
 *****************************************************************/
@implementation BMLTVariantDefs

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)windowBackgroundColor
{
    return [UIColor blueColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)searchBackgroundColor
{
    return [UIColor blueColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)listResultsBackgroundColor
{
    return [UIColor blueColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)multiMeetingsBackgroundColor
{
    return [UIColor colorWithRed:0 green:.3 blue:.7 alpha:1];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)multiMeetingsTextColor
{
    return [UIColor whiteColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)mapResultsBackgroundColor
{
    return [UIColor blueColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)meetingDetailBackgroundColor
{
    // This strange getup is probably temporary. It makes sure that the color only gets instantiated once.
    static UIColor *color;
    static dispatch_once_t onceToken;
    dispatch_once ( &onceToken, ^{ color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DarkWeave.png"]]; } );
    return color;
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)modalBackgroundColor
{
    return [BMLTVariantDefs meetingDetailBackgroundColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)popoverBackgroundColor
{
    return [BMLTVariantDefs meetingDetailBackgroundColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)settingsBackgroundColor
{
    return [UIColor underPageBackgroundColor];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)getSortOddColor
{
    return [UIColor colorWithRed:.8 green:.9 blue:1 alpha:1];
}

/**************************************************************//**
 *****************************************************************/
+ (UIColor *)getSortEvenColor
{
    return [UIColor whiteColor];
}

/**************************************************************//**
 *****************************************************************/
+ (NSURL *)rootServerURI
{
    return [NSURL URLWithString:NSLocalizedString(@"INITIAL-SERVER-URI",nil)];
}

/**************************************************************//**
 *****************************************************************/
+ (NSURL *)directionsURITo:(CLLocationCoordinate2D)inTo   ///< The long/lat of wehere we are going
{
    return [NSURL URLWithString:[NSString stringWithFormat:NSLocalizedString(@"DIRECTIONS-URI-FORMAT",nil), inTo.latitude, inTo.longitude]];
}
/**************************************************************//**
 *****************************************************************/
+ (NSInteger)maxNumberOgMeetings
{
    return 500;
}

@end
