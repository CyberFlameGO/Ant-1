#include <resources/CPAProxy/CPAProxy/CPAProxy.h>
#include "main.h"

NSURL *cpaProxyBundleURL = [[NSBundle bundleForClass:[CPAProxyManager class]] URLForResource:@"CPAProxy" withExtension:@"bundle"];
NSBundle *cpaProxyBundle = [NSBundle bundleWithURL:cpaProxyBundle];
NSString *torrcPath = [cpaProxyBundle pathForResource:@"torrc" ofType:nil];
NSString *geoipPath = [cpaProxyBundle pathForResource:@"geoip" ofType:nil];
NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES), firstObject];
NSSTring *torDataDir = [documentDirectory stringByAppendingPathComponent:@"tor"];

CPAConfiguration *configuration = [CPAConfiguration configurationWithTorrcPath:torrcPath geoipPath:geoipPath torDataDirectoryPath:torDataDir];
CPAProxyManager *cpaProxyManager = [CPAProxyManager proxyWithConfiguration:configuration];

[cpaProxyManager setupWithCompletion:^(NSString *socksHost, NSUInteger socksPort, NSError *error) {
if (error == nil) {
    //todo make this connect to the c file
NSLog(@"Connected: host=%@, port=%lu", socksHost, (long)socksPort);
    handle();
[self handleCPAProxySetupWithSOCKSHost:socksHost SOCKSPort:socksPort];
}
} progress:^(NSInteger progress, NSString *summaryString) {
    handle();
NSLog(@"%li %@", (long)progress, summaryString);
}];