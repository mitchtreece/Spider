//
//  ReachabilitMonitor.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/24/19.
//

import Reachability

public final class ReachabilityMonitor {
        
    private let reachability: Reachability
    internal var isDebugEnabled: Bool = false
    public private(set) var isMonitoring: Bool = false
    
    public var reachable: ((Reachability.Connection)->())?
    public var unreachable: ((Reachability.Connection)->())?
    
    internal init?(host: URLRepresentable?) {
        
        do {
            
            if let host = host?.urlString {
                self.reachability = try Reachability(hostname: host)
            }
            else {
                self.reachability = try Reachability()
            }
            
        }
        catch {
            
            print("🚫 <Spider>: failed to create reachability link - \(error.localizedDescription)")
            return nil
            
        }
                
        self.reachability.whenReachable = { reachability in
            self._debugLog("network reachable (\(reachability.connection.description))")
            self.reachable?(reachability.connection)
        }
        
        self.reachability.whenUnreachable = { reachability in
            self._debugLog("network unreachable")
            self.unreachable?(reachability.connection)
        }
        
        start()
        
    }
    
    public func start() {
        
        guard !self.isMonitoring else { return }
        
        do {
            try self.reachability.startNotifier()
            self.isMonitoring = true
        }
        catch {
            print("🚫 <Spider>: failed to start reachability monitor - \(error.localizedDescription)")
        }
        
    }
    
    private func stop() {
        
        guard self.isMonitoring else { return }
        self.reachability.stopNotifier()
        self.isMonitoring = false
        
    }
    
    private func _debugLog(_ message: String) {
        
        guard self.isDebugEnabled else { return }
        print("🌎 <Spider>: \(message)")
        
    }
    
}
