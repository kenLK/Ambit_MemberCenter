//
//  RegisterViewController.m
//  MCMemberCenter
//
//  Created by Ken on 2014/10/8.
//  Copyright (c) 2014年 Ken. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize resultJason,email,phone,password,test,LOGIN_TYPE;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 120.0, 20.0)];
    [titleLabel setText:@"email"];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:titleLabel];
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(100, 50, 320.0, 20.0)];
    email.borderStyle = UITextBorderStyleRoundedRect;
//    [inputText setText:[content objectAtIndex:MPItemTitle]];
    [email setFont:[UIFont boldSystemFontOfSize:20]];
    
    email.delegate = self;
    [self.view addSubview:email];
    
    UILabel *titleLabelPhone = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 120.0, 20.0)];
    [titleLabelPhone setText:@"phone"];
    [titleLabelPhone setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:titleLabelPhone];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(100, 80, 320.0, 20.0)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    //    [inputText setText:[content objectAtIndex:MPItemTitle]];
    [phone setFont:[UIFont boldSystemFontOfSize:20]];
    phone.delegate=self;
    [self.view addSubview:phone];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = CGRectMake(self.view.frame.size.width/2.0, 320, 50, 20);
    [button setTitle:@"close" forState:UIControlStateNormal];
    
//    [button setBackgroundImage:nor forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:button];
    
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    submitButton.frame = CGRectMake(self.view.frame.size.width/2.0, 380, 50, 20);
    [submitButton setTitle:@"submit" forState:UIControlStateNormal];
    
    //    [button setBackgroundImage:nor forState:UIControlStateNormal];
    
    [submitButton addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:submitButton];
    
    NSLog(@"%@",[resultJason objectForKey:@"returnCode"]);
    NSLog(@"%@",[resultJason objectForKey:@"VALID_STR"]);
    NSLog(@"%@",[resultJason objectForKey:@"CHECK_DATE"]);
    
    if ([resultJason objectForKey:@"EMAIL"] != nil) {
        email.text = [resultJason objectForKey:@"EMAIL"];
    }
    
    if ([resultJason objectForKey:@"PHONE"] != nil) {
        phone.text = [resultJason objectForKey:@"PHONE"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)close{
    MCLogger(@"INTO >>>>>> CLOSE ");
    /*if (self.mView) {
        [self.mView removeFromSuperview];
    }*/
//    [self dismissModalViewControllerAnimated:YES completion:^(void){}];
    
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

    MCLogger(@"END >>>>>> CLOSE ");
}


-(void)submitData{
    MCLogger(@"INTO >>>>>> submitData ");
    /*if (self.mView) {
     [self.mView removeFromSuperview];
     }*/
    //    [self dismissModalViewControllerAnimated:YES completion:^(void){}];
    MCLogin* mcl = [[MCLogin alloc] init];
//    mcl RegisterAmbitUser:<#(NSString *)#> openUID:<#(NSString *)#> login_type:<#(NSString *)#> sysID:<#(NSString *)#>
    
    
//    NSString* returnCode = [resultJason objectForKey:@"returnCode"];
//    NSString* VALID_STR = [resultJason objectForKey:@"VALID_STR"];
//    NSString* CHECK_DATE = [resultJason objectForKey:@"CHECK_DATE"];
//    NSString* VALID_EMAIL_STR = [resultJason objectForKey:@"VALID_EMAIL_STR"];
//    NSString* returnCode = [resultJason objectForKey:@"returnCode"];
    resultJason = [resultJason mutableCopy];
    [resultJason removeObjectForKey:@"EMAIL"];
    
    [resultJason removeObjectForKey:@"PHONE"];
    [resultJason setValue:[self email].text forKey:@"EMAIL"];
    [resultJason setValue:[self phone].text forKey:@"PHONE"];
   
    
    
    
    for(NSString *key in [resultJason allKeys]) {
        NSLog(@"%@",[resultJason objectForKey:key]);
    }
    
    NSString *aLOGIN_TYPE = LOGIN_TYPE_FACEBOOK;
    if (![@"" isEqualToString:[resultJason objectForKey:@"LOGIN_TYPE"]] && [resultJason objectForKey:@"LOGIN_TYPE"] != nil) {
        aLOGIN_TYPE = [resultJason objectForKey:@"LOGIN_TYPE"];
    }
    
//    NSString *aLOGIN_TYPE = LOGIN_TYPE_FACEBOOK;
//    
//    if ([@"Yahoo"isEqualToString:LOGIN_TYPE]) {
//        aLOGIN_TYPE = LOGIN_TYPE_YAHOO;
//        NSLog(@"aLOGIN_TYPE %@", aLOGIN_TYPE);
//    }
    
    NSString* returnJason = [mcl RegisterAmbitUserInfoViaOpenID:aLOGIN_TYPE registerValue:resultJason];
    
    NSData* returnData = [returnJason dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* returnDict = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil ];
    
    //註冊時return code == -430 執行綁定作業
    if ([[returnDict objectForKey:@"returnCode"]  isEqualToString: @"-430"]) {
        OpenIDBundlingViewController *openIDBuling = [[OpenIDBundlingViewController alloc] init];
        
        [self presentViewController:openIDBuling animated:YES completion:^{}];
    }
    
    //    [rootViewController presentViewController:reg animated:YES completion:^{}];
    // dismiss
    MCLogger(@"%@",[self email].text);
    MCLogger(@"%@",returnJason);
    MCLogger(@"END >>>>>> submitData ");
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
