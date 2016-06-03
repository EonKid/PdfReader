//
//  ViewController.h
//  PdfReader
//
//  Created by Dhruv Singh on 01/06/16.
//  Copyright © 2016 Dhruv Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

- (IBAction)btnPressDownload:(id)sender;

@end

