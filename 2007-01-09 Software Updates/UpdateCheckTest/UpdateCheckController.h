//
//  UpdateCheckController.h
//  UpdateCheckTest
//
//  Created by Karl Moskowski on 08/01/07.
//  Copyright 2007 tacow. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UpdateCheckController : NSObject {
	IBOutlet NSWindow *prefs;
}

-(IBAction) checkForUpdate:(id) sender;
-(IBAction) showPrefs:(id) sender;

@end