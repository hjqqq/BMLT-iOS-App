//
//  MeetingDetailView.h
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

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BMLT_Results_MapPointAnnotationView.h"

@class BMLT_Meeting;
@class A_SearchController;

#define List_Meeting_Format_Circle_Size_Big 30

@interface MeetingDetailViewController : UIViewController <MKMapViewDelegate>
{
    BMLT_Meeting                    *myMeeting;
    MKMapView                       *meetingMapView;
    IBOutlet UIView                 *formatsContainerView;
    IBOutlet UITextView             *addressText;
    IBOutlet UITextView             *commentsTextView;
    IBOutlet UITextView             *frequencyTextView;
    IBOutlet UIButton               *selectMapButton;
    IBOutlet UIButton               *selectSatelliteButton;
    A_SearchController              *myModalController;
    BMLT_Results_MapPointAnnotation  *myMarker;
}

@property (nonatomic, retain) IBOutlet MKMapView *meetingMapView;

- (void)setBeanieBackground;
- (void)setMyMeeting:(BMLT_Meeting *)inMeeting;
- (void)setMyModalController:(A_SearchController *)inController;
- (A_SearchController *)getMyModalController;
- (void)setFormats;
- (void)setMeetingFrequencyText;
- (void)setMeetingCommentsText;
- (void)setMeetingLocationText;
- (void)setMapLocation;

- (IBAction)swipeBack:(UIGestureRecognizer *)sender;
- (IBAction)selectMapView:(id)sender;
- (IBAction)selectSatelliteView:(id)sender;

@end