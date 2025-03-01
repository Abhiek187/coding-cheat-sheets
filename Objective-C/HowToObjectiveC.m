//
//  HowToObjectiveC.m
//  HowToObjectiveC
//
//  Created by Abhishek Chaudhuri on 2/27/25.
//

#import <Foundation/Foundation.h>
#import "HowToObjectiveC.h"

@implementation SampleClass

static NSInteger _id;

+ (void)setId:(NSUInteger)id {
    _id = id;
}

+ (NSUInteger)id {
    return _id;
}

- (nonnull instancetype)initWithSubject:(NSString *)subject size:(NSInteger)size state:(State)state {
    if (self = [super init]) {
        _subject = subject;
        _size = size;
        _state = state;
        [SampleClass setId:(_id + 1)];
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"You dropped out of %@", _subject);
}

- (void)status {
    NSString *stateStr = _state == Rowdy ? @"rowdy" : @"calm";
    NSLog(@"This %@ class has %ld students and is %@.", _subject, _size, stateStr);
}

@end

@implementation MathClass

- (nonnull instancetype)initWithSize:(NSInteger)size {
    if (self = [super initWithSubject:@"math" size:size state:Rowdy]) {
        NSLog(@"%@", self);
    }
    
    return self;
}

// toString() from NSObject
- (NSString *)description {
    return [NSString stringWithFormat:@"Welcome to math class! You are student %lu.", [SampleClass id]];
}

@end

@implementation EnglishClass

- (nonnull instancetype)initWithSize:(NSInteger)size {
    if (self = [super initWithSubject:@"english" size:size state:Calm]) {
        NSLog(@"%@", self);
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Welcome to english class! You are student %lu.", [SampleClass id]];
}

@end

// Use regular C functions outside of classes
NSInteger getObjcVersion(void) {
#if __clang_major__ >= 16
    return 16;
#elif __clang_major__ >= 15
    return 15;
#elif __clang_major__ >= 14
    return 14;
#elif __clang_major__ >= 13
    return 13;
#else
    return 12;
#endif
}

NSString* boolToString(BOOL b) {
    return b ? @"YES" : @"NO";
}

/// Recursively sums from 1 to `num`.
///
/// - Throws: `NSInvalidArgumentException` if `num` is non-positive
///
/// - Parameter num: the upper limit of the sum (inclusive)
///
/// - Returns: the sum from 1 to `num`
NSInteger sumTo(NSInteger num) {
    if (num <= 0) {
        // Or [NSException raise:@"Exception" format:@"num must be positive"];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"num must be positive"
                                     userInfo:nil];
    } else if (num == 1) {
        return 1;
    } else {
        return sumTo(num - 1) + num;
    }
}

// main gets executed first
int main(int argc, const char * argv[]) {
    // Enable ARC (automatic reference counting) in C code
    @autoreleasepool {
        NSLog(@"Hello Objective-C!");
        NSLog(@"By the way, you're running Objective-C (Clang) version %ld", getObjcVersion());
        
        // Variables
        NSInteger myInt = -29; // NSInteger automatically handles 32-bit & 64-bit ints
        double myDouble = 6.84551e1;
        const char myChar = '\\';
        BOOL myBool = YES; // YES = true, NO = false
        NSString *myString = @"This is a string.";
        State state = Calm;
        Student student;
        student.name = @"Joe Schmo";
        
        // Input/Output
        printf("What's your name? ");
        char name[MAX_NAME_LENGTH]; // will truncate after 24 chars (to make room for \0)

        if (!fgets(name, sizeof(name), stdin)) {
            fprintf(stderr, "Error: file %s, line %d\n", __FILE__, __LINE__);
            fprintf(stderr, "Oops, something went wrong when inputting your name.\n");
            return -1;
        }

        // Remove the newline at the end of the input
        if (name[strlen(name) - 1] == '\n')
        {
            name[strlen(name) - 1] = '\0';
        }

        printf("Hi %s!\n", name); // use %s for C functions, %@ for Objective-C methods
        NSLog(@""); // prints just a newline
        
        // Math Operations
        NSLog(@"Adding two numbers: %ld + %f = %lf", myInt, myDouble, myInt + myDouble);
        NSLog(@"%ld + %c = %ld\n", myInt, myChar, myInt + myChar);
        NSLog(@"%ld + %@ = %ld\n", myInt, boolToString(myBool), myInt + myBool);
        NSLog(@"%ld + %d = %ld\n", myInt, state, myInt + state);
        NSLog(@"%ld ^ %lf = %lf\n", myInt, myDouble, pow(myInt, myDouble));
        NSLog(@"Dividing two ints: %ld / 2 = %ld", myInt, myInt / 2);
        NSLog(@"Weird math: 0/0.0 = %f, sqrt(-1) = %f", 0/0.0, sqrt(-1));
        NSLog(@"Rounding: %f → %@", myDouble, [NSString stringWithFormat:@"%ld", lroundf(myDouble)]);
        NSLog(@"");
        
        // Logical Operators
        // &&, ||, and ! behave like normal
        
        // Conditional Operators & Loops
        // if, else if, else, switch, case, do, while, and for behave like normal
        
        // Pointers
        double *myDoublePtr = &myDouble;
        NSLog(@"myDoublePtr points to %lf in address %p\n", *myDoublePtr, (void *)myDoublePtr);
        *myDoublePtr = PI;
        NSLog(@"Now myDouble is %lf\n", myDouble);
        NSLog(@"Be careful what you reference, else you'll end up with garbage: %lf\n", myDoublePtr[2]);
        NSLog(@"");
        
        // Nullables
        BOOL objcNull = nil;
        void *cNull = NULL;

        if (objcNull) { // != nil
            NSLog(@"objcNull has a value: %d", objcNull);
        } else {
            NSLog(@"objcNull is nil");
        }
        if (cNull) {
            NSLog(@"cNull has a value: %p", cNull);
        } else {
            NSLog(@"cNull is NULL");
        }
        NSLog(@"");
        
        // Functions & Methods
        NSLog(@"sum(1, 10) = %ld", sumTo(10));
        NSLog(@"%@ is %lu characters long", myString, [myString length]);
        NSLog(@"substring(1, 8) = %@", [myString substringWithRange:NSMakeRange(1, 8)]);
        NSLog(@"indexOf('s') = %lu", [myString rangeOfString:@"s"].location);
        NSLog(@"");
        
        // Arrays
        if (argc <= 1) {
            // argv[0] is the executable
            NSLog(@"Hmm, you didn't enter any command line arguments.");
        } else {
            NSLog(@"You passed in the following arguments:");
            for (NSInteger i = 0; i < argc; i++) {
                NSLog(@"argv[%ld] = %s", i, argv[i]);
            }
        }
        
        NSArray <NSString *> *fixedArr = @[@"a", @"e", @"i", @"o", @"u"];
        NSMutableArray *dynamicArr = [NSMutableArray array]; // empty array
        [dynamicArr addObjectsFromArray:@[@NO, @NO, @YES]];
        [dynamicArr addObject:@NO]; // add at the end
        [dynamicArr removeObjectAtIndex:1];
        [dynamicArr insertObject:@YES atIndex:0];

        // Block = lambda
        [fixedArr enumerateObjectsUsingBlock:^(NSString *str, NSUInteger index, BOOL *stop) {
            NSLog(@"fixedArr[%lu] = %@", index, str);
        }];
        NSLog(@"size = %lu", [fixedArr count]);
        
        NSLog(@"dynamicArr: %@", dynamicArr);
        // id = unknown type
        for (id item in dynamicArr) {
            NSLog(@"%@", item);
        }
        NSLog(@"size = %lu", [dynamicArr count]);
        
        [dynamicArr removeAllObjects];
        NSLog(@"");
        
        // Dictionaries
        // (NSInteger values aren't supported)
        NSMutableDictionary <NSString *, NSNumber *> *myDict = [NSMutableDictionary dictionaryWithDictionary:@{
            @"month": [NSNumber numberWithInt:4],
            @"day": [NSNumber numberWithInt:18]
        }];
        [myDict addEntriesFromDictionary:@{
            @"year": [NSNumber numberWithInt:1994]
        }];
        for (id key in myDict) {
            NSLog(@"myDict[%@] = %@", key, [myDict objectForKey:key]);
        }

        NSNumber *ssn;
        if ((ssn = [myDict objectForKey:@"ssn"])) {
            NSLog(@"You got hacked! %@", ssn);
        } else {
            NSLog(@"There's no key called ssn.");
        }
        NSLog(@"");
        
        // Exception Handling
        @try {
            sumTo(-1);
        }
        @catch (NSException *err) {
            NSLog(@"Error: %@", [err description]);
        }
        @finally {
            NSLog(@"");
        }
        
        // Classes
        // SampleClass is abstract
        // SampleClass *class0 = [SampleClass new]; // or [[SampleClass alloc] init];
        MathClass *class1 = [[MathClass alloc] initWithSize:50];
        EnglishClass *class2 = [[EnglishClass alloc] initWithSize:30];
        [class1 status];
        [class2 status];
    }
    
    return 0;
}
