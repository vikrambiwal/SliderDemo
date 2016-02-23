//
//  ImageScrollViewController.h
//  SliderDeomo
//
//  Created by GauravDS on 09/11/15.
//  Copyright © 2015 baltech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageScrollDellegate <NSObject>
@required
- (void) pageChange: (NSInteger)pageNumber;

@end

@interface ImageScrollViewController : NSObject<UIScrollViewDelegate>{
    id <ImageScrollDellegate> delegate;
}

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data;

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data pageController:(UIPageControl* )pageController;

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data buttonNext:(UIButton* )btnNext buttonPrevious:(UIButton* )btnPrevious ;

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data buttonNext:(UIButton* )btnNext buttonPrevious:(UIButton* )btnPrevious pageController:(UIPageControl* )pageController;

- (void)setDelegate:(id)newDelegate;

@end
