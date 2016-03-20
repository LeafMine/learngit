//
//  ViewController.m
//  Test_Wifi
//
//  Created by 宋瑞航 on 16/2/15.
//  Copyright © 2016年 SRH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic)UIAlertAction * secureTextAlertAction;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testAlert];
}

- (void)testAlert
{
    UIAlertController * alertController =  [UIAlertController alertControllerWithTitle:@"提示" message:@"不能打开wifi" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
    }];
    UIAlertAction * other1 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"other1");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
    }];
    other1.enabled = NO;
    self.secureTextAlertAction = other1;
    
    [alertController addAction:cancle];
    [alertController addAction:other1];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        textField.secureTextEntry = YES;
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)testWifi
{
    NSURL * url = [NSURL URLWithString:@"prefs:root=Blue"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        UIAlertController * alertController =  [UIAlertController alertControllerWithTitle:@"提示" message:@"不能打开wifi" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction * other = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"其它");
        }];
        
        [alertController addAction:cancle];
        [alertController addAction:other];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)textChangeNotification:(NSNotification *)notification
{
    UITextField * textField = notification.object;
    self.secureTextAlertAction.enabled = textField.text.length >= 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
