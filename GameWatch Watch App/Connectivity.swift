//
//  Connectivity.swift
//  GameWatch Watch App
//
//  Created by Gil Rodrigues on 04/12/2025.
//
import WatchConnectivity

@Observable
final class Connectivity: NSObject {
    static let shared = Connectivity()

    var watchConnected = false
    var lastMessage: [String: Any]? = nil

    private override init() {
        super.init()
        activate()
    }

    func activate() {
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
            
    func checkConnection() {
        if WCSession.default.activationState != .activated {
            WCSession.default.activate()
        }
    }

    func send(_ data: [String: Any]) {
        guard WCSession.default.activationState == .activated else { return }

        WCSession.default.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
}

extension Connectivity: WCSessionDelegate {
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    #endif
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.watchConnected = activationState == .activated
        }
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.watchConnected = session.isReachable
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.lastMessage = message
        }
    }
}
