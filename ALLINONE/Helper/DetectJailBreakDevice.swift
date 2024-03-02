//
//  DetectJailBreakDevice.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 01/03/24.
//

import Foundation
import UIKit

// Protocol function
//
// sendTheStatusOfJailBreak:- True/ False value to be send if device is JailBreak
//
public protocol Check_Method_Of_JailBreak: AnyObject {
    func sendTheStatusOfJailBreak(value: Bool)
}

// Constant of FileManager path
let fm = FileManager.default

// isSimulator - Returns true if it is run on Simulator
private var isSimulator: Bool {
    return TARGET_OS_SIMULATOR != 0
}

// Array - filesPathToCheck
//
// Important files and App to check if the device is jailBroken
//
private var filesPathToCheck: [String] {
    
    return ["/private/var/lib/apt",
            "/Applications/Cydia.app",
            "/private/var/lib/cydia",
            "/private/var/tmp/cydia.log",
            "/Applications/RockApp.app",
            "/Applications/Icy.app",
            "/Applications/WinterBoard.app",
            "/Applications/SBSetttings.app",
            "/Applications/blackra1n.app",
            "/Applications/IntelliScreen.app",
            "/Applications/Snoop-itConfig.app",
            "/usr/libexec/cydia/",
            "/usr/sbin/frida-server",
            "/usr/bin/cycript",
            "/usr/local/bin/cycript",
            "/usr/lib/libcycript.dylib",
            "/bin/sh",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh",
            "/bin.sh",
            "/var/checkra1n.dmg",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist"]
    
}

private let jailBreakTestText = "Test for JailBreak"

// enum - TypeOfJailBreakCheckAPI
//
// Developer can select which func call they want to check for jail break detection
// Either readWrite or systemCalls
// It is preferabble to call readAndWrite func
//
public enum TypeOfJailBreakCheckAPI {
    case readAndWriteFiles , systemCalls
    mutating public func assignJailBreakCheckType(type: TypeOfJailBreakCheckAPI) {
        switch self {
        case .readAndWriteFiles:
            self = .readAndWriteFiles
        case .systemCalls:
            self = .systemCalls
            
        }
    }
}

public extension Check_Method_Of_JailBreak {
    
    // Protocol function extended for JailBreak detection
    //
    func assignJailBreakCheckType(type: TypeOfJailBreakCheckAPI) {
        // If it is run on simulator follow the regular flow of the app
        if !isSimulator{
            // Check if Cydia app is installed on the device
            guard UIApplication.shared.canOpenURL(URL(string: "cydia://")!) else {
                
                let checkStatus = type == .readAndWriteFiles ? canEditSandboxFilesForJailBreakDetection() : systemForkCall()
                
                self.sendTheStatusOfJailBreak(value: checkStatus)
                return
            }
            self.sendTheStatusOfJailBreak(value: true)
        }
        self.sendTheStatusOfJailBreak(value: false)
    }
    
    // func - canEditSandboxFilesForJailBreakDetecttion
    //
    // It tries to write into system files
    // If it is able to write files then it is JailBroken device
    //
    func canEditSandboxFilesForJailBreakDetection() -> Bool {
        let jailBreakTestText = "Test for JailBreak"
        do {
            try jailBreakTestText.write(toFile:"/private/jailBreakTestText.txt", atomically:true, encoding:String.Encoding.utf8)
            return true
        } catch {
            let resultJailBroken = isJailBrokenFilesPresentInTheDirectory()
            return resultJailBroken
        }
    }
    
    // func - isJailBrokenFilesPresentInTheDirectory
    //
    // It checks from the array 'filesPathToCheck' that particular file or app
    // are installed on the device
    // If file exist then it is jail broken
    //
    func isJailBrokenFilesPresentInTheDirectory() -> Bool{
        var checkFileIfExist: Bool = false
        filesPathToCheck.forEach {
            checkFileIfExist =  fm.fileExists(atPath: $0) ? true : false
            if checkFileIfExist{
                return
            }
        }
        
        return checkFileIfExist
    }
    
    // func:- systemForkCall
    //
    // It is used to check if there is a child process run at kernel level
    //
    func systemForkCall() -> Bool{
        
        let pid = getpgrp()
        
        if pid < 0
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
}

//Useage
//import UIKit
//import CheckJailBreakDevice
//
//class ViewController: UIViewController, Check_Method_Of_JailBreak {
//    // Method to take necessary action
//    func sendTheStatusOfJailBreak(value: Bool) {
//        if value{
//            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
//            // exit(-1)
//        }
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // What type of check on need to do either by 'readAndWriteFiles' on system or by calling API of system to check if it can run child process
//        // preferable is 'readAndWriteFiles'
//        assignJailBreakCheckType(type: .readAndWriteFiles)
//    }
//
//
//}
