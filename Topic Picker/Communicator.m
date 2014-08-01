//
//  Communicator.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "Communicator.h"
@interface Communicator ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation Communicator
- (void)getInitialPayload
{
    NSLog(@"going in");
    NSURL *yay = [NSURL URLWithString:@"http://yoren01.eng.live.flipboard.com:5000/new"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:yay];
    [request setHTTPMethod:@"POST"];
//    NSURLResponse * response = nil;
//    NSError * error = nil;
//    NSData * data = [NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response
//                                                      error:&error];
////
//    if (error == nil)
//    {
//        NSLog(@"response was :%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        self.responseData = [[NSMutableData alloc] initWithData:data];
//        [self connectionDidFinishLoading:nil];
//    } else {
//        NSLog(@"fuck me error: %@", error);
//    }
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [theConnection start];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (connectionError) {
//            NSLog(@"damnit: %@", connectionError);
//        } else {
//            NSError *parsingError = nil;
    
//        }
//    }];
}

- (void)getNextPayloadForUser:(NSString *)user WithPreferences:(NSData *)data
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"104.131.218.141:5000/recommended/%@", user]];
//    NSString *post = [NSString stringWithFormat:@"topic_results=%@",pref]; // change to handle shit
    NSData *postData = data;
//    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [theConnection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *parsingError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&parsingError];
    if (parsingError) {
        NSLog(@"response was :%@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
        NSLog(@"damnit shit can't parse: %@", parsingError);
    } else {
        NSLog(@"yay: %@", parsedObject);
        [self.delegate recievedPayload:parsedObject];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
@end
