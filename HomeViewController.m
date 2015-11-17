//
//  HomeViewController.m
//  HealthBeacon
//
//  Created by GauravDS on 15/10/15.
//  Copyright © 2015 com.balaji.inapp. All rights reserved.
//

#import "HomeViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface HomeViewController ()<WCSessionDelegate>{
    
    IBOutlet UILabel *lblDropsOnTime;
    IBOutlet UILabel *lblDrops;
    IBOutlet UILabel *lblActivePatlents;
    IBOutlet UILabel *lblAderence;
    
    IBOutlet UIButton *btnDropsOnTime;
    IBOutlet UIButton *btnDrops;
    IBOutlet UIButton *btnActivePatlents;
    IBOutlet UIButton *btnAderence;
    
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the vieww.
    //NSLog(@"%@",[self getData]);
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
    }
    
    NSDictionary* data=[self getData:YES];
    
//    NSDictionary* keyData=[data  objectForKey:@"medication_cycle"];
//    NSLog(@"%@",[keyData  objectForKey:@"on_time_drops"]);
//    lblDropsOnTime.text= [NSString stringWithFormat:@"%@",[keyData  objectForKey:@"on_time_drops"]];
//    lblDrops.text= [NSString stringWithFormat:@"%@", [keyData  objectForKey:@"total_drops"]];
//    lblAderence.text= [NSString stringWithFormat:@"%@%%",[keyData  objectForKey:@"adherence"]];
//    lblActivePatlents.text= [NSString stringWithFormat:@"%@",[data  objectForKey:@"active_patients"]];
    
    
    [btnDropsOnTime setTitle:[NSString stringWithFormat:@"%@",[data  objectForKey:@"on_time_drops"]] forState:UIControlStateNormal];
   
    [btnDrops setTitle: [NSString stringWithFormat:@"%@", [data  objectForKey:@"accumulated_drops"]] forState:UIControlStateNormal];
    
    [btnActivePatlents setTitle:[NSString stringWithFormat:@"%@",[data  objectForKey:@"active_patients"]] forState:UIControlStateNormal];
    
    [btnAderence setTitle:[NSString stringWithFormat:@"%@%%",[data  objectForKey:@"adherence"]] forState:UIControlStateNormal];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
   // self.navigationController.navigationBarHidden=YES;
}


#pragma mark - user session
-(NSDictionary*)getData:(BOOL)isInner{
    
    NSMutableURLRequest *request;
//    if(isInner){
//       request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://live.healthbeacon.com/api/stats/?format=json"]];
//    }else{
//       request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://live.healthbeacon.com/api/last-injection/?format=json"]];
//    
//    }
    if(isInner){
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://live.healthbeacon.com/api/stats/?product=Humira&country=Ireland&format=json"]];
    }else{
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://live.healthbeacon.com/api/last-injection/?product=Humira&format=json"]];
        
    }
    
    
    
    
    
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse __autoreleasing *response;
    NSError __autoreleasing *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil && response.statusCode == 200) {
        
        NSString *returnString = [[NSString alloc] initWithData:returnData
                                                       encoding:NSUTF8StringEncoding];
        NSData* data=[returnString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonError;
        NSMutableDictionary  *json = [[NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonError] mutableCopy];
//     NSMutableDictionary * keyData=[[json  objectForKey:@"demographics"] mutableCopy];
        
        
//        // [lblAddress sizeToFit];
//        NSLog(@"DATE - %@", [keyData  objectForKey:@"time"]);
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        //    dateFormatter.locale = [NSLocale currentLocale];
//        NSDate *date = [dateFormatter dateFromString:[keyData  objectForKey:@"time"]];
//        //    date = [dateFormatter dateFromString:@"2015-19-10 07:45:21"];
//        [dateFormatter setDateFormat:@"MMM d,YYYY "];
//        //NSDate *myDate = [dateFormatter stringFromDate:date];
//        NSString  *myDate =[NSString stringWithFormat:@"%@",  [dateFormatter stringFromDate:date]];
//        [dateFormatter setDateFormat:@" HH:mm a"];
//        [keyData setObject:[NSString stringWithFormat:@" %@ at %@",myDate,  [dateFormatter stringFromDate:date]] forKey:@"time"];
//        [json setObject:keyData forKey:@"demographics"];
//        
        
        return json;
    }else{
        
        return [[NSDictionary alloc ] init];
    }
}

- (IBAction)showNotification:(id)sender{
    
}

/*
 Discussion
 This method is called in response to a message sent by the counterpart process using the sendMessage:replyHandler:errorHandler: method. This specific method is called when the counterpart specifies a valid reply handler, indicating that it wants a response. Use this method to process the message data and provide an appropriate reply. You must execute the reply block as part of your implementation.
 
 Use messages to communicate quickly with the counterpart process. Messages can be sent and received only while both processes are active and running.
 
 The delivery of multiple messages occurs serially, so your implementation of this method does not need to be reentrant. This method is called on a background thread of your app.
 */
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> * )message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    NSLog(@"didReceiveMessage with replyHandler");
    
    if(message){
        
        NSString* command = [message objectForKey:@"request"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.replyLabel setText:command];
        });
        
        
        
        NSString* otherCounter = [message objectForKey:@"counter"];
        
        
        NSDictionary* response = @{@"response" : [NSString stringWithFormat:@"Message %@ received.",otherCounter]} ;
        
        
        if (replyHandler != nil) replyHandler(response);
        
        NSLog(@"iPhone received message from watch +++++  %@", message);
        
        if([command isEqualToString:@"1"]){//home page
            NSDictionary *resultSet = [self getData:YES];
            NSLog(@"%@", resultSet);
            [self packageAndSendMessage:resultSet];
        }else  if([command isEqualToString:@"4"]){//notification page
            NSDictionary *resultSet = [self getData:NO];
            NSLog(@"%@", resultSet);
            [self packageAndSendMessage:resultSet];
        }else  if([command isEqualToString:@"2"]){
            NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
            
            NSDictionary *resultSet;
            
            if([userDefault valueForKey:@"password"])
                resultSet = @{@"password":[userDefault valueForKey:@"password" ]};
            else
                resultSet = @{@"password":@"password"};
            [self packageAndSendMessage:resultSet];
            
        }else  if([command isEqualToString:@"3"]){
            NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
            
            NSString *str= [message objectForKey:@"password"];
            [userDefault setValue:str forKey:@"password"];
             NSDictionary *resultSet;
            [[NSUserDefaults standardUserDefaults] synchronize];
            resultSet = @{@"password":@"password"};
            [self packageAndSendMessage:[message objectForKey:@"password"]];
            
        }
        
    }
}
/**
 Standard WatchKit delegate
 */
-(void)sessionWatchStateDidChange:(nonnull WCSession *)session
{
    
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
        
        if(session.reachable){
            NSLog(@"session.reachable");
        }
        
        if(session.paired){
            if(session.isWatchAppInstalled){
                
                if(session.watchDirectoryURL != nil){
                    
                    
                }
                
            }
        }
        
        
    }
}

/**
 Uses given Dictionary to send and handle its reply and any errors.
 
 @param request message that is sent to the counterpart device - keyword, value.
 
 @return void
 */
-(void)packageAndSendMessage: (NSDictionary*)request
{
    /*
     Discussion
     Before retrieving the default session object, call this method to verify that the current device supports watch connectivity. Session objects are always available on Apple Watch. They are also available on iPhones that support pairing with an Apple Watch. For all other devices, this method returns NO to indicate that you cannot use the classes and methods of this framework.
     */
    if(WCSession.isSupported){
        
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
        /*
         Discussion
         In your WatchKit extension, the value of this property is YES when a matching session is active on the user’s iPhone and the device is within range so that communication may occur. On iOS, the value is YES when the paired Apple Watch is in range and the associated Watch app is running in the foreground. In all other cases, the value is NO.
         
         The counterpart must be reachable in order for you to send messages using the sendMessage:replyHandler:errorHandler: and sendMessageData:replyHandler:errorHandler: methods. Sending messages to a counterpart that is not reachable results in an error.
         
         The session must be configured and activated before accessing this property.
         */
        if(session.reachable)
        {
            /*
             Discussion
             Use this message to send a dictionary of data to the counterpart as soon as possible. Messages are queued serially and delivered in the order in which you sent them. Delivery of the messages happens asynchronously, so this method returns immediately.
             
             If you specify a reply handler block, your handler block is executed asynchronously on a background thread. The block is executed serially with respect to other incoming delegate messages.
             
             Calling this method from your WatchKit extension while it is active and running wakes up the corresponding iOS app in the background and makes it reachable. Calling this method from your iOS app does not wake up the corresponding WatchKit extension. If you call this method and the counterpart is unreachable (or becomes unreachable before the message is delivered), the errorHandler block is executed with an appropriate error. The errorHandler block may also be called if the message parameter contains non property list data types.
             */
            
            [session sendMessage:request replyHandler: ^(NSDictionary <NSString *,id> * __nonnull replyMessage)
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //                     NSLog(@".....replyHandler iPhone called --- %@",replyMessage);
                     
                     NSDictionary* message = replyMessage;
                     
                     //                     NSString* response = message[@"response"];
                     
                     //                     if(response)
                     //                         [self.replyLabel setText:response];
                     //                     else
                     //                         [self.replyLabel setText:@"nil"];
                     
                 });
                 
             }
             
                    errorHandler:^(NSError * __nonnull error) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"error: %@",error.localizedDescription);
                            //                            [self.replyLabel setText:error.localizedDescription];
                        });
                        
                    }
             ];
        }
        else
        {
            //            [self.replyLabel setText:@"Session Not reachable"];
        }
        
    }
    else
    {
        //        [self.replyLabel setText:@"Session Not Supported"];
    }
    
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
