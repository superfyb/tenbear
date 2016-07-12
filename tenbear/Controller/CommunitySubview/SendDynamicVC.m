//
//  SendDynamicVC.m
//  tenbear
//
//  Created by fengyibo on 16/3/22.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "SendDynamicVC.h"
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"
@interface SendDynamicVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *textNumLabel;
@property (nonatomic,strong) NSURL *sourceURL;
@property (nonatomic,strong) UILabel *fileLenLabel;
@property (strong, nonatomic) IBOutlet UIImageView *videoCutImage;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *playerItem;

- (IBAction)videoButtonClick:(id)sender;
- (IBAction)playVideo:(id)sender;

@end

@implementation SendDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:nil];
    
    //点击空白处收起键盘
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearKeyboard)]];
    
    self.videoCutImage.hidden = YES;
    self.playButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)disappearKeyboard{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"写下你现在最想说的话"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"写下你现在最想说的话";
        textView.textColor = [UIColor grayColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length > 140)
    {
        textView.text = [textView.text substringToIndex:140];
    }
    self.textNumLabel.text = [NSString stringWithFormat:@"%lu",140-textView.text.length];
}

- (IBAction)videoButtonClick:(id)sender {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    ipc.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.videoMaximumDuration = 60.0f;//30秒
    ipc.delegate = self;//设置委托
}

- (IBAction)playVideo:(id)sender {
    
    AVPlayerItem *item=[AVPlayerItem playerItemWithURL:self.sourceURL];
    
    self.player=[AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    
    layer.videoGravity=AVLayerVideoGravityResizeAspect;
    
    layer.frame= CGRectMake(0, SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_WIDTH/2);
    
    layer.backgroundColor=[[UIColor blackColor]CGColor];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [vc.view.layer addSublayer:layer];
    vc.hidesBottomBarWhenPushed = YES;
//    [self.view.layer addSublayer:layer];
    [self.navigationController pushViewController:vc animated:YES];
    vc.view.backgroundColor = [UIColor whiteColor];
//    layer.transform=CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
    
    
    [self.player play];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    self.fileLenLabel.text = [NSString stringWithFormat:@"%f s", [self getVideoLength:self.sourceURL]];//这个url为什么可以呢，因为这里必须这样
    self.fileLenLabel.text = [NSString stringWithFormat:@"%f kb", [self getFileSize:[[self.sourceURL absoluteString] substringFromIndex:16]]];//文件并没有存储在sourceURL所指的地方，因为这里自己加上了所以要将这段字符串去掉，这个Label是测试时工程中用到的显示所拍摄文件大小的标签
    NSLog([[self.sourceURL absoluteString] substringFromIndex:16]);
    [self dismissViewControllerAnimated:YES completion:nil];

    //获取视频第一帧
    [self movieToImage];
    self.videoCutImage.hidden = NO;
    self.playButton.hidden = NO;
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024/1024;
    }
    NSLog(@"filesize%lf",filesize);
    return filesize;
}
//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

#pragma mark - 获取视频第一帧
- (void)movieImage:(UIImage *)image
{
    [self.videoCutImage setImage:image];
}

- (void)movieToImage
{
    NSURL *url = self.sourceURL;
    
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
    
    AVAssetImageGeneratorCompletionHandler handler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result != AVAssetImageGeneratorSucceeded) {       }//没成功
        
        UIImage *thumbImg = [UIImage imageWithCGImage:im];
        
        [self performSelectorOnMainThread:@selector(movieImage:) withObject:thumbImg waitUntilDone:YES];
        
    };
    
    generator.maximumSize = self.view.frame.size;
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
}
@end
