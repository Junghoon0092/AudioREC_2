//
//  RecordListViewController.m
//  AudioREC_Rev2
//
//  Created by Jung-Hoon on 2014. 7. 3..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import "RecordListViewController.h"
#define ROW_HEIGHT 65


@interface RecordListViewController ()

@end



@implementation RecordListViewController
@synthesize pAudioPlayer;


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
    pDataBase = [[RecordDataBase alloc]init];
    [pListView setRowHeight:ROW_HEIGHT];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) ReloadRecordList
{
    [pDataBase getRecordList];
    [pListView reloadData];
    
}

#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return [pDataBase.memoListArray count];
}

- (UIMemoListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Celldentifer = @"MemoListCell";
    
    UIMemoListCell *cell = (UIMemoListCell *)[tableView dequeueReusableCellWithIdentifier:Celldentifer];
    if(cell == nil)
    {
        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"UIMemoListCell" owner:nil options:nil];
        cell = [arr objectAtIndex:0];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSString *pSeq = [[pDataBase.memoListArray objectAtIndex:indexPath.row]objectForKey:@"SEQ"];
    int pRecordingTime = [(NSNumber *)[[pDataBase.memoListArray objectAtIndex:indexPath.row] objectForKey:@"RecordingTM"]intValue];
    
    cell.pDatelabel.text = [NSString stringWithFormat:@"%@-%@-%@",
                            [pSeq substringWithRange:NSMakeRange(0, 4)],
                            [pSeq substringWithRange:NSMakeRange(4, 2)],
                            [pSeq substringWithRange:NSMakeRange(6, 2)]];
    cell.pTimeLabel.text = [NSString stringWithFormat:@"%@시 %@분 %@초 녹음",
                            [pSeq substringWithRange:NSMakeRange(8, 2)],
                            [pSeq substringWithRange:NSMakeRange(10, 2)],
                            [pSeq substringWithRange:NSMakeRange(12, 2)]];
    cell.pRecordingTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (pRecordingTime / 3600), (pRecordingTime % 3600)/60, pRecordingTime % 60];
    
    return  cell;
                            
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *pSeq = [[pDataBase.memoListArray objectAtIndex:indexPath.row]objectForKey:@"SEQ"];
    [pDataBase deleteRecordData:pSeq];
    [pDataBase.memoListArray removeObjectAtIndex:indexPath.row];
    [pListView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


#pragma mark Audio play

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //[self.pAudioPlayer release];
    self.pAudioPlayer = nil;
    PlayerButton.title = @"듣기";
}

- (IBAction)AudioPlayerClick
{
    int index = [[pListView indexPathForSelectedRow] row];
    if(pDataBase.memoListArray.count == 0)return;
    NSString *pRecordFileName = [[pDataBase.memoListArray objectAtIndex:index] objectForKey:@"RecordFileNM"];
    if(self.pAudioPlayer == nil || !self.pAudioPlayer.playing)
    {
        self.pAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:pRecordFileName] error:nil];
        self.pAudioPlayer.delegate = self;
        [self.pAudioPlayer prepareToPlay];
        [self.pAudioPlayer play];
        PlayerButton.title = @"멈춤";
    }
    else
    {
        [self.pAudioPlayer stop];
        PlayerButton.title = @"듣기";
//      [self.pAudioPlayer release];
        self.pAudioPlayer = nil;
    }
}

#pragma mark Email send

- (IBAction)EMailClick

{
    if(pDataBase.memoListArray.count == 0)  return;
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    int index = [[pListView indexPathForSelectedRow] row];
    NSString *pRecordFileName = [[pDataBase.memoListArray objectAtIndex:index]objectForKey:@"RecordFileNM"];
    
    NSData *data = [NSData dataWithContentsOfFile:pRecordFileName];
    [picker addAttachmentData:data mimeType:@"audio/mp4" fileName:pRecordFileName];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"음성녹음메모가 도착했습니다."];
   // [self presentModalViewController:picker animated:YES];
   // [picker release];
    
    
}

#pragma mark 메일 델리게이트
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"성공"
                                        message:@"성공적으로 보냈습니다."
                                       delegate:nil
                              cancelButtonTitle:@"확인"
                              otherButtonTitles:nil]show];
                     break;
        case MFMailComposeResultFailed:
            [[[UIAlertView alloc] initWithTitle:@"실패"
                                        message:@"전송에 실패했습니다."
                                       delegate:nil
                              cancelButtonTitle:@"확인"
                              otherButtonTitles:nil]show];
            break;
    };
//    [controller dismissModalViewControllerAnimated:YES];
        

}























- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
