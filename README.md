#Spark iOS SDK

This open-source SDK library enables you to easily integrate the Spark 3D printing API into your iOS applications.<br>
Spark APIs are web based RESTful APIs providing an open, free and complete toolkit of professional-grade resources for 3D printing and related manufacturing processes. 

<b>Spark APIs are current in beta: [Request access](https://spark.autodesk.com/developers/).</b>

##Getting Started

Download this repository and import it into your project.

The Spark iOS SDK comes with a sample app, located in the library’s App folder.

To use the Spark iOS SDK you must first <i>add an app</i> on the [Spark Developers Portal](https://spark.autodesk.com/developers/myApps) and save the app key and app secret Spark generates. For more information see [the tutorial](https://spark.autodesk.com/developers/reference/software-developers/tutorials/register-an-app).

##Setting Up the SDK

##1. Initialization

Call the init method passing the app key and app secret allocated by the [developer portal](https://spark.autodesk.com/developers/myApps):
```objective-c
 [[SparkManager sharedInstance] initKey:[appKey] appSecret:[appSecret] envType:[ENV_TYPE]];
```
Enable debug mode to see logcat messages regarding your configuration and any error messages or notifications.<br>
```objective-c
 [[SparkManager sharedInstance] setDebugMode:YES];
```

##2. Authentication

Spark API use OAUTH 2.0 authentication.<br>
There are two types of authentication available:<br>
* Guest Token - For read only permissions. Gives you access to public data on Spark.
* Access Token - For read/write access to a Spark member’s private data. Access Tokens log the user in from your app.

###2.1 Generate a Guest Token

```objective-c
    [[SparkAuthentication sharedInstance] getGuestToken:^(AccessTokenResponse *responseObject) {
        // Success !
        // Call Spark API
    } failure:^(NSString *error) {
        // Failure
        // Check error message
    }];
```

###2.2  Get Access Token
```objective-c
    [[SparkAuthentication sharedInstance] getAuthorizationCode:^(AccessTokenResponse *responseObject) {
        // Success !
        // Call Spark API
    } failure:^(NSString *error) {
        // Failure
        // Check error message
    } parentViewController:self];

```
##3. List of the Spark API Available in the SDK

###3.1 Authentication API
```objective-c
    - (void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
    - (void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                     failure:(SparkAuthenticationFailureBlock)failBlock
        parentViewController:(UIViewController*)parent;
```
The Authentication API authenticates users and apps and provides access to the Spark API. 
Autentication API documentation: https://spark.autodesk.com/developers/reference/api/authentication.

###3.2 Drive API
```objective-c     
    - (void)sparkUploadFile:(FileRequest*) fileRequest
           succesBlock:(SparkSuccessBlock)sucssesBlock
               failure:(SparkFailureBlock)failureBlock;

    - (void)sparkMeshImport:(MeshImportRequest*)meshImportRequest
            succesBlock:(SparkSuccessBlock)succesBlock
                failure:(SparkFailureBlock)failureBlock;
```

The Drive API stores 3D models and their files, uploads files for printing, provides social network services such as “like” of members, “favorite” models and attaches comments to models. 
Drive API Documentation: https://spark.autodesk.com/developers/reference/api/drive.

##Feedback

Please report bugs or issues to Spark Support at https://spark.autodesk.com/developers/support/inbox or simply let us know what you think of the SDK.

