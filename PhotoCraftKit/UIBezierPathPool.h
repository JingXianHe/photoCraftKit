//
//  UIBezierPathPool.h
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/26/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPathPool : NSObject

+(UIBezierPath *)getTrianglePath:(int)sizePickerIndex;
+(UIBezierPath *)getCirclePath:(int)sizePickerIndex;
+(UIBezierPath *)getSnowPath:(int)sizePickerIndex;
@end
