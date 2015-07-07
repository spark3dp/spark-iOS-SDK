//
//  SparkDrive.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SparkDrive.h"
#import "SparkManager.h"

@implementation SparkDrive

static SparkDrive *sharedInstance = nil;

+ (SparkDrive *)sharedInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SparkDrive alloc] init];
    });
    
    return sharedInstance;
}



///** Get asset by asset ID.
// *
// * @param asset Asset request object containing the asset ID.
// * @param onAssetResponse Asset object response.
// */
//
//-(void)sparkGetAsset:(AssetRequest*)asset
//        succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
//             failure:(SparkAuthenticationFailureBlock)failBlock {
//    
//    if ([[SparkManager sharedInstance] checkPreConfiguration]) {
//        [self.networkUtils getAsset:asset succsesBlock:succsesBlock failure:failBlock];
//    }
//}

///** Get the current available assets.
// *
// * @param onAssetResponse Assets response object.
// */
//
//-(void)sparkGetAssets(ISparkResponse<AssetsListResponse> onAssetResponse) {
//      if ([[SparkManager sharedInstance] checkPreConfiguration]) {
//        getNetworkUtils().getAssets(onAssetResponse);
//    }
//}
//
///** Get Assets of Member, filled with member ID.
// *
// * @param member Member of the assets.
// * @param onAssetsResponse Assets response Object
// */
//-(void)sparkGetMemberAssets(MemberRequest member,ISparkResponse<AssetsListResponse> onAssetResponse) {
//    if (Spark.checkPreConfiguration()) {
//        getNetworkUtils().getMemberAssets(member,onAssetResponse);
//    }
//    
//}
//
///** Get member by member ID.
// *
// * @param member Member request object, usually filled with member ID.
// * @param onMemberResponse Member response object.
// */
//-(void)sparkGetMember(MemberRequest member,ISparkResponse<MemberResponse> onMemberResponse) {
//    if ([[SparkManager sharedInstance] checkPreConfiguration]) {
//        getNetworkUtils().getMember(member, onMemberResponse);
//    }
//}
//
///** Get the current member details
// *
// * @param onMemberResponse Member response object
// */
//-(void)sparkGetCurrentMember(ISparkResponse<MemberResponse> onMemberResponse) {
//     if ([[SparkManager sharedInstance] checkPreConfiguration]) {
//        getNetworkUtils().getMember(new MemberRequest(""), onMemberResponse);
//    }
//}
//
///** Create new asset object.
// *
// * @param asset Asset object to create, filled with asset data.
// * @param onCreateAssetResponse Asset created response oobject.
// */
//-(void)sparkCreateAsset(AssetRequest asset, ISparkResponse<AssetResponse> onCreateAssetResponse) {
//     if ([[SparkManager sharedInstance] checkPreConfiguration]) {
//        getNetworkUtils().createAsset(asset, onCreateAssetResponse);
//    }
//}

/** upload file and upload it to the server.
 *
 * @param file New file to create, filled with file data and path.
 * @param onSparkResponse File response object.
 */
-(void)sparkUploadFile:(FileRequest*)fileRequest
           succesBlock:(SparkDriveSuccessBlock)sucssesBlock
               failure:(SparkDriveFailureBlock)failureBlock{
    
     if ([[SparkManager sharedInstance] checkPreConfiguration]) {
         
         [self.networkUtils uploadFile:fileRequest
                               success:sucssesBlock
                               failure:failureBlock];
    }
}


@end
