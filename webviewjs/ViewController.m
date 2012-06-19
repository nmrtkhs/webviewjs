//
//  ViewController.m
//  webviewjs
//
//  Created by Nomura_Takahisa on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

NSDictionary* queryAsDictionary(NSURL* nsURL){
    NSArray *components = [[nsURL query] componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NSString *component in components) {
        NSArray *keyAndValues = [component componentsSeparatedByString:@"="];
        [parameters setObject:[keyAndValues objectAtIndex:1] forKey:[keyAndValues objectAtIndex:0]];
    }   
    return parameters;
}

@interface ViewController ()

@end

@implementation ViewController
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //UIWebViewの生成
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = NO;
    self.webView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self.view addSubview:webView];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

/**
 * 読み込みを開始するかどうか
 *
 * @param webView        ウェブビュー
 * @param request        リクエスト
 * @param navigationType ユーザアクションの種類
 *
 * @return 開始する場合は YES、開始しない場合は NO
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *requestURL = [request URL];
	NSString *scheme = [requestURL scheme];
	NSString *host = [requestURL host];
	NSString *path = [requestURL path];	
    
    NSLog(@"url=%@",requestURL);
    
	if (scheme && [scheme hasPrefix:@"method"] && 
			   host && [host isEqualToString:@"JSKicker"]){
        
        NSDictionary *query = queryAsDictionary(requestURL);
        NSLog(@"path=%@", path);
        if(path && [path isEqualToString:@"/shot"]){
            NSLog(@"shot x=%@ y=%@", [query objectForKey:@"x"], [query objectForKey:@"y"]);
        }
		
        return NO;
	} 	
		
    return YES;
}


@end


