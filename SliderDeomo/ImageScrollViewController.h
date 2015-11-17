//
//  ImageScrollViewController.h
//  SliderDeomo
//
//  Created by GauravDS on 09/11/15.
//  Copyright © 2015 baltech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollViewController : UIViewController<UIScrollViewDelegate>

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data  delegate:(UIViewController* )obj;

@end
