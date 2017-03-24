# LineEscapeEx
Xcode Source Editor Extentsion (Xcode 8+)
duplicate lines as comment

## Example
![Sample](https://cloud.githubusercontent.com/assets/19257572/24300316/67fa8368-10ef-11e7-92f8-eef8ed7be554.gif)

# Install
1. On OS X 10.11 El Capitan, run the following command and restart your Mac:

sudo /usr/libexec/xpccachectl

1. Open .xcodeproj
1. Enable target signing for both the Application and the Source Code Extension using your own developer ID
1. Product > Archive
1. Right click archive > Show in Finder
1. Right click archive > Show Package Contents
1. Open Products, Applications
1. Drag ``LineEscapeEx.app`` to your Applications folder
1. Run ``LineEscapeEx.app`` and exit again.
1. Go to System Preferences (not Xcode) -> Extensions -> Xcode Source Editor and enable the extension
1. The menu-item should now be available from Xcode's Editor menu.

# Licence
The MIT License. See the LICENSE file for more infomation.
