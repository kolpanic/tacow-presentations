tacow Meeting #4 - Automating Software Updates in Cocoa Applications
Karl Moskowski <karl@jetmailer.com>

This UpdateCheckTest application is a demonstration of how to implement software update in a Cocoa app, using both a roll-your-own approach, and Sparkle. It's an Xcode 2.4 project, and requires Tiger.

The Useful URLs group in the Xcode project (or the webloc files in the directory) point to Sparkle's home page, Sparkle's PDF documentation, and SparklePlus' home page.

Before you begin, copy the tacow/ directory in the project's directory to /Library/WebServer/Documents/, and start Personal Web Sharing. Verify that everything's in the right place by opening <http://127.0.0.1/tacow/myAppCurrentVersion.html> in a web browser.

Note that this project uses Apple Generic Versioning. This simplifies version number comparison in both methods.

There are two Check for Updates... menu items under the application menu, one for each method. This seems to be the standard location for this funtion.

Roll Your Own:
The method checkForUpdate: in UpdateCheckController is the target action of the menu item. It's very rudimentary: there's not much error handling, it's not localized, it doesn't support auto-checking at launch, the URLs and paths are hard-coded, etc.

Sparkle:
First, note that the framework is actually built into the application; it's not deployed to /Library/Frameworks/. It was added by dragging the built framework directory to the Frameworks group in the Xcode project, and then checking the Copy files option in the Add Files sheet (*not* by using the Add Frameworks... menu). Note also the added Copy Files build phase in the target. It contains Sparkle.framework/.

The method checkForUpdates: in SUUpdater (within the Sparkle framework) is the target action of the menu item. Also, in the Prefs panel (in MainMenu.nib), there's a check-box bound to values.SUCheckAtStartup [Shared User Defaults] via Cocoa bindings. The first time the app launches, Sparkle presents a dialog asking if auto-checking should be enabled; this check-box lets the user change the setting later. Finally, the app's Info.plist file contains the added key SUFeedURL which points to the appcast.