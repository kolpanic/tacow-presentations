#import "DemoProgressSliderCell.h"

@implementation DemoProgressSliderCell

- (void)drawBarInside:(NSRect)cellFrame flipped:(BOOL)flipped {
	NSRect newRect;
	newRect.origin.x = cellFrame.origin.x + 10.0;
	newRect.size.width = cellFrame.size.width - 21.0;
	newRect.origin.y = cellFrame.origin.y + cellFrame.size.height / 4.0;
	newRect.size.height = cellFrame.size.height / 2.0;
	
	NSBezierPath *bar = [NSBezierPath bezierPathWithRect:newRect];
	
	[bar setLineWidth:1.0];
	[[NSColor blackColor] set];
	[bar stroke];
}

- (void)drawKnob:(NSRect)rect {
	float x = rect.origin.x;
	float y = rect.origin.y;
	float w = rect.size.width;
	float h = rect.size.height;

	NSBezierPath *knob = [NSBezierPath bezierPath];
	[knob moveToPoint:NSMakePoint(x + w / 4.0, y + h / 2.0)];
	[knob lineToPoint:NSMakePoint(x + w / 2.0, y + 3.0 * h / 4.0)];
	[knob lineToPoint:NSMakePoint(x + 3.0 * w / 4.0, y + h / 2.0)];
	[knob lineToPoint:NSMakePoint(x + w / 2.0, y + h / 4.0)];
	[knob closePath];
	
	[[NSColor blackColor] set];
	[knob fill];
}

- (BOOL)_usesCustomTrackImage {
	return YES;
}

@end