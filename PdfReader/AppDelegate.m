//
//  AppDelegate.m
//  PdfReader
//
//  Created by Dhruv Singh on 01/06/16.
//  Copyright © 2016 Dhruv Singh. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
/* fetch data db
-(void)usingDeepLinking:(NSString *)docId{
    
    
    recentViewedDoc = [[DBManager sharedDatabase] getdocId:[NSString stringWithFormat:@"SELECT * FROM recentViewed"]];
    getDocId = docId;
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkNetworkStatus:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    [reachability startNotifier];
    
    if (internetStatus != NotReachable) {
        
        self.currentRequest = [HttpClient new];
        self.currentRequest.delegate = self;
        
        [self.currentRequest getDocuments:getDocId];
        
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"No Connectivity"];
        [alert setMessage:@"Without an internet connection. This application has limited functionality."];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Work offline"];
        [alert addButtonWithTitle:@"Reconnect"];
        [alert show];
    }
    
}
 
 #pragma mark save And Load
 
 -(void) saveUpdateDatabaseAndLoadFromURL
 {
 AppManager *appManager = [AppManager appManager];
 
 NSLog(@"KAppDelegate.recentViewedDoc..%d",[recentViewedDoc count]);
 
 
 Document *documentToView=appManager.activeDocument;
 NSString *getDocIdFromURL = [NSString stringWithFormat:@"%@",documentToView.docid];
 
 if([recentViewedDoc count]>0)
 {
 for (int k=0; k<[recentViewedDoc count]; k++)
 {
 NSString *value = [[recentViewedDoc objectAtIndex:k] objectForKey:@"docId"];
 
 NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
 [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
 
 if([value isEqualToString:getDocIdFromURL])
 {
 NSString *query = [NSString stringWithFormat:@"UPDATE recentViewed SET  date='%@' WHERE docId='%@'",[DateFormatter stringFromDate:[NSDate date]],value];
 
 [[DBManager sharedDatabase] executeQuery:query];
 }
 else
 {
 NSString *query = [NSString stringWithFormat:@"INSERT INTO recentViewed (docId,date,thumbURL,title) VALUES ('%@','%@','%@','%@')",documentToView.docid,[DateFormatter stringFromDate:[NSDate date]],documentToView.thumbUrl,documentToView.title];
 
 [[DBManager sharedDatabase] executeQuery:query];
 }
 }
 }
 
 if([recentViewedDoc count]==0)
 {
 NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
 [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
 
 NSString *query = [NSString stringWithFormat:@"INSERT INTO recentViewed (docId,date,thumbURL,title) VALUES ('%@','%@','%@','%@')",documentToView.docid,[DateFormatter stringFromDate:[NSDate date]],documentToView.thumbUrl,documentToView.title];
 
 [[DBManager sharedDatabase] executeQuery:query];
 }
 
 BookViewController *obj_bookVC;
 if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
 {
 obj_bookVC=[[BookViewController alloc]initWithNibName:@"BookViewController" bundle:nil];
 
 }
 else
 {
 obj_bookVC=[[BookViewController alloc]initWithNibName:@"BookVC" bundle:nil];
 }
 obj_bookVC.document=appManager.activeDocument;
 [[GAI sharedInstance].defaultTracker sendEventWithCategory:appManager.activeDocument.title
 withAction:@"View"
 withLabel:@"1"
 withValue:nil];
 [UIPasteboard generalPasteboard].string = @"";
 
 [self.nav pushViewController:obj_bookVC animated:YES];
 }

 
 */


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
