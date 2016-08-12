//
//  ViewController.m
//  JsonUpdate


#import "ViewController.h"


@interface ViewController ()
{
    UITextView *text;
    NSMutableData *receivedData;
    AppDelegate *delegate;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.

    
    [self initViews];
}

- (void) initViews{
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0,100,320,35); //The position and size of the button (x,y,width,height)
    [btn setTitle:@"CALL JSON" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self
            action:@selector(callJSON:)
  forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //--------------
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 170, 320, 400)];
    myTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:.1];
    myTextView.userInteractionEnabled = NO;
    [self.view addSubview:myTextView];
    text = myTextView;
    
    delegate = [[UIApplication sharedApplication] delegate];
    myTextView.text = [NSString stringWithFormat:@"%@",[delegate getDinamicdata]];
    
    
}

- (void) callJSON:(id)sender {
    
    
     NSURL *url = [NSURL URLWithString:@"http://your-host/json.php"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection)
    {
        
    }
    else
    {
        NSLog(@"Connection could not be established");
    }
   
}
#pragma mark - NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!receivedData)
        receivedData = [[NSMutableData alloc] initWithData:data];
    else
        [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"***** Connection failed");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(receivedData){
        NSError *errorJson=nil;
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:receivedData
                                      options:kNilOptions
                                      error:&errorJson];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseDict];
        [delegate saveData:[NSData dataWithData:data]];
        
        text.text = [NSString stringWithFormat:@"%@",[delegate getDinamicdata]];
    }
}

@end
