//
//  NetworkMonitor.swift
//  MaxPay
//
//  Created by Admin on 03/06/24.
//


import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    private(set) var isConnected: Bool = false
    private(set) var interfaceType: NWInterface.InterfaceType?

    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.interfaceType = self?.getInterfaceType(path)
        }
        monitor.start(queue: queue)
    }
    
    private func getInterfaceType(_ path: NWPath) -> NWInterface.InterfaceType? {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
        } else {
            return nil
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}


