//
//  DetailViewController.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "DetailViewController.h"
#import "ThumbViewController.h"
#import "HMSideMenu.h"

@interface DetailViewController ()
@property (nonatomic,strong)IBOutlet UIImageView * imageView;
@property (strong, nonatomic) IBOutlet UIToolbar *Toolbar;

- (IBAction)TapGesture:(id)sender;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ZanBtnPressed:(UIBarButtonItem *)sender {
    
}
-(void)CommentBtnPressed:(id)sender{
    
}
-(void)ShareBtnPressed:(id)sender{
    
}
-(void)ThumbBtnPressed:(id)sender{
//    ThumbViewController * thumbViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ThumbView"];
//    [self presentViewController:thumbViewController animated:YES completion:^(){
//    
//    }];
    
}
- (IBAction)TapGesture:(id)sender {
    CATransition *trans=[CATransition animation];
    trans.type=kCATransitionPush;
    trans.duration=0.2f;
    
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        trans.subtype=kCATransitionFromTop;
       [self.Toolbar.layer addAnimation:trans forKey:@"transition"];
        [self.Toolbar setHidden:NO];
    }else if (!self.navigationController.navigationBarHidden){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        trans.subtype=kCATransitionFromBottom;
        [self.Toolbar.layer addAnimation:trans forKey:@"transition"];
        [self.Toolbar setHidden:YES];
    }
}


@end


