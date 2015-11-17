//
//  ViewController.m
//  SliderDeomo
//
//  Created by GauravDS on 05/11/15.
//  Copyright © 2015 baltech. All rights reserved.
//

#import "ViewController.h"
#import "ImageScrollViewController.h"

@interface ViewController (){
    
    IBOutlet UIScrollView *scrollView;
    ImageScrollViewController *imageViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray* arrData= [[NSMutableArray alloc] initWithArray:@[@"img_1.jpg",@"img_2.jpg",@"img_3.jpg",@"img_4.jpg",@"img_5.jpg"]];
                              
    imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData delegate:self];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
