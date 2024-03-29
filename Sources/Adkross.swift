//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 18.06.2022.
//

import Foundation

// MARK: - SDK Initialization

public class Adkross {
    private let backend: Backend
    private var token: String?

    public static var shared: Adkross {
        guard let adkross = adkross else {
            fatalError("Adkross SDK not initialized")
        }
        
        return adkross
    }
    private static var adkross: Adkross?
    
    private init(
        backend: Backend
    ) {
        self.backend = backend
    }

    // MARK: -
    
    static func setDefaultInstance(
        _ adkross: Adkross
    ) {
        Self.adkross = adkross
    }
}

// MARK: - Configuratiın Adkross

public extension Adkross {
    
    static func startWith(
        apiKey: String,
        appKey: String
    ) {
        let logger = Logger(
            osLog: Logger.OS(
                subsystem: "com.adkross",
                category: "ios-sdk"
            )
        )
        let parser = Parser(
            logger: logger
        )
        let network = HttpClient(
            apiKey: apiKey,
            appKey: appKey,
            logger: logger,
            parser: parser,
            encoder: JSONEncoder()
        )
        let backend = Backend(
            network: network,
            logger: logger
        )
        let adkross = Adkross(
            backend: backend
        )
                
        setDefaultInstance(adkross)
    }
}

// MARK: - Network Calls

extension Adkross {
    
    func load(
        campaignKey: String? = nil,
        completion: @escaping NetworkResult<CampaignLoad.Response>
    ) {
        backend.load(
            campaignKey: campaignKey,
            completion: completion
        )
    }

    func fireEvent(
        campaignKey: String,
        analyticEventType: EventType,
        completion: @escaping NetworkResult<FireEvent.Response>
    ) {
        backend.fireEvent(
            campaignKey: campaignKey,
            analyticEventType: analyticEventType,
            completion: completion
        )
    }
}
