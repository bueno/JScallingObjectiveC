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

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                          pathForResource:@"test" ofType:@"html"]isDirectory:NO]];
    [self.webView setDelegate:self];
    [self.webView loadRequest:request];
}

- (void)calledNativeFunction {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"It is working! This is an Objective-C function...." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[[request URL] absoluteString] hasPrefix:@"js-call:"]) {
        [self performSelector:@selector(calledNativeFunction)];
        return NO;
    }
    return YES;
}

@end

