# New Hope International iOS App README#

This README documents steps needed to get the app running

### Xcode ###

To develop iOS apps, you will first need a system running Mac OS. While any Mac released after 2009 will do the job, 8 GB of ram would be the recommended minimum memory. From experience, just having Xcode and a iOS emulator running at the same time uses about 4 GB of RAM on a 8 GB system. On a 4 GB system, Mac OS throttles it to only use about 3 GB. The more RAM the better. Having the latest Mac OS is not a requirement. 

Download Xcode from the App Store and update it as necessary. 

### How do I get set up? ###

We will be following a Feature Branch workflow. What that means is that, for every feature, the developer will have their own branch to work with. Once they are done with that feature, they issue a pull request for their changes to be merged into the master repository. All releases will be cut from the master repository. 

Evidently, some changes are just so small and this project is not on a corporate level, so I can tolerate people wanting to commit directly to the master branch. Only create feature branches when you're working on something big like adding Facebook integration or porting Objective C to swift. 

To fix small changes, do the following:

1. Open up Xcode.
2. Select "check out an existing project".
3. Enter the following for repository location: https://your-username@bitbucket.org/apps4christ/nhic-ios-app.git.
4. Choose the master/feature branch when prompted.
5. Navigate to, or create the directory in which you want to clone the project, and press the Check Out button.

To put in actual features, talk with Mark about creating a feature branch, and he will give you a new repository location that you will replace step #4 with. 

You will then pull the latest development version of the NHIC iOS app. Hit the run button and verify that you are able to successfully emulate the app. You will not be able to test on any physical devices unless you register as a developer with Apple. It is a yearly registration costing $100. The iOS emulator is pretty accurate and lets you simulate most scenarios, so don't worry about not being able to test on an actual physical device. If you would like to, talk with Mark Merin and he can load your latest changes on a test device. 

### Who do I talk to? ###
Please contact Mark Merin for any questions