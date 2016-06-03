//
//  DBManager.h
//  silverCoinCalculator
//
//  Created by TX-MAC-02 on 11/18/13.
//  Copyright (c) 2013 TX-MAC-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    sqlite3 *dataBaseConnection;
     UIImageView *imgView;
}

+(DBManager*) sharedDatabase;
+(void) createEditableCopyOfDatabaseIfNeeded;

-(void) openDatabaseConnection;
-(void) closeDatabaseConnection;

-(void)executeQuery:(NSString *)query;
-(NSMutableArray *) getdocId:(NSString *)_query;




@end
