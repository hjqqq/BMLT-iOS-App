//
//  BMLTMeetingDetailViewController.m
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

#import "BMLTMeetingDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "BMLT_Results_MapPointAnnotationView.h"
#import "BMLT_Meeting.h"
#import "BMLT_Format.h"

#define List_Meeting_Format_Circle_Size             24
#define List_Meeting_Format_Line_Padding            2

@implementation BMLTMeetingDetailViewController
@synthesize meetingMapView;

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBeanieBackground];
    [self setFormats];
    [self setMeetingFrequencyText];
    [self setMeetingCommentsText];
    [self setMapLocation];
    [self setMeetingLocationText];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)viewDidUnload
{
    [self setMeetingMapView:nil];
    formatsContainerView = nil;
    addressText = nil;
    commentsTextView = nil;
    frequencyTextView = nil;
    selectMapButton = nil;
    selectSatelliteButton = nil;
    myMarker = nil;
    [super viewDidUnload];
}

/**************************************************************//**
 \brief 
 \returns 
 *****************************************************************/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    BOOL    ret = ((io == UIInterfaceOrientationPortrait) || (io == UIInterfaceOrientationLandscapeLeft) || (io == UIInterfaceOrientationLandscapeRight));
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
        ret = YES;
        }
    return ret;
}

#pragma mark - Custom Functions -

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMyMeeting:(BMLT_Meeting *)inMeeting
{
    myMeeting = inMeeting;
}

/**************************************************************//**
 \brief 
 \returns   
 *****************************************************************/
- (BMLT_Meeting *)getMyMeeting
{
    return myMeeting;
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMyModalController:(BMLTDisplayListResultsViewController *)inController
{
    myModalController = inController;
}

/**************************************************************//**
 \brief 
 \returns 
 *****************************************************************/
- (BMLTDisplayListResultsViewController *)getMyModalController
{
    return myModalController;
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setFormats
{
    NSArray *formats = [myMeeting getFormats];
    
    if ( [formats count] )
        {
        CGRect  formatsBounds = [formatsContainerView frame];
        formatsBounds.size.width = 0;
        
        CGRect  boundsRect = [formatsContainerView bounds];
        
        boundsRect.origin = CGPointZero;
        boundsRect.size.width = boundsRect.size.height = (List_Meeting_Format_Circle_Size_Big);
        boundsRect.origin.y = (formatsBounds.size.height - boundsRect.size.height) / 2;
        
        for ( BMLT_Format *format in formats )
            {
            BMLT_FormatButton   *newButton = [[BMLT_FormatButton alloc] initWithFrame:boundsRect andFormat:format];
            
            if ( newButton )
                {
                [newButton addTarget:[self getMyModalController] action:@selector(displayFormatDetail:) forControlEvents:UIControlEventTouchUpInside];
                [formatsContainerView addSubview:newButton];
                }

            formatsBounds.size.width += boundsRect.size.width + List_Meeting_Format_Line_Padding;
            boundsRect.origin.x += boundsRect.size.width + List_Meeting_Format_Line_Padding;
            }

        formatsBounds.size.width -= List_Meeting_Format_Line_Padding;
        boundsRect = [[self view] bounds];
        formatsBounds.origin.x = (boundsRect.size.width - formatsBounds.size.width) / 2;
        [formatsContainerView setFrame:formatsBounds];
        }
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMeetingFrequencyText
{
    NSString    *formatString = NSLocalizedString ( @"MEETING-DETAILS-FREQUENCY-FORMAT", nil );
    NSString    *weekday = [myMeeting getWeekday];
    NSDate      *startTime = [myMeeting getStartTime];
    NSString    *time = [NSDateFormatter localizedStringFromDate:startTime dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    NSCalendar  *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar];
    
    if ( gregorian )
        {
        NSDateComponents    *dateComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:startTime];
        
        if ( [dateComp hour] >= 23 && [dateComp minute] > 45 )
            {
            time = NSLocalizedString(@"TIME-MIDNIGHT", nil);
            }
        else if ( [dateComp hour] == 12 && [dateComp minute] == 0 )
            {
            time = NSLocalizedString(@"TIME-NOON", nil);
            }
        }
    
    [frequencyTextView setText:[NSString stringWithFormat:formatString, weekday, time]];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMeetingCommentsText
{
    [commentsTextView setText:[myMeeting getBMLTDescription]];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMeetingLocationText
{
    NSString    *townAndState = [NSString stringWithFormat:@"%@, %@", (([myMeeting getValueFromField:@"location_city_subsection"]) ? (NSString *)[myMeeting getValueFromField:@"location_city_subsection"] : (NSString *)[myMeeting getValueFromField:@"location_municipality"]), (NSString *)[myMeeting getValueFromField:@"location_province"]];
    NSString    *meetingLocationString = [NSString stringWithFormat:@"%@%@", (([myMeeting getValueFromField:@"location_text"]) ? [NSString stringWithFormat:@"%@, ", (NSString *)[myMeeting getValueFromField:@"location_text"]] : @""), [myMeeting getValueFromField:@"location_street"]];
    
    NSString    *theAddress = [NSString stringWithFormat:@"%@, %@", meetingLocationString, townAndState];
    [addressText setText:theAddress];
    
    CLLocation  *loc = [myMeeting getMeetingLocationCoords];
    NSArray *meetings = [[NSArray alloc] initWithObjects:myMeeting, nil];
    
    myMarker =[[BMLT_Results_MapPointAnnotation alloc] initWithCoordinate:[loc coordinate] andMeetings:meetings];
    
    [meetingMapView addAnnotation:myMarker];
    [selectMapButton setAlpha:0.0];
    [selectSatelliteButton setAlpha:1.0];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (void)setMapLocation
{
    CLLocation  *loc = [myMeeting getMeetingLocationCoords];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([loc coordinate], 250, 250);
    [meetingMapView setDelegate:self];
    [meetingMapView setRegion:region animated:NO];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (IBAction)selectMapView:(id)sender
{
    [meetingMapView setMapType:MKMapTypeStandard];
    [selectMapButton setAlpha:0.0];
    [selectSatelliteButton setAlpha:1.0];
}

/**************************************************************//**
 \brief 
 *****************************************************************/
- (IBAction)selectSatelliteView:(id)sender
{
    [meetingMapView setMapType:MKMapTypeHybrid];
    [selectMapButton setAlpha:1.0];
    [selectSatelliteButton setAlpha:0.0];
}

/**************************************************************//**
 \brief This applies the "Beanie Background" to the results view.
 *****************************************************************/
- (void)setBeanieBackground
{
    [[[self view] layer] setContentsGravity:kCAGravityResizeAspectFill];
    [[[self view] layer] setBackgroundColor:[[UIColor colorWithWhite:0 alpha:0] CGColor]];
    [[[self view] layer] setContents:(id)[[UIImage imageNamed:@"BeanieBack.png"] CGImage]];
}

#pragma mark - MkMapAnnotationDelegate Functions -

/**************************************************************//**
 \brief 
 \returns 
 *****************************************************************/
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id < MKAnnotation >)annotation
{
    static NSString* identifier = @"single_meeting_annotation";
    
    MKAnnotationView* ret = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if ( !ret )
        {
        ret = [[BMLT_Results_BlackAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
    
    return ret;
}
@end
