//
//  EventParser.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

internal class EventParser {
    
    // Events are separated by end of line. End of line can be:
    // \r = CR (Carriage Return) → Used as a new line character in Mac OS before X
    // \n = LF (Line Feed) → Used as a new line character in Unix/Mac OS X
    // \r\n = CR + LF → Used as a new line character in Windows
    private let newlineCharacters = [
        "\r\n",
        "\n",
        "\r"
    ]
    
    private let buffer: EventBuffer
    
    init() {
        self.buffer = EventBuffer(newlineCharacters: self.newlineCharacters)
    }
    
    func parse(data: Data?) -> [Event] {
        
        return self.buffer
            .append(data: data)
            .map { self.event(from: $0) }
        
    }
    
    private func event(from string: String) -> Event {
        
        var event = [String: String?]()
        
        for line in string.components(separatedBy: CharacterSet.newlines) as [String] {
            
            guard let (key, value) = parseLine(line) else { continue }
            
            if let value = value, let lastValue = event[key] ?? nil {
                event[key] = "\(lastValue)\n\(value)"
            }
            else if let value = value {
                event[key] = value
            }
            else {
                event[key] = nil
            }
            
        }
                
        return Event(
            id: event["id"] ?? nil,
            type: event["event"] ?? nil,
            data: event["data"] ?? nil
        )
        
    }
    
    private func parseLine(_ line: String) -> (key: String, value: String?)? {
        
        var nsKey: NSString?
        var nsValue: NSString?
        
        let scanner = Scanner(string: line)
        scanner.scanUpTo(":", into: &nsKey)
        scanner.scanString(":", into: nil)
        
        for character in self.newlineCharacters {
            if scanner.scanUpTo(character, into: &nsValue) {
                break
            }
        }
        
        // If theres no key, abort.
        
        guard let _nsKey = nsKey,
              _nsKey.length > 0 else { return nil }

        // For id & data, if they come empty
        // they should return an empty string not nil.
        
        if _nsKey != "event" && nsValue == nil {
            nsValue = ""
        }

        return (
            _nsKey as String,
            nsValue as String?
        )
        
    }
    
}
