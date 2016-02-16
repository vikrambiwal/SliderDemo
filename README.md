# SliderDemo
1. Download project
2. Copy "ImageScrollViewController.h" file in your project.
3. With page controller example:


    imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData              pageController:pageController];
    [imageViewController setDelegate:self];
    
4. Without page controller example:

  imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData];
  [imageViewController setDelegate:self];
