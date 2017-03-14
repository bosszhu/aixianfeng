//
//  ViewController.m
//  flood
//
//  Created by Huster on 2016/11/12.
//  Copyright © 2016年 Huster. All rights reserved.
//

#import "ANMLookFor.h"
#import "DSHTTPClient.h"
#import "ANMLookForCollectionView.h"
#import "ANMLookDetail.h"
#import <SVProgressHUD.h>

@interface ANMLookFor ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation ANMLookFor

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchTextField.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.searchTextField.text  = @"";
}
- (IBAction)didClickSuannai:(id)sender {
    ANMLookDetail *new = [ANMLookDetail new];
    new.textString = @"酸奶";
    [self showHUD:@"正在查找"];
    [self.navigationController pushViewController:new animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        ANMLookDetail *new = [ANMLookDetail new];
        new.textString = textField.text;
        [self showHUD:@"正在查找"];
        [self.navigationController pushViewController:new animated:YES];
    }
    return YES;
}

- (void)showHUD:(NSString *)HUDString {
    [SVProgressHUD showInfoWithStatus:HUDString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}


@end
