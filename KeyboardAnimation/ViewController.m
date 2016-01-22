//
//  ViewController.m
//  KeyboardAnimation
//
//  Created by Sonja Riethig on 22/01/16.
//  Copyright © 2016 Sonja Riethig. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textInputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(moveKeyboardInResponseToNotification:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(moveKeyboardInResponseToNotification:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)didPressResignButton:(id)sender {
    [self.textInputField resignFirstResponder];
}

- (void)moveKeyboardInResponseToNotification:(NSNotification *)notification {
    NSDictionary *infoDictionary = [notification userInfo];
    
    CGRect keyboardHeight;
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        keyboardHeight = [[infoDictionary objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    } else {
        keyboardHeight = CGRectZero;
    }
    
    CGFloat duration = [[infoDictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve = [[infoDictionary objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self.view layoutSubviews];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.bottomLayout.constant = keyboardHeight.size.height;
    [self.view layoutSubviews];
    
    [UIView commitAnimations];
}

@end
