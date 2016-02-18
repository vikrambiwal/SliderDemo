//
//  ImageScrollViewController.m
//  SliderDeomo
//
//  Created by GauravDS on 09/11/15.
//  Copyright © 2015 baltech. All rights reserved.
//

#import "ImageScrollViewController.h"

@interface ImageScrollViewController (){
    UIScrollView *scrollView;
    NSArray * arrData;
    UIPageControl *imagePageController;
    NSInteger currentIndex;
    
}

@end

@implementation ImageScrollViewController


-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data{
    if (self) {
        [self setPage:view data:data];
      
    }
    return self;
}

-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data pageController:(UIPageControl* )pageController{
    if (self) {
        [self setPage:view data:data];
        imagePageController = pageController;
        imagePageController.numberOfPages=data.count;
        
        
    }
    return self;
}
-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data buttonNext:(UIButton* )btnNext buttonPrevious:(UIButton* )btnPrevious{
    
    if (self) {
        [self setPage:view data:data];
        
        if(btnNext){
            [btnNext addTarget:self
                       action:@selector(nextClick:)
             forControlEvents:UIControlEventTouchUpInside];
        }
        if(btnPrevious){
            [btnPrevious addTarget:self
                        action:@selector(previousClick:)
              forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }
    return self;
}

- (void)setPage:(UIScrollView *)view data:(NSMutableArray *)data{
    arrData=data;
    scrollView=view;
    
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    UIImageView *imgView;
    for (int i = 0; i < [arrData count]; i++) {
        NSString *imageName = [arrData objectAtIndex:i];
        
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        imgView=[[UIImageView alloc] initWithFrame:frame];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        imgView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imgView];
        
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [arrData count], scrollView.frame.size.height);
}


- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if([arrData count] > 1){
        currentIndex = (int)round(scrollView.contentOffset.x / scrollView.frame.size.width);
        [delegate pageChange:currentIndex];
        if(imagePageController)
            imagePageController.currentPage = currentIndex;
    }
}


- (void)nextClick:(id)sender {
    
    if(currentIndex+1< [arrData count]){
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * (currentIndex+1);
        [scrollView scrollRectToVisible:frame animated:YES];
        
    }
}

- (void)previousClick:(id)sender {
    
    if(currentIndex-1 >=0){
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * (currentIndex-1);
        [scrollView scrollRectToVisible:frame animated:YES];
        
    }
    
}



- (void) setDelegate:(id)newDelegate{
    delegate = newDelegate;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
