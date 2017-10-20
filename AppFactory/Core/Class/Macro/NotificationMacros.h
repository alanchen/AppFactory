//
//  NotificationMacros.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#define NOTIFICATION_ADD(target,action,notiname) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:notiname object:nil]
#define NOTIFICATION_REMOVE_SELF_OBSERVER [[NSNotificationCenter defaultCenter] removeObserver:self]

#define NOTIFICATION_POST(notiname) [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil]

#define NOTIFICATION_POSTOBJ(notiname,obj) [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:obj]

#define NOTIFICATION_REMOVE_OBSERVER(ob) [[NSNotificationCenter defaultCenter] removeObserver:ob]

