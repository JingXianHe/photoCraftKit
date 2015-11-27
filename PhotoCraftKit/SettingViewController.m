//
//  SettingViewController.m
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/18/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()
- (IBAction)closeCurrentPanel;
- (IBAction)selectedPattern:(UIButton *)sender;


@end

@implementation SettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

}
-(void)viewWillAppear:(BOOL)animated{
    self.brushLabel.text = [NSString stringWithFormat:@"%.1f",self.brushWidth];
    self.alphaLabel.text = [NSString stringWithFormat:@"%.1f",self.opacity];
    self.redLabel.text = [NSString stringWithFormat:@"%.1f",self.red];
    self.greenLabel.text = [NSString stringWithFormat:@"%.1f",self.green];
    self.blackLabel.text = [NSString stringWithFormat:@"%.1f",self.blue];
    self.brushSlide.value = self.brushWidth;
    self.alphaSlide.value = self.opacity;
    self.redSlide.value = self.red;
    self.greenSlide.value = self.green;
    self.blackSlide.value = self.blue;
    
    self.sizePicker.selectedSegmentIndex = (long)self.sizePickerIndex;
    self.fillOrStroke.selectedSegmentIndex = (long)self.isFill;
    self.distantPicker.value = self.distance;
    self.strokeWidth.value = self.lineWidth;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeCurrentPanel {
    self.brushWidth = self.brushSlide.value;
    self.opacity = self.alphaSlide.value;
    self.red = self.redSlide.value;
    self.green = self.greenSlide.value;
    self.blue = self.blackSlide.value;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.settingDelegate settingsViewControllerFinished:self];
}

- (IBAction)selectedPattern:(UIButton *)sender {
    int index = (int)sender.tag;
    self.pathType = index;
}
@end
