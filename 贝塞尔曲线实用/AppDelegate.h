//
//  AppDelegate.h
//  贝塞尔曲线实用
//
//  Created by caoshuaikun on 2017/2/10.
//  Copyright © 2017年 wuxiwenyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

