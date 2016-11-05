//  LTAWebView.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAWebView.h"

@interface LTAWebView () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *webBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *webForwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *webRefreshButton;

- (void)loadURLFromString:(NSString *)urlString;
- (void)updateButtons;

@end

@implementation LTAWebView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadURLFromString:@"https://www.bottlerocketstudios.com/"];
}

- (void)loadURLFromString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
}

- (void)updateButtons
{
    _webBackButton.enabled = _webView.canGoBack;
    _webForwardButton.enabled = _webView.canGoForward;
    _webRefreshButton.enabled = _webView.loading;
}

//Button Actions
- (IBAction)webBack:(UIBarButtonItem *)sender
{
    [_webView goBack];
}

- (IBAction)webForward:(UIBarButtonItem *)sender
{
    [_webView goForward];
}

- (IBAction)webRefresh:(UIBarButtonItem *)sender
{
    [_webView reload];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
