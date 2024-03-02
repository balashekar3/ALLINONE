//
//  DownloadFileManager.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession:URLSessionProtocol{}

struct DownloadFileManager {
    enum Directory {
        case cache
        case document
    }
    
    static func getDirectoryFileURL(
        _ url:URL,
        type directory: Directory
    ) -> URL? {
        guard let rootDirectory = (try? FileManager.default.url(
            for: directory == .document ? .documentDirectory : .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create:false)
        )else{
            return nil
        }
        
        let downloadedDirectory = rootDirectory.appendingPathComponent("downloads")
        try? FileManager.default.createDirectory(at: downloadedDirectory,
                                                 withIntermediateDirectories: true,
                                                    attributes: nil)
        let fileName = "\(url.absoluteString)".md5() + "_" + url.lastPathComponent
        let fileUrl = downloadedDirectory.appendingPathComponent(fileName)
        return fileUrl
    }
    
    static func downloadFileWithUrl(_ url:URL,type directory:Directory = .cache,session:URLSessionProtocol = URLSession.shared, headers:[String:String] = [:]) async -> URL? {
        guard let cachedFile = getDirectoryFileURL(url, type: directory) else {
            return nil
        }
        if FileManager.default.fileExists(atPath: cachedFile.path){
            return cachedFile
        }
        return await download(remoteURL: url, session: session, fileURL: cachedFile, headers: headers)
    }
    
    static func getDownlodedFileUrl(_ url:URL,type directory:Directory = .cache,session: URLSessionProtocol = URLSession.shared, headers:[String:String] = [:]) -> URL? {
        guard let fileURL = getDirectoryFileURL(url, type: directory) else {
            return nil
        }
        if FileManager.default.fileExists(atPath: fileURL.path){
            return fileURL
        }
        Task{
            await download(remoteURL:url, session:session,fileURL:fileURL,headers:headers)
        }
        return nil
        
    }
    
    private static func download(
        remoteURL url:URL,
        session:URLSessionProtocol,
        fileURL:URL,
        headers:[String:String]
    ) async -> URL? {
        var urlRequest = URLRequest(url: url)
        headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        do {
            let (data,response) = try await session.data(for: urlRequest, delegate: nil)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil
            }
            try data.write(to: fileURL,options: [.atomic])
            debugPrint("\(url.lastPathComponent) : Downloaded \(url) at \(fileURL)")
            return fileURL
        } catch {
            debugPrint("\(url.lastPathComponent) : Downloaded failed for \(url)")
            return nil
        }
    }
}
