//
//  ViewController.m
//  MCMemberCenter
//
//  Created by Ken on 2014/10/6.
//  Copyright (c) 2014年 Ken. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    MCLogin* page;
}

@property (strong, nonatomic) NSString *objectID;
@property (strong, nonatomic) MCFacebook *mcFacebook;
@property (strong, nonatomic) ACAccountStore *accountStore;//ACAccountStore
@property (assign) BOOL isGoogleLogin;
@property (assign) BOOL isTwitterLogin;
@property (assign) BOOL isSinaWeiboLogin;
@property (assign) BOOL isYahooLogin;
@property (assign) BOOL isAPTGLogin;
@end

@implementation ViewController

@synthesize mcFacebook,mWebView,accountStore,isGoogleLogin,isTwitterLogin,isSinaWeiboLogin, isYahooLogin, isAPTGLogin;


- (id) init
{
    if (self = [super init])
    {
        // do your own initialisation here
    }
    return self;
}

- (void)viewDidLoad {
    //    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Ask for basic permissions on login
    //    [_fbLoginView setReadPermissions:@[@"public_profile"]];
    //    [_fbLoginView setDelegate:self];
    //    _objectID = nil;
    MCLogger(@"viewDidLoad>>>>>>>>>>");
    mcFacebook = [[MCFacebook alloc] init];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MCLogger(@"viewWillAppear>>>>>%@>>>>>",isGoogleLogin?@"YES":@"NO");
    
    if (isGoogleLogin == YES) {
        
        NSString* googleUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"googleUserID"];
        NSString* googleUserEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"googleUserEMAIL"];
        MCLogger(@"viewWillAppear>>>>>>%@",googleUserEmail);
        MCLogger(@"viewWillAppear>>>>>>%@",googleUserID);
        
        MCLogin* mcl = [[MCLogin alloc] init];
        
        [mcl GetAmbitUserInfoViaOpenID:googleUserEmail
                               openUID:googleUserID
                            login_type:LOGIN_TYPE_GOOGLE
                                 sysID:@"OTT_ARDI"
                               idGroup:@""
                               success:^(id responseObject) {
                                   
                                   NSData* responseData = (NSData*)responseObject;
                                   MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                                   
                                   
                                   NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:googleUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_GOOGLE,@"LOGIN_TYPE",googleUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       RegisterViewController* reg = [[RegisterViewController alloc] init];
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                   }
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                                       
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                                       
                                       OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                                       
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:googleUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_GOOGLE,@"LOGIN_TYPE",googleUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                       
                                       
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
    }else if (isTwitterLogin == YES) {
        
        NSString* twitterUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitterUserID"];
        NSString* twitterUserEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitterUserEMAIL"];
        MCLogger(@"viewWillAppear>>>>>>%@",twitterUserID);
        MCLogger(@"viewWillAppear>>>>>>%@",twitterUserEmail);
        
        MCLogin* mcl = [[MCLogin alloc] init];
        
        [mcl GetAmbitUserInfoViaOpenID:twitterUserEmail
                               openUID:twitterUserID
                            login_type:LOGIN_TYPE_TWITTER
                                 sysID:@"OTT_ARDI"
                               idGroup:@""
                               success:^(id responseObject) {
                                   
                                   NSData* responseData = (NSData*)responseObject;
                                   MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                                   
                                   
                                   NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:twitterUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_TWITTER,@"LOGIN_TYPE",twitterUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       RegisterViewController* reg = [[RegisterViewController alloc] init];
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                   }
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                                       
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                                       
                                       OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                                       
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:twitterUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_TWITTER,@"LOGIN_TYPE",twitterUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                       
                                       
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
    }else if (isSinaWeiboLogin == YES) {
        
        NSString* sinaWeiboUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaWeiboUserID"];
        NSString* sinaWeiboUserEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaWeiboUserEMAIL"];
        MCLogger(@"viewWillAppear>>>>>>%@",sinaWeiboUserID);
        MCLogger(@"viewWillAppear>>>>>>%@",sinaWeiboUserEmail);
        
        MCLogin* mcl = [[MCLogin alloc] init];
        
        [mcl GetAmbitUserInfoViaOpenID:sinaWeiboUserEmail
                               openUID:sinaWeiboUserID
                            login_type:LOGIN_TYPE_SINAWEIBO
                                 sysID:@"OTT_ARDI"
                               idGroup:@""
                               success:^(id responseObject) {
                                   
                                   NSData* responseData = (NSData*)responseObject;
                                   MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                                   
                                   
                                   NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:sinaWeiboUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_SINAWEIBO,@"LOGIN_TYPE",sinaWeiboUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       RegisterViewController* reg = [[RegisterViewController alloc] init];
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                   }
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                                       
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                                       
                                       OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                                       
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:sinaWeiboUserEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_TWITTER,@"LOGIN_TYPE",sinaWeiboUserID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                       
                                       
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
    } else if (isAPTGLogin == YES) {
        NSString* aptgUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"aptgUID"];
        NSString* aptgEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"aptgEmail"];
        NSString* aptgMDN = [[NSUserDefaults standardUserDefaults] objectForKey:@"aptgMDN"];
        MCLogger(@"viewWillAppear>>>>>>%@",aptgUID);
        MCLogger(@"viewWillAppear>>>>>>%@",aptgEmail);
        
        MCLogin* mcl = [[MCLogin alloc] init];
        
        [mcl GetAmbitUserInfoViaOpenID:aptgEmail
                               openUID:aptgUID
                            login_type:LOGIN_TYPE_APTG
                                 sysID:@"OTT_ARDI"
                               idGroup:@""
                               success:^(id responseObject) {
                                   
                                   NSData* responseData = (NSData*)responseObject;
                                   MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                                   
                                   
                                   NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:aptgEmail, @"EMAIL",aptgMDN, @"PHONE", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_SINAWEIBO,@"LOGIN_TYPE",aptgUID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       RegisterViewController* reg = [[RegisterViewController alloc] init];
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                   }
                                   
                                   if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                                       
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                                       
                                       OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                                       
                                       
                                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:aptgEmail, @"EMAIL",aptgMDN, @"PHONE", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_TWITTER,@"LOGIN_TYPE",aptgUID,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                       
                                       [reg setResultJason:dict];
                                       
                                       UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                       MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                       [rootViewController presentViewController:reg animated:YES completion:^{}];
                                       
                                       
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)facebook2Step:(id)sender {
    //  登入facebook用戶資料
    [mcFacebook login:^(id responseObject) {
        
        
        //  取得facebook用戶資料
        [mcFacebook getUser:^(id responseObject) {
            
            NSData* responseData = (NSData*)responseObject;
            MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
            
            
            NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
            MCLogger(@"%@",[resultJSON objectForKey:@"returnCode"]);
            //mc 註冊
            if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                
                MCLogger(@"FBLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                
                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:mcFacebook.email, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_FACEBOOK,@"LOGIN_TYPE",[resultJSON objectForKey:@"LOGIN_UID"],@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                
                RegisterViewController* reg = [[RegisterViewController alloc] init];
                [reg setResultJason:dict];
                
                UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                [rootViewController presentViewController:reg animated:YES completion:^{}];
                
                
            }
            //mc 綁定
            if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                
                MCLogger(@"FBLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                
                OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                
                
                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:mcFacebook.email, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_FACEBOOK,@"LOGIN_TYPE",[resultJSON objectForKey:@"LOGIN_UID"],@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                
                [reg setResultJason:dict];
                
                UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                MCLogger(@"FBLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                [rootViewController presentViewController:reg animated:YES completion:^{}];
                
                
            }
            
        }
                    failure:^(NSError *error) {
                        NSLog(@"getUser error");
                    }];
    }
              failure:^(NSError *error) {
                  NSLog(@"login error");
              }];
}


- (void)getGoogleUserLogin{
    MCLogger(@"getGoogleUserLogin>>>>>>INTO>>>>>>>");
    MCGooglePlus* reg = [[MCGooglePlus alloc] init];
    [[[UIApplication sharedApplication] keyWindow]addSubview:reg.view];
    MCLogger(@"getGoogleUserLogin>>>>>>END>>>>>>>");
}

- (IBAction)twitterLogin:(id)sender {
    
    isTwitterLogin = YES;
    MCTwitter* twitter = [[MCTwitter alloc] init];
    
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"twitterLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:twitter animated:YES completion:^{}];
    
    
}
- (IBAction)weiboLogin:(id)sender {
    
    isSinaWeiboLogin = YES;
    MCSinaWeibo* sinaWeibo = [[MCSinaWeibo alloc] init];
    
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"weiboLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:sinaWeibo animated:YES completion:^{}];
    
    
}

- (IBAction)ambitLogin:(id)sender {
    
    MCLogger(@"returnJason>>>%@",mcFacebook.facebookID);
    MCLogger(@"returnJason>>>%@",mcFacebook.email);
    
    AmbitLoginViewController* reg = [[AmbitLoginViewController alloc] init];
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"ambitLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:reg animated:YES completion:^{}];
    
}
- (IBAction)ambitReg:(id)sender {
    
    
    AmbitRegisterViewController* reg = [[AmbitRegisterViewController alloc] init];
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"ambitReg>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:reg animated:YES completion:^{}];
}


- (IBAction)googlePlusLogin:(id)sender {
    
    isGoogleLogin = YES;
    MCGooglePlus* reg = [[MCGooglePlus alloc] init];
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"googlePlusLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:reg animated:YES completion:^{}];
    
    MCLogger(@">>>>>END>>>>>>>");
    
}

- (IBAction)yahooLogin:(id)sender {
    MCLogger(@"YahooLogin>>>>>>>>>>>>>INTO>>>>>>>>>>>>>>");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate createYahooSession];
    NSLog(@"yahoo create finish>>>>>");
}
- (void)loadYahooUserProfile:(NSMutableDictionary *)params{
    NSLog(@"loadYahooUserProfile>>>>>");
    NSString *yahooGuid = [params objectForKey:@"yahooGuid"];
    NSLog(@"Yahoo GUID: %@", yahooGuid);
    NSString *yahooEmail = [params objectForKey:@"yahooEmail"];
    MCLogger(@"viewWillAppear>>>yahooEmail>>>%@",yahooEmail);
    MCLogin* mcl = [[MCLogin alloc] init];
    [mcl GetAmbitUserInfoViaOpenID:yahooEmail
                           openUID:yahooGuid
                        login_type:LOGIN_TYPE_YAHOO
                             sysID:@"OTT_ARDI"
                           idGroup:@""
                           success:^(id responseObject) {
 
                               NSData* responseData = (NSData*)responseObject;
                               MCLogger(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                               
                               
                               NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                               
                               if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-429"]) {
                                   MCLogger(@"YahooLogin>>>>>>>>>>>>>-429>>>>>>>>>>>>>>");
                                   
                                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:yahooEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_YAHOO,@"LOGIN_TYPE",yahooGuid,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                   
                                   RegisterViewController* reg = [[RegisterViewController alloc] init];
                                   [reg setResultJason:dict];
                                   [reg setLOGIN_TYPE:@"Yahoo"];
                                   
                                   UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                   MCLogger(@"YahooLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                   [rootViewController presentViewController:reg animated:YES completion:^{}];
                               }
                               
                               if ([[resultJSON objectForKey:@"returnCode"] isEqual:@"-430"]) {
                                   
                                   MCLogger(@"YahooLogin>>>>>>>>>>>>>-430>>>>>>>>>>>>>>");
                                   
                                   OpenIDBundlingViewController* reg = [[OpenIDBundlingViewController alloc] init];
                                   
                                   
                                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:yahooEmail, @"EMAIL", @"OTT_ARDI", @"SYS_ID",LOGIN_TYPE_YAHOO,@"LOGIN_TYPE",yahooGuid,@"LOGIN_UID",[resultJSON objectForKey:@"VALID_STR"],@"VALID_STR",[resultJSON objectForKey:@"CHECK_DATE"],@"CHECK_DATE", nil];
                                   
                                   [reg setResultJason:dict];
                                   [reg setLOGIN_TYPE:@"Yahoo"];
                                   
                                   UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
                                   MCLogger(@"YahooLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                                   [rootViewController presentViewController:reg animated:YES completion:^{}];
                                   
                                   
                               }
                               
                               NSLog(@"Yahoo登入成功~~~~~~~");
                               
                               MCLogger(@"YahooLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
                           } failure:^(NSError *error) {
                               
                           }];
}

- (IBAction)aptgLogin:(id)sender {
    isAPTGLogin = YES;
    APTGViewController* aptg = [[APTGViewController alloc] init];
    
    UIViewController* rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    MCLogger(@"aptgLogin>>>>>>>>>>>>>presentViewController>>>>>>>>>>>>>>");
    [rootViewController presentViewController:aptg animated:YES completion:^{}];
    
    
}
@end
