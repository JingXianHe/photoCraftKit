//
//  OpenSceneController.m
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 12/22/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import "OpenSceneController.h"
#import "ViewController.h"

@interface OpenSceneController ()

@property (weak, nonatomic) IBOutlet UIImageView *startYourJourney;

@end

@implementation OpenSceneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startOurJourney)];
    [self.startYourJourney addGestureRecognizer:singleTap];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startOurJourney {
    // 显示主控制器（HMTabBarController）
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = (ViewController *)[sb instantiateViewControllerWithIdentifier:@"HomeLand"];
    
    // 切换控制器不要用push和modal这样会保留这个动画控制器在内存
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}
@end
