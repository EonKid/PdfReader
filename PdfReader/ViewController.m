//
//  ViewController.m
//  PdfReader
//
//  Created by Dhruv Singh on 01/06/16.
//  Copyright © 2016 Dhruv Singh. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIWebViewDelegate,UIScrollViewDelegate,UIDocumentInteractionControllerDelegate>
@property(nonatomic) UIDocumentInteractionController *documentInteractionController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"BulldogBasics-2013.pdf"];
       NSURL *url = [NSURL fileURLWithPath:filePath];
 // //  NSURL *URL = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"pdf"];
    if (url) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Preview PDF
        [self.documentInteractionController presentPreviewAnimated:YES];
        
    }

   }

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}
- (IBAction)btnPressDownload:(id)sender {
    
    self.progress.progress = 0.0;
   NSString* currentURL=@"pdf-url-path";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:currentURL]];
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Name-of-doc.pdf"];
    if (filePath) {
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            self.progress.progress = (float)totalBytesRead / totalBytesExpectedToRead;
        }];
        
        [operation setCompletionBlock:^{
            NSLog(@"downloadComplete!");
            // Now create Request for the file that was saved in your documents folder
            NSURL *url = [NSURL fileURLWithPath:filePath];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            
            [_webView setUserInteractionEnabled:YES];
            [_webView setDelegate:self];
            [_webView loadRequest:requestObj];
        }];
        [operation start];

    }
   }
@end
