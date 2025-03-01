//
//  HowToObjectiveC.h
//  HowToObjectiveC
//
//  Created by Abhishek Chaudhuri on 2/27/25.
//

#import <Foundation/Foundation.h>

// Mark all properties as non-nullable by default
NS_ASSUME_NONNULL_BEGIN

#define MAX_NAME_LENGTH 25
#define PI 3.14159265358979323846

typedef enum _State {
    Calm,
    Rowdy
} State;

typedef struct _Student {
    NSString *name;
    int grade;
} Student;

// Interface
@protocol Class

- (void)status;

@end

@interface SampleClass : NSObject <Class>

/*
 Access attributes:
 readwrite = getter & setter (default)
 readonly = only getter
 class = static
 getter = custom getter method
 setter = custom setter method
 
 Atomicity attributes:
 atomic = thread-safe, slower reads (default)
 nonatomic = not thread-safe, but faster reads
 
 Storage attributes:
 strong = keep reference until deallocation (default)
 weak = set to nil (null) if object is deallocated (retain count = 0)
 copy = create a copy of the object when assigned
 assign = assign directly to the instance variable
 
 Null attributes:
 nonnull = cannot be nil (default with macro above)
 nullable = can be nil
 */
@property (copy) NSString *subject;
@property NSInteger size;
@property State state;
@property (class) NSUInteger id;

- (instancetype)initWithSubject:(NSString *)subject size:(NSInteger)size state:(State)state;

@end

@interface MathClass : SampleClass

- (instancetype)initWithSize:(NSInteger)size;

@end

@interface EnglishClass : SampleClass

- (instancetype)initWithSize:(NSInteger)size;

@end

NS_ASSUME_NONNULL_END
