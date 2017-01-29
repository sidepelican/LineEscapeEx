//
//  SourceEditorCommand.swift
//  TemporaryRefugeEx
//
//  Created by kenta on 2017/01/29.
//  Copyright © 2017年 sidepelican. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let buffer: XCSourceTextBuffer = invocation.buffer
        guard let selection = buffer.selections.firstObject as? XCSourceTextRange else {
            completionHandler(NSError(domain: "TemporaryRefuge", code: -1, userInfo: [NSLocalizedDescriptionKey: "No selection"]))
            return
        }
        
        // find insert position (ignore empty line)
        var startIndex = selection.start.line
        while let line = buffer.lines[startIndex] as? String, isEmptyLine(line) {
            startIndex += 1
        }
        
        // duplicate lines as comment (ignore empty line)
        let duplines = selectedLines(buffer: buffer, selection: selection).filter{ !isEmptyLine($0) }
        duplines.reversed().forEach{ line in
            buffer.lines.insert("// " + line, at: startIndex)
        }
        
        completionHandler(nil)
    }
    
    private func selectedLines(buffer: XCSourceTextBuffer, selection: XCSourceTextRange) -> [String] {
        
        var selectedRange = selection.start.line...selection.end.line
        
        // For triple-click Xcode selects one additional line, we don't want to duplicate it // from castus
        let selectedRangeLength = selectedRange.distance(from: selectedRange.startIndex, to: selectedRange.endIndex)
        if selectedRangeLength > 1 && selection.end.column == 0 {
            selectedRange = selection.start.line...(selection.end.line - 1)
        }
        
        return selectedRange.flatMap{ buffer.lines[$0] as? String }
    }
    
    private func isEmptyLine(_ line: String) -> Bool {
        return line.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) == nil
    }
}
