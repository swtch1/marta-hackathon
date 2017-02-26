//
//  BookViewController.m
//  MARTAmobility
//
//  Created by Darshan Gulur Srinivasa on 10/28/16.
//  Copyright © 2016 Marta. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *sourceTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)bookATripTapped:(id)sender {
    [self.sourceTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:true];
}

@end
