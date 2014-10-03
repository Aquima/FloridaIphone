//
//  NoteView.h
//  Florida
//
//  Created by Raul Quispe on 9/29/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoteViewDelegate
-(void)selectNoteAccept:(NSString*)newNote;
-(void)selectNoteCancel;
@end
@interface NoteView : UIView<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,weak)id<NoteViewDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
@property(nonatomic,strong) NSString*message;
+(NoteView *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
-(void)setText:(NSString*)text;
@end
