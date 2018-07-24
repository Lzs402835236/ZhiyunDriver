//
//  MainPageViewController.h
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "BaseViewController.h"
#import "BaiduTraceSDK/BaiduTraceSDK.h"
#define ServiceID 135436
#define MCODE
@interface MainPageViewController : BaseViewController<BTKTraceDelegate, BTKFenceDelegate, BTKTrackDelegate, BTKEntityDelegate, BTKAnalysisDelegate>
@property (nonatomic,copy) NSString * orderDetailsNum;
@property (nonatomic,copy) NSString * transStatus;
@end
