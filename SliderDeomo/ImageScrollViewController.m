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
    UIViewController* delegate;
    NSArray * arrData;
}

@end

@implementation ImageScrollViewController


-(instancetype)initWithController:(UIScrollView *)view data:(NSMutableArray *)data  delegate:(UIViewController* )obj{
    if (self) {
        delegate=obj;
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
//            [imgView setBackgroundColor:[UIColor grayColor ]];
            imgView.image = [UIImage imageNamed:imageName];
            [scrollView addSubview:imgView];
            
        }
        
        //Set the content size of our scrollview according to the total width of our imageView objects.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [arrData count], scrollView.frame.size.height);
        
        
    }
    return self;
}

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

@end
