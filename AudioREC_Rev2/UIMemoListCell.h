//
//  UIMemoListCell.h
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMemoListCell : UITableViewCell
{
    IBOutlet UILabel *pDateLabel;
    IBOutlet UILabel *pTimeLabel;
    IBOutlet UILabel *pRecordingTimeLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *pDatelabel;
@property (nonatomic, retain) IBOutlet UILabel *pTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *pRecordingTimeLabel;

@end
