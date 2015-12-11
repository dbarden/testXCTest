#import "DBATestCase.h"
#import <objc/runtime.h>

@implementation DBATestCase

+ (NSArray<NSInvocation *> *)testInvocations
{
    /** Method 1 */
    IMP implementation_1 = imp_implementationWithBlock(^{ });

    const char *types = [[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)] UTF8String];
    class_addMethod(self, NSSelectorFromString(@"sample1"), implementation_1, types);


    SEL selector = @selector(sample1);
    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;

    /** Method 2*/

    IMP implementation_2 = imp_implementationWithBlock(^{ });

    class_addMethod(self, NSSelectorFromString(@"sample2"), implementation_2, types);

    SEL selector2 = @selector(sample2);
    NSMethodSignature *signature2 = [self instanceMethodSignatureForSelector:selector2];
    NSInvocation *invocation2 = [NSInvocation invocationWithMethodSignature:signature2];
    invocation2.selector = selector2;

    /** Method 3*/

    IMP implementation_3 = imp_implementationWithBlock(^{
        XCTFail(@"dasd");
    });

    class_addMethod(self, NSSelectorFromString(@"sample3"), implementation_3, types);

    SEL selector3 = @selector(sample3);
    NSMethodSignature *signature3 = [self instanceMethodSignatureForSelector:selector3];
    NSInvocation *invocation3 = [NSInvocation invocationWithMethodSignature:signature3];
    invocation3.selector = selector3;

    return @[invocation, invocation2, invocation3];
}
@end
