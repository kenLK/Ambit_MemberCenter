//
//  RegisterViewController.h
//  MCMemberCenter
//
//  Created by Ken on 2014/10/8.
//  Copyright (c) 2014年 Ken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MC/MCFramework.h>
#import <Foundation/Foundation.h>
#import "OpenIDBundlingViewController.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSMutableDictionary *resultJason;


@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *test;
@property (strong, nonatomic) IBOutlet NSString *LOGIN_TYPE;
@end
