//
//  OutlookService.swift
//  outlook-client-tutorial
//
//  Created by Shmuel Jacobs on 4/18/19.
//  Copyright © 2019 IcebreakerIndustries. All rights reserved.
//

import Foundation
import p2_OAuth2
import SwiftyJSON

class OutlookService {
    
    private var userEmail: String;
    
    private static let oauth2Settings = [
        "client_id" : "cc40fc6c-ce8a-414c-b7d1-cf616310f7be",
        "authorize_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
        "token_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "scope": "openid profile offline_access User.Read Mail.Read",
        "redirect_uris": ["outlook-client-tutorial://oauth2/callback"],
        "verbose": true,
        ] as OAuth2JSON;
    
    private static var sharedService: OutlookService = {
        let service = OutlookService();
        return service;
    }()
    
    private let oauth2: OAuth2CodeGrant;
    
    private init() {
        oauth2 = OAuth2CodeGrant(settings: OutlookService.oauth2Settings);
        oauth2.authConfig.authorizeEmbedded = true;
        userEmail = "";
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
    
    func makeApiCall(api: String, params: [String: String]? = nil, callback: @escaping (JSON?) -> Void) -> Void {
        
        // Build the request URL
        var urlBuilder = URLComponents(string: "https://graph.microsoft.com")!
        urlBuilder.path = api;
        
        if let unwrappedParams = params {
            // Add query parameters to URL
            urlBuilder.queryItems = [URLQueryItem]();
            for (paramName, paramValue) in unwrappedParams {
                urlBuilder.queryItems?.append(
                    URLQueryItem(name: paramName, value: paramValue)
                );
            }
        }
        
        let apiUrl = urlBuilder.url!;
        NSLog("Making request to \(apiUrl)");
        
        var req = oauth2.request(forURL: apiUrl);
        req.addValue("application/json", forHTTPHeaderField: "Accept");
        
        let loader = OAuth2DataLoader(oauth2: oauth2);
        // verbose response
        loader.logger = OAuthwDebugLogger(.trace);
        
        loader.perform(request: req) {
            response in
            do {
                let dict = try response.responseJSON()
                DispatchQueue.main.async {
                    let result = JSON(dict);
                    callback(result);
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    let result = JSON(error);
                    callback(result);
                }
            }
        }
    }
    
    func getUserEmail(callback: @escaping (String?) -> Void) -> Void {
        if (userEmail.isEmpty) {
            makeApiCall(api: "/v1.0/me") {
                result in
                if let unwrappedResult = result {
                    var email = unwrappedResult["mail"].stringValue;
                    if(email.isEmpty) {
                        email = unwrappedResult["userPrincipalName"].stringValue;
                    }
                    self.userEmail = email;
                    callback(email);
                } else {
                    callback(nil);
                }
            }
        } else {
            callback(userEmail);
        }
    }
    
}
