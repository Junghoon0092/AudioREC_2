//
//  RecordListViewController.h
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import "RecordDataBase.h"
#import "UIMemoListCell.h"

@interface RecordListViewController : UIViewController <AVAudioPlayerDelegate, MFMailComposeViewControllerDelegate>

{
    RecordDataBase *pDataBase;
    IBOutlet UITableView *pListView;
    IBOutlet UIBarButtonItem *PlayerButton;
    AVAudioPlayer *pAudioPlayer;
}
- (void) ReloadRecordList;

@property (nonatomic, retain) AVAudioPlayer  *pAudioPlayer;


@end
