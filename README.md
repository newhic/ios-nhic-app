# New Hope International iOS App README#

This README documents steps needed to get the app running

### Xcode ###

To develop iOS apps, you will first need a system running Mac OS. While any Mac released after 2009 will do the job, 8 GB of ram would be the recommended minimum memory. From experience, just having Xcode and a iOS emulator running at the same time uses about 4 GB of RAM on a 8 GB system. On a 4 GB system, Mac OS throttles it to only use about 3 GB. The more RAM the better. Having the latest Mac OS is not a requirement. 

Download Xcode from the App Store and update it as necessary. 

### How do I get set up? ###

We will be following a Feature Branch workflow. What that means is that, for every feature, the developer will have their own branch to work with. Once they are done with that feature, they issue a pull request for their changes to be merged into the master repository. All releases will be cut from the master repository. 

To create your own feature branch do the following:

1. Click on the branches tab, on the left hand side of the bitbucket website.
2. Click "Create Branch" on the top right hand side.
3. Ensure that you are branching from master. Give the feature branch an appropriate title. It is suggested that you include the Issue number this feature branch will be addressing.
4. This feature branch is intended only for that particular fix or feature. Once the feature has been completed, a pull request should be done to merge it back into master. The feature branch should then be marked close.

Once you have completed making your own feature branch, you are ready to check out your project!

1. Open up Xcode.
2. Select "check out an existing project".
3. Enter the following for repository location: https://your-username@bitbucket.org/apps4christ/nhic-ios-app.git.
4. Choose your feature branch when prompted.
5. Navigate to, or create the directory in which you want to clone the project, and press the Check Out button.

You will then pull the latest development version of the NHIC iOS app. Hit the run button and verify that you are able to successfully emulate the app. You will not be able to test on any physical devices unless you register as a developer with Apple. It is a yearly registration costing $100. The iOS emulator is pretty accurate and lets you simulate most scenarios, so don't worry about not being able to test on an actual physical device. If you would like to, talk with Mark Merin and he can load your latest changes on a test device. 

###Contribution guidelines###
Please only commit changes through Xcode. 

To commit changes, click Source Control on the toolbar, commit. Double check you are committing the correct files, write an informative commit message addressing:

1. Issue number you are fixing

Fix for Issue #100 - This an example of a bug

2. How did you fix it

I fixed this by doing the following....

No one else should be pulling or putting changes in your feature branch. To ensure compatibility between your feature branch and master, please pull changes from master into your feature branch.

### Who do I talk to? ###
Please contact Mark Merin for any questions