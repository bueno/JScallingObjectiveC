//
//  ViewController.m
//  JavaScriptTest
//
//  Created by Luiz Henrique Bueno on 10/19/18.
//  Copyright © 2018 Nextouch Studios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (nonatomic, retain) IBOutlet UIWebView* webView;
@end

@implementation ViewController

// In Objective-C
-(void) viewDidLoad
{
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                          pathForResource:@"test" ofType:@"html"]isDirectory:NO]]];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Intercept custom location change, URL begins with "js-call:"
    if ([[[request URL] absoluteString] hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [[[request URL] absoluteString] componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        [self performSelector:NSSelectorFromString(function)];
        
//        [self performSelector:NSSelectorFromString(@"closeView")];

        return NO;
    }
    
    return YES;    
}

- (void)closeWindow {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"It is working! I'm gonna close the window..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end

