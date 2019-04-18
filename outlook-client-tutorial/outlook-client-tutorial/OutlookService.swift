//
//  OutlookService.swift
//  outlook-client-tutorial
//
//  Created by Shmuel Jacobs on 4/18/19.
//  Copyright © 2019 IcebreakerIndustries. All rights reserved.
//

import Foundation
import p2.OAuth2

class OutlookService {
    
    private static let oauth2Settings = [
        "client_id" : "cc40fc6c-ce8a-414c-b7d1-cf616310f7be",
        "authorize_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "token_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "scope": "openid profile offline_access User.Read Mail.Read",
        "redirect_uris": ["outlook-client-tutorial://oauth2/callback"],
        "verbose": true,
        ] as OAuth2JSON;
    
    private static var sharedService: OutlookService = {
        let service = OutlookService();
        return service;
    }
    
    private let oauth2: OAuth2CodeGrant;
    
    private init() {
        oauth2 = OAuth2CodeGrant(settings: OutlookService.oauth2Settings);
        oauth2.authConfig.authorizeEmbedded = true;
    }
    
    class func shared() -> OutlookService {
        return sharedService;
    }
    
    var isLoggedIn: Bool {
        get {
            return oauth2.hasUnexpiredAccessToken() || oauth2.refreshToken != nil;
        }
    }
    
    func handleOAuthCallback(url: URL) -> Void {
        oauth2.handleRedirectURL(url);
    }
    
    func login(from: AnyObject, callback: @escaping (String? ) -> Void) -> Void {
        oauth2.authorizeEmbedded(from: from) {
            result, error in
            if let unwrappedError = error {
                callback(unwrappedError.description);
            } else {
                if let unwrappedResult = result, let token = unwrappedResult["access_token"] as? String {
                    NSLog("Access token: \(token)");
                    callback(nil);
                }
            }
        }
    }
    
    func logout() -> Void {
        oauth2.forgetTokens();
    }
    
}
