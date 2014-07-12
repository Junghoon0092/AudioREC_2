//
//  RecordViewController.m
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

@synthesize pAudioRecorder;
@synthesize pAudioSession;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self SetAudioSession];
    [recordTimeDisplay setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:48.0]];
    pDataBase = [[RecordDataBase alloc] init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)SetAudioSession
{
    self.pAudioSession = [AVAudioSession sharedInstance];
    
    if (![self.pAudioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil])
        return NO;
    if (![self.pAudioSession setActive:YES error:nil])
        return NO;
    return  self.pAudioSession.isInputAvailable;
}

- (IBAction)AudioRecordingClick
{
    if (self.pAudioRecorder !=nil)
    {
        if (self.pAudioRecorder.recording)
        {
            [self.pAudioRecorder stop];
            pGaugeView.value = 0;
            [[NSFileManager defaultManager] removeItemAtPath:[self.pAudioRecorder.url path] error:nil];
            [pGaugeView setNeedsDisplay];
            return;
            
        }
//        [self.pAudioRecorder release];
    }
    if ([self AudioRecordingStart])
    {
        [self ToolbarRecordButtonToogle:1];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
    
}
- (BOOL)AudioRecordingStart
{
    NSMutableDictionary *Audiosettting = [NSMutableDictionary dictionary];
    [Audiosettting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [Audiosettting setValue:[NSNumber numberWithFloat:11025] forKey:AVSampleRateKey];
    [Audiosettting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [Audiosettting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [Audiosettting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [Audiosettting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    NSURL *url = [self getAudioFilePath];
    
    self.pAudioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:Audiosettting error:nil];
    if (!self.pAudioRecorder)return NO;
    self.pAudioRecorder.meteringEnabled = YES;
    self.pAudioRecorder.delegate = self;
    
    if (![self.pAudioRecorder prepareToRecord]) return NO;
    if (![self.pAudioRecorder record]) return NO;
    return YES;
    
}

- (NSURL *)getAudioFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSURL *AudioUrl = [NSURL fileURLWithPath:[documentDirectory stringByAppendingPathComponent:[self getFileName]]];
    return  AudioUrl;
    
}


- (NSString *) getFileName
{
    NSDateFormatter *FileNameFormat = [[NSDateFormatter alloc] init];
    [FileNameFormat setDateFormat:@"yyyymmddhhmmss"];
    
    NSString *FileNameStr = [[FileNameFormat stringFromDate:[NSData data]]stringByAppendingString:@".aif"];
//    [FileNameFormat release];
    return  FileNameStr;
    
}

- (void)timerFired
{
    [self.pAudioRecorder updateMeters];
    double peak = pow(10, (0.05 *[self.pAudioRecorder peakPowerForChannel:0]));
    plowPassResults = 0.05 * peak + (1.0 - 0.05) * plowPassResults;
    
    recordTimeDisplay.text = [NSString stringWithFormat:@"%@", [self RecordTime:self.pAudioRecorder.currentTime]];
                              pRecordingTime = self.pAudioRecorder.currentTime;
                              pGaugeView.value = plowPassResults;
                              [pGaugeView setNeedsDisplay];
                              
}

- (NSString *)RecordTime: (int) num;
{
    int secs = num % 60;
    int min = (num % 3600) / 60;
    int hour = (num / 3600);
        
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, secs];
        
}
    
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    pRecordSeq = [[recorder.url.path substringFromIndex:[recorder.url.path length] -18 ] substringToIndex:14];
    pRecordFileName = recorder.url.path;
    [pDataBase insertRecordData:pRecordSeq RecordingTM:pRecordingTime RecordFileNM:pRecordFileName];
    
    [self ToolbarRecordButtonToogle:0];
    timer = nil;
}

- (void) ToolbarRecordButtonToogle:(int)index
{
    if (index == 0)
        [pRecordButton setImage:[UIImage imageNamed:@"record_on.png"] forState:UIControlStateNormal];
    else [pRecordButton setImage:[UIImage imageNamed:@"record_off.png"] forState:UIControlStateNormal];
}
    
    
    
    
    
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
