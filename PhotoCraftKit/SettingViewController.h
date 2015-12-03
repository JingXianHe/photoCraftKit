//
//  SettingViewController.h
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/18/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingViewController;
@protocol SettingViewControllerDelegate<NSObject>
@optional
-(void)settingsViewControllerFinished:(SettingViewController *)SettingsViewController;
@end


@interface SettingViewController : UIViewController
@property(weak, nonatomic)id<SettingViewControllerDelegate> settingDelegate;
@property(assign, nonatomic)CGFloat brushWidth;
@property(assign, nonatomic)CGFloat opacity;
@property(assign, nonatomic)CGFloat red;
@property(assign, nonatomic)CGFloat green;
@property(assign, nonatomic)CGFloat blue;

@property (weak, nonatomic) IBOutlet UISlider *brushSlide;
@property (weak, nonatomic) IBOutlet UILabel *brushLabel;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlide;
@property (weak, nonatomic) IBOutlet UILabel *alphaLabel;
@property (weak, nonatomic) IBOutlet UISlider *redSlide;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UISlider *greenSlide;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UISlider *blackSlide;
@property (weak, nonatomic) IBOutlet UILabel *blackLabel;

@property(assign,nonatomic)int pathType;
@property(assign, nonatomic)int sizePickerIndex;
@property(assign, nonatomic)CGFloat distance;
@property(assign, nonatomic)int isFill;
@property(assign, nonatomic)CGFloat lineWidth;
@property (weak, nonatomic) IBOutlet UISlider *strokeWidth;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sizePicker;
@property (weak, nonatomic) IBOutlet UISlider *distantPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fillOrStroke;

//1st photo pane
@property(assign, nonatomic)CGFloat effectIntensity;
@property (weak, nonatomic) IBOutlet UISlider *effectIntensitySlider;
@property(assign, nonatomic)CGRect color4Mono;

@end
