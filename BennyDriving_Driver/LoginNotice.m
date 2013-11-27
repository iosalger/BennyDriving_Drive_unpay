//
//  LoginNotice.m
//  BennyDriving_Driver
//
//  Created by BennyDriving on 9/26/13.
//  Copyright (c) 2013 BennyDriving. All rights reserved.
//

#import "LoginNotice.h"
#import "tooles.h"

@interface LoginNotice ()

@end

@implementation LoginNotice

@synthesize delegate,Notice;

-(void)viewDidLoad
{
    //Notice.delegate=self;
    //Notice = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    //Notice.scalesPageToFit = YES;
    //[self.view addSubview:Notice];
    
    //UIButton *close
    
    [self loadWebPageWithString];
    
    [tooles showHUD:@"正在加载...."]; 
    

}

- (void)loadWebPageWithString
{
    NSString *urlstring = [NSString stringWithFormat:@"http://www.4008200972.com/gs/"];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [Notice loadRequest:request];
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGRect frame = webView.frame;
    
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    
    frame.size = fittingSize;
    
    webView.frame = frame;
    
    [tooles removeHUD];
    
    //[activityIndicatorView stopAnimating];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[activityIndicatorView startAnimating] ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    //[alterview release];
}

- (void)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
