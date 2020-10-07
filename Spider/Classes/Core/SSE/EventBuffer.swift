//
//  EventBuffer.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

internal class EventBuffer {
    
    private var newlineCharacters: [String]
    private let buffer = NSMutableData()
    
    init(newlineCharacters: [String]) {
        self.newlineCharacters = newlineCharacters
    }
    
    func append(data: Data?) -> [String] {
        
        guard let data = data else { return [] }
        self.buffer.append(data)
        return parse()
        
    }
    
    private func parse() -> [String] {
        
        var events = [String]()
        var searchRange =  NSRange(location: 0, length: self.buffer.length)
        
        while let foundRange = searchFirstEventDelimiter(in: searchRange) {
            
            // if we found a delimiter range that means that from the beggining of the buffer
            // until the beggining of the range where the delimiter was found we have an event.
            // The beggining of the event is: searchRange.location
            // The lenght of the event is the position where the foundRange was found.
            
            let chunk = self.buffer.subdata(
                with: NSRange(
                    location: searchRange.location,
                    length: foundRange.location - searchRange.location
                )
            )

            if let text = String(bytes: chunk, encoding: .utf8) {
                events.append(text)
            }

            // We move the searchRange start position (location) after the fundRange we just found and
            
            searchRange.location = foundRange.location + foundRange.length
            searchRange.length = self.buffer.length - searchRange.location
            
        }

        // We empty the piece of the buffer we just search in.
        
        self.buffer.replaceBytes(
            in: NSRange(location: 0, length: searchRange.location),
            withBytes: nil,
            length: 0
        )

        return events
        
    }

    private func searchFirstEventDelimiter(in range: NSRange) -> NSRange? {
        
        // This methods returns the range of the first delimiter found in the buffer. For example:
        // If in the buffer we have: `id: event-id-1\ndata:event-data-first\n\n`
        // This method will return the range for the `\n\n`.
        
        let delimiters = self.newlineCharacters.map { "\($0)\($0)".data(using: .utf8)! }

        for delimiter in delimiters {
            
            let foundRange = self.buffer.range(
                of: delimiter,
                options: NSData.SearchOptions(),
                in: range
            )

            if foundRange.location != NSNotFound {
                return foundRange
            }
            
        }

        return nil
        
    }
    
}
