//
//  Communicator.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CommunicatorDelegate
- (void)recievedPayload:(NSDictionary *)payload;
@end
@interface Communicator : NSObject
- (void)getInitialPayload;
- (void)getNextPayloadForUser:(NSString *)user WithPreferences:(NSData *)data;
@property (nonatomic, weak) id<CommunicatorDelegate> delegate;
@end
