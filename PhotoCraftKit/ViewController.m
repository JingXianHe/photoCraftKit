//
//  ViewController.m
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/18/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "UIBezierPathPool.h"

@interface ViewController ()<SettingViewControllerDelegate>

@property(nonatomic, assign)BOOL navigationBarIsOpen;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationLeading;
@property (weak, nonatomic) IBOutlet UIImageView *RealImageView;
@property (weak, nonatomic) IBOutlet UIImageView *TempImageView;
//context tool bar
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoAddEffectHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *drawLinesHeight;
//end
- (IBAction)enterDrawingContext;
- (IBAction)enterPhotoEdit;
- (IBAction)enterPatternZone;

//drawing panel
- (IBAction)colorBtnPressed:(UIButton *)sender;
@property(strong, nonatomic)NSMutableArray *colors;


//end

@property(weak, nonatomic)UIView *coverView;
@end

@implementation ViewController

- (IBAction)navigationPressed {
    if (self.navigationBarIsOpen == NO) {
        _isDrawingZone = NO;
        _isPatternZone = NO;
        [self.navigationView setNeedsLayout];
        [self.contentView setNeedsLayout];
        self.navigationLeading.constant = 0;
        self.contentView.userInteractionEnabled = NO;
        self.navigationView.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.navigationView layoutIfNeeded];
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.navigationView.userInteractionEnabled = YES;
        }];

    }else{
        
        [self.navigationView setNeedsLayout];
        [self.contentView setNeedsLayout];
        self.navigationLeading.constant = -90.0;
        self.contentView.userInteractionEnabled = NO;
        self.navigationView.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.navigationView layoutIfNeeded];
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.navigationView.userInteractionEnabled = YES;
        }];

    }
    self.navigationBarIsOpen = !self.navigationBarIsOpen;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBarIsOpen = NO;
    self.photoAddEffectHeight.constant = 0;
    _opacity = 1.0;
    _brushWidth = 5.0;
    _isDrawingZone = false;
    _red = 0.0;
    _blue = 0.0;
    _green = 0.0;
    //set up pattern panel
    self.pathType = 100;
    self.sizePickerIndex = 0;
    self.fillOrStrokePickerIndex = 0;
    self.size = CGSizeMake(20, 20);
    self.distance = 30;
    self.lineWidth = 3;
    
}

-(void)setSizePickerIndex:(int)sizePickerIndex{
    _sizePickerIndex = sizePickerIndex;
    if (sizePickerIndex == 0) {
        self.size = CGSizeMake(20, 20);
    }else if(sizePickerIndex == 1){
        self.size = CGSizeMake(40, 40);
    }else{
        self.size = CGSizeMake(60, 60);
    }
}

-(void)closeAllContextToolBars{
    self.photoAddEffectHeight.constant = 0;
    self.drawLinesHeight.constant = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterDrawingContext {
    [self closeAllContextToolBars];
    self.photoAddEffectHeight.constant = 90;
    [self navigationPressed];
    [self initAllZoneTag];
    _isDrawingZone = true;
}

- (IBAction)enterPhotoEdit {
    [self closeAllContextToolBars];
    self.drawLinesHeight.constant = 90;
    [self navigationPressed];
    [self initAllZoneTag];
    _isPhotoZone = true;
}

- (IBAction)enterPatternZone {
    [self closeAllContextToolBars];
    self.photoAddEffectHeight.constant = 90;
    [self navigationPressed];
    [self initAllZoneTag];
    _isPatternZone = true;
    
}
-(void)initAllZoneTag{
    _isPatternZone = false;
    _isDrawingZone = false;
    _isPhotoZone = false;
}
// for drawing panel
-(NSMutableArray *)colors{
    if (_colors == nil) {
        NSMutableArray *tempColors = [[NSMutableArray alloc]init];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, 1.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(51.0 / 255.0, 204.0 / 255.0, 1.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(102.0 / 255.0, 204.0 / 255.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(102.0 / 255.0, 1.0, 0,1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 102.0 / 255.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 1.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 1.0, 1.0, 1)]];
        _colors = tempColors;
        return _colors;
    }
    return _colors;
}
- (IBAction)colorBtnPressed:(UIButton *)sender {
    // 1
    int index = (int)sender.tag;
    
    // 2
    CGRect tempRect = [self.colors[index] CGRectValue];
    _red = tempRect.origin.x;
    _green = tempRect.origin.y;
    _blue = tempRect.size.width;
    
    
    // 3
    if (index == self.colors.count - 1) {
        _opacity = 1.0;
    }
    
}
// MARK: - Actions
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isDrawingZone == true) {
        _swiped = false;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            _lastpoint = tempLast;
            
        }
    }else if(_isPatternZone){
        _swiped = false;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            _lastpoint = tempLast;
            
        }
    }
    

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isDrawingZone == true) {
        _swiped = true;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            
            
            [self drawLineFrom:_lastpoint toPoint: tempLast];
            _lastpoint = tempLast;
        }
    }else if(_isPatternZone){
        _swiped = true;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint currentPoint = [touch locationInView:self.TempImageView];
            CGFloat deltaX = currentPoint.x - _lastpoint.x;
            CGFloat deltaY = currentPoint.y - _lastpoint.y;
            
            CGFloat powX = pow(deltaX,2);
            CGFloat powY = pow(deltaY,2);
            
            CGFloat distance = sqrt(powX + powY);
            if (distance >= self.distance){
                [self drawPatternFromPoint:_lastpoint toPoint:currentPoint];
                _lastpoint = currentPoint;
            }
        }
    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isDrawingZone == true) {
        if (_swiped ==false) {
            // draw a single point
            [self drawLineFrom:_lastpoint toPoint:_lastpoint];
        }
    }else if(_isPatternZone){
        if (_swiped ==false) {
            // draw a single point
            [self drawPatternFromPoint:_lastpoint toPoint:_lastpoint];
        }
    }

    
    // Merge tempImageView into mainImageView
//    UIGraphicsBeginImageContext(mainImageView.frame.size)
//    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .Normal, alpha: 1.0)
//    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .Normal, alpha: opacity)
//    mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    
//    tempImageView.image = nil
}




-(void)drawPatternFromPoint:(CGPoint)lastPoint toPoint:(CGPoint)currentPoint{

    UIGraphicsBeginImageContext(self.TempImageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    [self.TempImageView.image drawInRect:self.TempImageView.bounds];
    
    UIBezierPath *path1;
    CGRect rect4Offset;
    if (self.pathType == 100) {
        path1  = [UIBezierPathPool getCirclePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 101) {
        path1  = [UIBezierPathPool getTrianglePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 102) {
        path1  = [UIBezierPathPool getSnowPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 103) {
        path1  = [UIBezierPathPool getGearPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 104) {
        path1  = [UIBezierPathPool getGiftPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 105) {
        path1  = [UIBezierPathPool getMaplePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 106) {
        path1  = [UIBezierPathPool getHeartPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }
    else if (self.pathType == 107) {
        path1  = [UIBezierPathPool getStarPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 108) {
        path1  = [UIBezierPathPool getPawPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }
    
    CGFloat offsetX = currentPoint.x - rect4Offset.size.width/2;
    CGFloat offsetY = currentPoint.y - rect4Offset.size.height/2;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, offsetX, offsetY);
    
    [path1 applyTransform:transform];
    if (self.fillOrStrokePickerIndex == 0) {
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetRGBStrokeColor(context, _red, _green, _blue, _opacity);
        path1.lineWidth = _lineWidth;
        [path1 stroke];
    }else{
        CGContextSetBlendMode(context, kCGBlendModeHardLight);
        CGContextSetRGBFillColor(context, _red, _green, _blue, _opacity);
        [path1 fill];
        
    }

    //很重要因为在
    self.TempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)drawLineFrom:(CGPoint)lastPoint toPoint:(CGPoint)currentPoint{
    // 1
    UIGraphicsBeginImageContext(self.TempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.TempImageView.image drawInRect:self.TempImageView.bounds];
    
    // 2
    CGContextMoveToPoint(context, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    
    // 3
    //不设置这个看到线条画出的效果是稀疏有横向有竖向的线段，效果非常难看
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, _brushWidth);
    CGContextSetRGBStrokeColor(context, _red, _green, _blue, 1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    // 4
    CGContextStrokePath(context);
    
    // 5
    self.TempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    self.TempImageView.alpha = _opacity;
    UIGraphicsEndImageContext();
}
//end
//delegate method
-(void)settingsViewControllerFinished:(SettingViewController *)SettingsViewController{
    
    _brushWidth= SettingsViewController.brushSlide.value;
     _opacity = SettingsViewController.alphaSlide.value;
     _red = SettingsViewController.redSlide.value;
    _green = SettingsViewController.greenSlide.value;
    _blue = SettingsViewController.blackSlide.value;
    
    self.pathType = SettingsViewController.pathType;
    self.sizePickerIndex = (int)SettingsViewController.sizePicker.selectedSegmentIndex;
    self.fillOrStrokePickerIndex = (int)SettingsViewController.fillOrStroke.selectedSegmentIndex;
    self.distance = SettingsViewController.distantPicker.value;
    self.lineWidth = SettingsViewController.strokeWidth.value;
    
    
}

//prepare jump to settingViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SettingViewController *destinationVC = (SettingViewController *)segue.destinationViewController;
    destinationVC.settingDelegate = self;
    destinationVC.brushWidth = _brushWidth;
    destinationVC.opacity = _opacity;
    destinationVC.red = _red;
    destinationVC.green = _green;
    destinationVC.blue = _blue;
    
    destinationVC.pathType = self.pathType;
    destinationVC.sizePickerIndex = self.sizePickerIndex;
    destinationVC.isFill = self.fillOrStrokePickerIndex;
    destinationVC.distance= self.distance;
    destinationVC.lineWidth = self.lineWidth;

    
}
@end
