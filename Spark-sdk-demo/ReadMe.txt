
This tutorial describes how to run the Objective C version of the quick start app.
The app generates an access token, authenticating the app user and giving full access to the Spark APIs for a single session.
It can also be used to generate a guest token and to refresh an access token. 
For more information about authentication see our Authentication API.

To use and run this sample app, you must register an app on the Spark developer's portal.

1. Download the sample apps from https://github.com/spark3dp/authentication-samples and copy the Objective C folder. 

2. Locate the AppDelegate.m file in the Objective C folder and change the following:
	 under - (BOOL)application: didFinishLaunchingWithOptions:

	Set appKey to the App Key provided when you registered your app on the Spark developer's portal.
	Set appSecret to the App Secret provided when you registered your app on the Spark developer's portal.
	
	// In real world Apps, these values need to be secured and preferably not hardcoded.
	NSString *appKey = "INSERT_APP_KEY_HERE";
	NSString * appSecret = "INSERT_SECRET_HERE";

4. Run the project .
