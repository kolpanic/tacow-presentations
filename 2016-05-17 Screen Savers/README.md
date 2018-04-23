Keynote deck and Xcode demo project for [my talk at tacow on 2016-May-17.](http://www.meetup.com/tacow-org/events/229632982/)

## Summary
* Draw in bounds, not frame, because multiple displays with an offset arrangement can cause drawing to be shifted.
* Use AVPlayerLayer to play videos, because AVPlayerView inhibits system sleep.
* ScreenSaverDefaults, a subclass of NSUserDefaults, writes to `~/Library/Preferences/ByHost/`. Use `defaults -currentHost` in Terminal to access preferences.
* No Swift—Xcode 7 doesn't offer a Swift option when creating new screen saver projects. System Preferences loads bundles' dylibs just once, so different Swift versions cause problems. There's a [recent radar for this](https://openradar.appspot.com/25569037).
* Use a Run pre-action script for debugging—copies ScreenSaverEngine.app to `/tmp/` and symlinks built .saver to `~/Library/Screen Savers/`.
* Use an Archive post-action script to create installer package. There's an excellent [SO answer on OS X installers](http://stackoverflow.com/questions/11487596/making-os-x-installer-packages-like-a-pro-xcode-developer-id-ready-pkg#11487658) with details and links.

## Other Screen Savers
* [Whiskey Fire](https://github.com/soffes/whisky-fire)—Nick Offerman by the fireplace
* [Aerial](https://github.com/JohnCoates/Aerial)—Apple TV screensaver movies on OS X
* [More](https://github.com/aharris88/awesome-osx-screensavers)—a curated list
* [Achiever](https://github.com/kolpanic/Achiever)—my Quartz composition
* [Flixel Cinemagraphs](https://flixel.com/products/mac/screensaver/)—the inspiration for this talk
