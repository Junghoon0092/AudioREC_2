//
//  RootViewController.h
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 2..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AudioRecorderInfo;
@class RecordViewController;
@class RecordListViewController;


@interface RootViewController : UIViewController
{
    RecordViewController         *pRecordViewController;
    AudioRecorderInfo           *pAudioRecorderInfo;
    RecordListViewController    *pRecoedlistViewController;
    IBOutlet UIButton           *infoButton;
}


-(IBAction) RecodrInfoClick;
-(IBAction) AudioListClick;

@property (nonatomic, retain) RecordViewController *pRecordViewController;
@property (nonatomic, retain) AudioRecorderInfo *pAudioRecorderInfo;
@property (nonatomic, retain) RecordListViewController *pRecordListViewController;

@end
