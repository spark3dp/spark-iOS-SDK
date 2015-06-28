//
//  Constants.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#ifndef spark_ios_sdk_Constants_h
#define spark_ios_sdk_Constants_h

static const NSString* SDK_VERSION	= @"1.0";

// Spark Authorization types
static const int SPARK_AUTHORIZATION_TOKEN_TYPE_NONE = -1;
static const int SPARK_AUTHORIZATION_TOKEN_TYPE_GUEST = 0;
static const int SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR = 1;

// Spark token types
static NSString* SPARK_TOKEN_TYPE_NONE = @"Empty";
static NSString* SPARK_TOKEN_TYPE_GUEST = @"Guest Token";
static NSString* SPARK_TOKEN_TYPE_REGULAR = @"Access Token";

// Spark environment types
static const int SPARK_ENV_TYPE_SANBOX = 0;
static const int SPARK_ENV_TYPE_PRODUCTION = 1;

// Base Urls
static const NSString* SPARK_SCHEME = @"https";
static const NSString* SPARK_SANDBOX_AUTHORITY_AND_PATH = @"sandbox.spark.autodesk.com/api/v1";
static const NSString* SPARK_PRODUCTION_AUTHORITY_AND_PATH = @"api.spark.autodesk.com/api/v1";
static NSString* SPARK_BASE_URL_SANDBOX = @"https://sandbox.spark.autodesk.com/api/v1";
static NSString* SPARK_BASE_URL_PRODUCTION = @"https://api.spark.autodesk.com/api/v1";

// API CALLS
static const NSString* API_PRINTER_PID = @"{{PID}}";
static const NSString* API_MEMBER_MID = @"{{MID}}";
static NSString* API_GET_GUEST_TOKEN = @"oauth/accesstoken";
static const NSString* API_GET_REFRESH_TOKEN = @"oauth/refreshtoken";
static const NSString* API_GET_ASSETS = @"assets";
static const NSString* API_GET_MEMBERS_ASSETS = @"members/{{MID}}/assets";
static const NSString* API_GET_MEMBERS = @"members";
static const NSString* API_AUTHORIZE = @"oauth/authorize";
static const NSString* API_CREATE_FILE = @"files/upload";
static const NSString* API_PRINTER_REGISTER = @"print/printers/register";
static const NSString* API_PRINTER_UNREGISTER = @"print/printers";
static const NSString* API_PRINTER_CREATE_JOB = @"print/printers/{{PID}}/jobs";
static const NSString* API_PRINTER_COMMAND_SEND = @"print/printers/{{PID}}/command";
static const NSString* API_PRINTER_JOB_STATUS = @"print/jobs";
static const NSString* API_PRINTER_COMMAND_PAUSE = @"pause";
static const NSString* API_PRINTER_COMMAND_RESUME = @"resume";
static const NSString* API_PRINTER_COMMAND_CANCEL = @"cancel";

//Shared Preferences
static NSString* SHARED_PREFERENCE_ACCESS_TOKEN = @"access_token";
static NSString* SHARED_PREFERENCE_REFRESH_TOKEN = @"refresh_token";
static NSString* SHARED_PREFERENCE_AUTHORIZATION_TYPE = @"authorization_type";
static NSString* SHARED_PREFERENCE_EXPIRES_AT = @"expires_at";
static NSString* SHARED_PREFERENCE_APP_KEY = @"app_key";
static NSString* SHARED_PREFERENCE_APP_SECRET = @"app_secret";
static NSString* SHARED_PREFERENCE_APP_KEY_SECRET_BASE64 = @"key_ssecret_base64";
static NSString* SHARED_PREFERENCE_DEBUG_MODE = @"debug_mode";
static NSString* SHARED_PREFERENCE_BASE_URL = @"base_url";

// Spark Login - Query Params
static const NSString* SPARK_LOGIN_REQUEST_PARAM_RESPONSE_TYPE = @"response_type";
static const NSString* SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE = @"code";
static const NSString* SPARK_LOGIN_REQUEST_PARAM_CLIENT_ID = @"client_id";
static const NSString* SPARK_LOGIN_REQUEST_PARAM_REDIRECT_URI = @"redirect_uri";

// Spark Login - Redirect URL
static const NSString* SPARK_BOGUS_REDIRECT_URL = @"http://www.[MY-WEB-ADDRESS-FOR-CALLBACK].com";

// Spark Exceptions
static const NSString* SPARK_EXCEPTION_CONFIGURATION_ERROR = @"Configuration Error.";
static const NSString* SPARK_EXCEPTION_PERMISSIONS_ERROR = @"Permissions Error.";
static const NSString* SPARK_EXCEPTION_SPARK_TEAM = @"SPARK SDK TEAM.";

static const NSString* SPARK_EXCEPTION_PERMISSION_INTERNET = @"Please Define Internet Permission.";
static const NSString* SPARK_EXCEPTION_PERMISSION_NETWORK = @"Please Define Network Permission.";
static const NSString* SPARK_EXCEPTION_CONFIGURATION_ADD_INIT = @"Please Add Call To [ init ] Method.";
static const NSString* SPARK_EXCEPTION_CONFIGURATION_GET_TOKEN = @"Please Get Access Token First";
static const NSString* SPARK_EXCEPTION_CONFIGURATION_APPKEY = @"Please Add App Key.";
static NSString* SPARK_EXCEPTION_ACCESS_TOKEN_REQUIRED = @"Guest Token not allows this operation.\nPlease use Access Token.";

//Spark Server Exceptions
static const NSString* SPARK_SERVER_ERROR_ACCESS_TOKEN_EXPIRED = @"Access Token expired";
#endif
