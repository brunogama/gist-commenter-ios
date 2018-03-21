//
//  Logger.swift
//  GistCommenter
//
//  Created by Bruno Gama on 21/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//

import Foundation

// Tweaked version from: https://github.com/sauvikdolui/swiftlogger/blob/master/SwiftLogger/Debug/Logger.swift

internal enum LogEvent: String {
    case error = "‼️"
    case info = "ℹ️"
    case debug = "💬"
    case verbose = "🔬"
    case warning = "⚠️"
}

internal class Logger {

    static var dateFormat = "yyyy-MM-dd HH:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    class func e(_ message: String? = nil,
                 fileName: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcName: String = #function) {
        log(message: message,
            event: .error,
            fileName: fileName,
            line: line,
            column: column,
            funcName: funcName)
    }

    class func i(_ message: String? = nil,
                 fileName: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcName: String = #function) {
        log(message: message,
            event: .info,
            fileName: fileName,
            line: line,
            column: column,
            funcName: funcName)
    }

    class func d(_ message: String? = nil,
                 fileName: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcName: String = #function) {
        log(message: message,
            event: .debug,
            fileName: fileName,
            line: line,
            column: column,
            funcName: funcName)
    }

    class func v(_ message: String? = nil,
                 fileName: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcName: String = #function) {
        log(message: message,
            event: .verbose,
            fileName: fileName,
            line: line,
            column: column,
            funcName: funcName)
    }

    class func w(_ message: String? = nil,
                 fileName: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 funcName: String = #function) {
        log(message: message,
            event: .error,
            fileName: fileName,
            line: line,
            column: column,
            funcName: funcName)
    }

    class func log(message: String?,
                   event: LogEvent,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {

        #if DEBUG
            var output = "\(Date().toString())"
            output += " \(event.rawValue)"
            output += " [\(sourceFileName(filePath: fileName))]:\(line) \(column)"
            output += " \(funcName)"

            if let msg = message {
                output += " -> \(msg)"
            }

            print(output)
        #endif
    }

    private class func sourceFileName(filePath: String) -> String {
        guard let last = filePath.components(separatedBy: "/").last else {
            return ""
        }

        return last
    }
}

internal extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
