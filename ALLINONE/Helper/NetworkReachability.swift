//
//  NetworkReachability.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import Network

class Reachability {
    static let shared = Reachability()
    
    let monitorForWifi = NWPathMonitor(requiredInterfaceType: .wifi)
    let monitorForCellular = NWPathMonitor(requiredInterfaceType: .cellular)
    private var wifiStatus: NWPath.Status = .requiresConnection
    private var cellularStatus: NWPath.Status = .requiresConnection
    var isReachable: Bool { wifiStatus == .satisfied || isReachableOnCellular }
    var isReachableOnCellular: Bool { cellularStatus == .satisfied }
    
    func startMonitoring() {
        monitorForWifi.pathUpdateHandler = { [weak self] path in
            self?.wifiStatus = path.status
            
            if path.status == .satisfied {
                debugPrint("Wifi is connected!")
                // post connected notification
            } else {
                debugPrint("No wifi connection.")
                // post disconnected notification
            }
        }
        monitorForCellular.pathUpdateHandler = { [weak self] path in
            self?.cellularStatus = path.status
            
            if path.status == .satisfied {
                debugPrint("Cellular connection is connected!")
                // post connected notification
            } else {
                debugPrint("No cellular connection.")
                // post disconnected notification
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitorForCellular.start(queue: queue)
        monitorForWifi.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitorForWifi.cancel()
        monitorForCellular.cancel()
    }
    
    class func isConnectedToNetwork() -> Bool {
        return shared.isReachable
    }
}
