//
//  RecordDataBase.h
//  AudioREC_Rev2
//
//  Created by JungHoon on 2014. 7. 9..
//  Copyright (c) 2014년 Hoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface RecordDataBase : NSObject

{
    NSMutableArray *memoListArray;
    
}

- (void) DataBaseConnection:(sqlite3 **)tempDataBase;
- (void) getRecordList;
- (void) insertRecordData:(NSString *)pSEQ RecordingTM:(NSInteger)pRecordingTM RecordFileNM:(NSString *)pRecordFileNM;
- (void) deleteRecordData:(NSString *)pSEQ;

@property (nonatomic, retain) NSMutableArray *memoListArray;



@end
