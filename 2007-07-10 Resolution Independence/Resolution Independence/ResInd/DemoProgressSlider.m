#import "DemoProgressSlider.h"
#import "DemoProgressSliderCell.h"

@implementation DemoProgressSlider

+ (Class)cellClass {
	return [DemoProgressSliderCell class];
}

- initWithCoder: (NSCoder *)origCoder {
	if(![origCoder isKindOfClass: [NSKeyedUnarchiver class]])
		self = [super initWithCoder: origCoder]; 
	else {
		NSKeyedUnarchiver *coder = (id)origCoder;
		NSString *oldClassName = [[[self superclass] cellClass] className];
		Class oldClass = [coder classForClassName: oldClassName];
		if(!oldClass)
			oldClass = [[super superclass] cellClass];
		[coder setClass: [[self class] cellClass] forClassName: oldClassName];
		self = [super initWithCoder: coder];
		[coder setClass: oldClass forClassName: oldClassName];
	}
	return self;
}

@end