//
//  DBManager.m
//  silverCoinCalculator
//
//  Created by TX-MAC-02 on 11/18/13.
//  Copyright (c) 2013 TX-MAC-02. All rights reserved.
//

#import "DBManager.h"
#import "skipBackup.h"

#define ddb  @"ePage.sqlite"

@implementation DBManager

static DBManager *sharedInstance = nil;

+(DBManager*) sharedDatabase
{
    if (!sharedInstance)
    {
        sharedInstance = [[DBManager alloc] init];
    }
    return sharedInstance;
}

+(void) createEditableCopyOfDatabaseIfNeeded
{
    NSLog(@"create editable copy of databse");
    
    BOOL success;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [doucmentDirectory stringByAppendingPathComponent:ddb];
    
    BOOL flag = [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:writableDBPath]];
    NSLog(flag ? @"Yes" : @"No");
    [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject]]];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if(success)
    {
        NSLog(@"Alredy exist");
        return;
    }
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:ddb];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
//    const char* filePath = [[URL path] fileSystemRepresentation];
//    const char* attrName = "com.apple.MobileBackup";
//    u_int8_t attrValue = 1;
//    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//    return result == 0;
    
    BOOL checkOtherFlag = [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:defaultDBPath]];
    NSLog(checkOtherFlag ? @"Yes" : @"No");
    [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject]]];
   
    if(!success)
    {
        NSLog(@"failed to create the databse at path with error %@", [error localizedDescription]);
    }
}

-(void)openDatabaseConnection
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentDirectory = [paths objectAtIndex:0];
    NSString *path = [doucmentDirectory stringByAppendingPathComponent:ddb];
    
    BOOL checkAnotherflag = [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    NSLog(checkAnotherflag ? @"Yes" : @"No");
    
    [skipBackup addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject]]];
    
    if(sqlite3_open([path UTF8String], &dataBaseConnection) == SQLITE_OK)
        NSLog(@"database successfully open");
    else
        NSLog(@"error in opening database");
    
}

-(void) closeDatabaseConnection
{
    sqlite3_close(dataBaseConnection);
    NSLog(@"Database succeessfully closed");
}

-(void)executeQuery:(NSString *)query
{
    const char *sql = [query cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_stmt *statement = nil;
    
    if(sqlite3_prepare_v2(dataBaseConnection, sql, -1, &statement, NULL)!= SQLITE_OK)
        NSAssert1(0, @"error preparing statment", sqlite3_errmsg(dataBaseConnection));
    else
        sqlite3_step(statement);
    
    sqlite3_finalize(statement);
}

-(NSMutableArray *) getdocId:(NSString *)_query
{
    NSMutableArray * drr = [[NSMutableArray alloc] init];
    NSString *query;
    query = _query;
    
    const char *sql1 = [query cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_stmt *statement  = nil;
    
    if(sqlite3_prepare_v2(dataBaseConnection, sql1, -1, &statement, NULL)!= SQLITE_OK)
    {
        NSAssert1(0, @"error preparing statment", sqlite3_errmsg(dataBaseConnection));
    }
    else
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            [drr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%s", (char*)sqlite3_column_text(statement, 0)],@"id",
                            [NSString stringWithFormat:@"%s", (char*)sqlite3_column_text(statement, 1)],@"date",
                            [NSString stringWithFormat:@"%s", (char*)sqlite3_column_text(statement, 2)],@"docId",
                            [NSString stringWithFormat:@"%s", (char*)sqlite3_column_text(statement, 3)],@"thumbURL",
                            [NSString stringWithFormat:@"%s", (char*)sqlite3_column_text(statement, 4)],@"title",
                            nil]];
        }
    }
    
    sqlite3_finalize(statement);
    return drr;
}



@end
