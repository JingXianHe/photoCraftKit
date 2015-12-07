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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoEffect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineSetting;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *patternSetting;



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
    
    
    //set up 1st pane
    self.effectIntensitySlider.value = self.effectIntensity;
}
//select color 4 1st pane
- (IBAction)selectColor4Mono:(UIButton *)sender {
    if (sender.tag == 400) {
        self.color4Mono = CGRectMake(0.0, 0.0, 1.0, 0.9);
    }else if (sender.tag == 401) {
        self.color4Mono = CGRectMake(0.0, 1.0, 0.0, 0.9);
    }else if (sender.tag == 402) {
        self.color4Mono = CGRectMake(1.0, 0.0, 1.0, 0.9);
    }else{
        self.color4Mono = CGRectMake(0.823, 0.411, 0.117, 0.9);
    }
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
