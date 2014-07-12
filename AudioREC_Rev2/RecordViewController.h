//
//  RecordViewController.h
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>


#import "MeterGaugeView.h" // 책에는 안나오는 내용
#import "RecordDataBase.h" // 책에는 안나오는 내용

@interface RecordViewController : UIViewController <AVAudioRecorderDelegate>
{
    AVAudioRecorder *pAudioRecorder;
    AVAudioSession *pAudioSession;
    IBOutlet UIButton *pRecordButton;
    
    IBOutlet UILabel *recordTimeDisplay;
    IBOutlet MeterGaugeView *pGaugeView;
    IBOutlet UIBarButtonItem *ListButton;
    
    NSTimer *timer;
    double plowPassResults;
    RecordDataBase *pDataBase;
    
    NSString *pRecordSeq;
    NSString *pRecordFileName;
    int pRecordingTime;
    
}

- (IBAction) AudioRecordingClick;
- (NSString *) getFileName;
- (BOOL) SetAudioSession;
- (BOOL) AudioRecordingStart;
- (void) ToolbarRecordButtonToogle:(int)index;
- (void) timerFired;

@property (nonatomic, retain) AVAudioRecorder *pAudioRecorder;
@property (nonatomic, retain) AVAudioSession *pAudioSession;


@end
