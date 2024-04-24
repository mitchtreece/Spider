//
//  ReachabilitMonitor.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/24/19.
//

import Reachability
import protocol Espresso.URLRepresentable
import protocol Espresso.JSONRepresentable

/// Helper class that manages & notifies on network reachability events.
public final class ReachabilityMonitor {
    
    private let reachability: Reachability
    internal var isDebugEnabled: Bool = false
    
    /// Flag indicating if monitoring has started.
    public private(set) var isMonitoring: Bool = false
    
    /// The reachable handler.
    public var reachable: ((Reachability.Connection)->())?
    
    /// The unreachable handler.
    public var unreachable: ((Reachability.Connection)->())?
    
    internal init?(host: URLRepresentable?) {
        
        do {
            
            if let host = host?.asUrlString() {
                self.reachability = try Reachability(hostname: host)
            }
            else {
                self.reachability = try Reachability()
            }
            
        }
        catch {
            
            print("🚫 <Spider>: failed to create reachability monitor - \(error.localizedDescription)")
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
    
    /// Starts reachability monitoring.
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
    
    /// Stops reachability monitoring.
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
