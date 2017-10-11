//
//  KeyBoardMacros.h
//  AppFactory
//
//  Created by alan on 2017/10/3.
//  Copyright © 2017年 alan. All rights reserved.
//

#define KEYBOARD_WILL_SHOW(target ,action) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:UIKeyboardWillShowNotification object:nil];

#define KEYBOARD_WILL_HIDE(target ,action) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:UIKeyboardWillHideNotification object:nil];

#define KEYBOARD_DID_SHOW(target ,action) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:UIKeyboardDidShowNotification object:nil];

#define KEYBOARD_DID_HIDE(target ,action) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:UIKeyboardDidHideNotification object:nil];

#define KEYBOARD_REMOVE_OBSERVER(target) {[[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillHideNotification object:nil];[[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillShowNotification object:nil];[[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardDidShowNotification object:nil];[[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardDidHideNotification object:nil];}

#define KEYBOARD_ANIMATING(userInfo,aniBlock){CGRect keyboardEndFrame;UIViewAnimationCurve animationCurve;NSTimeInterval animationDuration;[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];[UIView beginAnimations:nil context:nil];[UIView setAnimationBeginsFromCurrentState:YES];[UIView setAnimationDuration:animationDuration];[UIView setAnimationCurve:animationCurve];if(aniBlock)aniBlock(keyboardEndFrame);[UIView commitAnimations];}
