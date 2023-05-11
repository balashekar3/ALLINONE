//
//  NetworkConnectivityManager.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 04/05/23.
//

import Foundation
import Network

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    private(set) var isExpensive = false
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
            
            NotificationCenter.default.post(name: .connectivityStatus, object: nil)
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
//Useage:
//Monitoring can be started from anywhere in the code by simply calling NetworkMonitor.shared.startMonitoring(), though in most cases you'll want to initiate this process in the AppDelegate. Then, we can use NetworkMonitor.shared.isConnected to check the status of our network connection in real-time.

//override func viewDidLoad() {
//       super.viewDidLoad()
//       NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
//   }
//
//   @objc func showOfflineDeviceUI(notification: Notification) {
//       if NetworkMonitor.shared.isConnected {
//           print("Connected")
//       } else {
//           print("Not connected")
//       }
//   }
