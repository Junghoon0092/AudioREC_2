//
//  RootViewController.m
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 2..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import "RootViewController.h"
#import "RecordViewController.h"
#import "AudioRecorderInfo.h"
#import "RecordListViewController.h"



@implementation RootViewController

@synthesize pRecordListViewController;
@synthesize pAudioRecorderInfo;
@synthesize pRecordViewController;


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
    RecordViewController *viewController = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:Nil];
    self.pRecordViewController = viewController;

    [self.view insertSubview:viewController.view belowSubview:infoButton];
//    [viewController release];
//
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(IBAction)RecodrInfoClick
{
    if (pAudioRecorderInfo == Nil) {
        AudioRecorderInfo *viewController = [[AudioRecorderInfo alloc] initWithNibName:@"AudioRecorderInfo" bundle:nil];
        self.pAudioRecorderInfo = viewController;
//        [viewController release];
    }
    UIView *RecordView = pRecordViewController.view;
    UIView *AudioRecorderInfoView = pAudioRecorderInfo.view;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([RecordView superview]? UIViewAnimationTransitionFlipFromRight: UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
    
    if ([RecordView superview]!=nil)
    {
        [RecordView removeFromSuperview];
        [self.view insertSubview:AudioRecorderInfoView belowSubview:infoButton];
    } else
    {
        [AudioRecorderInfoView removeFromSuperview];
        [self.view insertSubview:RecordView belowSubview:infoButton];
        
    }
    [UIView commitAnimations];
}

-(IBAction)AudioListClick
{
    if (pRecordViewController == nil) {
        RecordListViewController *viewController =[[RecordListViewController alloc]initWithNibName:@"RecordListViewController" bundle:nil];
        self.pRecordListViewController = viewController;
//        [viewController release];
        
    }
    UIView *RecordView = pRecordViewController.view;
    UIView *RecordListView = pRecordListViewController.view;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([RecordView superview]? UIViewAnimationTransitionCurlUp : UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
    
    if ([RecordView superview] !=nil){
        [RecordView removeFromSuperview];
        [self.view addSubview:RecordListView];
        [self.pRecordListViewController viewDidAppear:YES];
        [self.pRecordViewController viewDidAppear:NO];
        
    }
    else{
        [RecordListView removeFromSuperview];
        [self.view insertSubview:RecordView belowSubview:infoButton];
        [self.pRecordListViewController viewDidAppear:NO];
        [self.pRecordViewController viewDidAppear:YES];
    }
    [UIView commitAnimations];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
