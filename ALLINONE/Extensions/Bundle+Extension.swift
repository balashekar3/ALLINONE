//
//  Bundle+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation
extension Bundle{
    var shortVersion:String?{
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var bundleVersion:String?{
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    func getModel<T:Decodable>(fileName:String, fileExtesion:String? = "json") -> T? {
        guard let url = url(forResource: fileName, withExtension: fileExtesion),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        let decoder = JSONDecoder.defaultDecoder
        
        return try? decoder.decode(T.self, from: data)
    }
}

extension JSONDecoder {
    static let defaultDecoder:JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .multiDateDecoder
        return decoder
    }()
    
    func decodeArray<T:Decodable>(form data:Data) -> [T] {
        guard let wrappedArray = try? self.decode([FailableDecodable<T>].self, from:data) else {
            return []
        }
        
        return wrappedArray.compactMap { $0.base }
    }
}

struct FailableDecodable<Base: Decodable> : Decodable {
    let base:Base?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static var multiDateDecoder: JSONDecoder.DateDecodingStrategy = {
        return .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            if let date = DateFormatter.multiDateFormatter(from: dateStr){
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Can not decode date string \(dateStr)")
        }
    }()
}

extension DateFormatter {
    static let supportedFormats = [
        DateFormatConstants.isoLocalDateFormat,
        DateFormatConstants.isoUTCMilliSecondFormat,
        DateFormatConstants.isoLocalDateFormat,
        DateFormatConstants.isolocalMilliSecondFormat
    ]
    
    private static let isoFormatter = ISO8601DateFormatter()
    
    static func multiDateFormatter(from dateStr:String) -> Date?{
        if let date = isoFormatter.date(from: dateStr) {
            return date
        }
        let formatter = DateFormatter()
        
        if dateStr.lowercased().contains("z"){
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }else{
            formatter.timeZone = .current
        }
        
        for format in supportedFormats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateStr){
                return date
            }
        }
        
        return nil
    }
}

struct DateFormatConstants {
    public static let isoUTCDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    public static let isoUTCMilliSecondFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    public static let isoLocalDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    public static let isolocalMilliSecondFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
}
