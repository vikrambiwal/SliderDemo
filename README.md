# SliderDemo
1. Download project
2. Copy "ImageScrollViewController" class in your project.
3. Example

    3.1 With page controller example:


        imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData              pageController:pageController];
    
        [imageViewController setDelegate:self];
    
    3.2  Without page controller example:

        imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData];
        [imageViewController setDelegate:self];
  
    3.3 With next, previous example:

          imageViewController=[[ImageScrollViewController alloc] initWithController:scrollView data:arrData buttonNext:btnNext buttonPrevious:btnPrevious];
        [imageViewController setDelegate:self];
  
