
#import "ElDuderinoView.h"

@import AVFoundation;

@interface ElDuderinoView ()

@property (weak, nonatomic) IBOutlet NSPanel *configureSheet;
@property (assign) BOOL intoTheWholeBrevityThing;
@property (readonly) NSString *versionString;

@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (assign) BOOL isObservingPlayer;

@property (strong, nonatomic) CATextLayer *titleLayer;

@end

@implementation ElDuderinoView

@synthesize versionString = _versionString;

static NSString *const intoTheWholeBrevityThingKey = @"IntoTheWholeBrevityThing";

#pragma mark - Setup

+ (void)initialize {
    if (self == [ElDuderinoView class]) {
        [[self defaults] registerDefaults:@{intoTheWholeBrevityThingKey : @(YES)}];
    }
    [super initialize];
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self reloadDefaults];
        
        self.wantsLayer = YES;
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:[AVPlayer playerWithURL:[[self screensaverBundle] URLForResource:@"Dude" withExtension:@"mp4"]]];
        self.playerLayer.frame = self.bounds;
        [self.layer addSublayer:self.playerLayer];
        
        self.titleLayer = [CATextLayer layer];
        
        self.titleLayer.frame = CGRectMake(NSMinX(self.bounds), NSMinY(self.bounds) + 100.0,
                                           NSWidth(self.bounds) - 100.0, 75.0);
        self.titleLayer.fontSize = 48.0;
        NSString *fontName = @"Avenir Next Condensed Heavy";
        if (self.isPreview) {
            self.titleLayer.frame = CGRectMake(NSMinX(self.bounds), NSMinY(self.bounds),
                                               NSWidth(self.bounds) - 10.0, 25.0);
            self.titleLayer.fontSize = 10.0;
            fontName = @"Avenir Next Condensed Bold";
        }
        
        self.titleLayer.font = (__bridge CFTypeRef _Nullable)[NSFont fontWithName:fontName size:self.titleLayer.fontSize];
        self.titleLayer.alignmentMode = kCAAlignmentRight;
        self.titleLayer.foregroundColor = [NSColor whiteColor].CGColor;
        self.titleLayer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.titleLayer.shadowRadius = 10.0;
        self.titleLayer.shadowColor = [NSColor blackColor].CGColor;
        [self.layer addSublayer:self.titleLayer];
        
        [self updateTitle];
    }
    return self;
}

- (void)updateTitle {
    self.titleLayer.string = self.intoTheWholeBrevityThing ? @"The Dude" : @"El Duderino";
}

- (void)startAnimation {
    [super startAnimation];
    [self.playerLayer.player play];
}

- (void)stopAnimation {
    [super stopAnimation];
    [self.playerLayer.player pause];
}

- (void)startObservingPlayer {
    if (!self.isObservingPlayer) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerLayer.player.currentItem];
    }
    self.isObservingPlayer = YES;
}

- (void)stopObservingPlayer {
    if (self.isObservingPlayer) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    self.isObservingPlayer = NO;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.playerLayer.player seekToTime:kCMTimeZero toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.playerLayer.player play];
}

#pragma mark - Utility

+ (NSBundle *)screensaverBundle {
    return [NSBundle bundleForClass:self];
}

- (NSBundle *)screensaverBundle {
    return [self.class screensaverBundle];
}

#pragma mark - Defaults

+ (ScreenSaverDefaults *)defaults {
    return [ScreenSaverDefaults defaultsForModuleWithName:[[self screensaverBundle] bundleIdentifier]];
}

- (ScreenSaverDefaults *)defaults {
    return [self.class defaults];
}

- (void)reloadDefaults {
    self.intoTheWholeBrevityThing = [[self defaults] boolForKey:intoTheWholeBrevityThingKey];
}

#pragma mark - Configure Sheet

- (BOOL)hasConfigureSheet {
    return YES;
}

- (NSWindow *)configureSheet {
    if (!_configureSheet) {
        [[self screensaverBundle] loadNibNamed:@"ConfigureSheet" owner:self topLevelObjects:nil];
    }
    return _configureSheet;
}

- (NSString *)versionString {
    if (_versionString == nil) {
        NSInteger bundleVersion =  [[[[self screensaverBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey] integerValue];
        NSString *shortVersionString =  [[[self screensaverBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _versionString = [NSString stringWithFormat:@"%@ (%li)", shortVersionString, (long)bundleVersion];
    }
    return _versionString;
}

- (IBAction)configureOK:(id)sender {
    [[NSApplication sharedApplication] endSheet:self.configureSheet returnCode:NSModalResponseOK];
    [[self defaults] setBool:self.intoTheWholeBrevityThing forKey:intoTheWholeBrevityThingKey];
    [[self defaults] synchronize];
    [self updateTitle];
}

- (IBAction)configureCancel:(id)sender {
    [[NSApplication sharedApplication] endSheet:self.configureSheet returnCode:NSModalResponseCancel];
    [self reloadDefaults];
}

@end
