#include <resources/CPAProxy/CPAProxy/CPAProxy.h>

NSURL *cpaProxyBundleURL = [[NSBundle bundleForClass:[CPAProxyManager class]] URLForResource:@"CPAProxy" withExtension:@"bundle"];
NSBundle *cpaProxyBundle = [NSBundle bundleWithURL:cpaProxyBundle];