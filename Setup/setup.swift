#!/usr/bin/env swift

import Foundation

// MARK: Utilities

func error(_ message: String) {
    print("Error: \(message)")
}

func usage() {
    print("Usage: setup.swift <year>")
}

func createDirectory(at url: URL) {
    try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
}

func createFile(with contents: String, at url: URL) {
    try? Data(contents.utf8).write(to: url)
}

func contents(at url: URL) -> String {
    guard let data = FileManager.default.contents(atPath: url.path),
          let contents = String(data: data, encoding: .utf8) else {
        error("Unable to read file data at: \(url.path)")
        exit(1)
    }
    
    return contents
}

func createYearContext(year: Int, at root: URL, setupDirectory: URL) {
    let yearDirectory = root.appending(path: "AdventOfCode\(year)")
    
    createDirectory(at: yearDirectory)

    let rawYearFile = contents(at: setupDirectory.appending(path: "Year_Template.swift"))
    let currentYearFile = rawYearFile.replacingOccurrences(of: "num", with: "\(year)")

    createFile(with: currentYearFile, at: yearDirectory.appending(path: "\(year).swift"))
}

func createDayContext(day: Int, year: Int, at root: URL, setupDirectory: URL) {
    let dayDirectory = root
        .appending(path: "AdventOfCode\(year)")
        .appending(path: "Day\(day)")
    
    createDirectory(at: dayDirectory)
    
    let rawDayFile = contents(at: setupDirectory.appending(path: "Day_Template.swift"))
    let currentDayFile = rawDayFile.replacingOccurrences(of: "num", with: "\(day)")
    
    createFile(with: currentDayFile, at: dayDirectory.appending(path: "Day\(day).swift"))
    createFile(with: "", at: dayDirectory.appending(path: "Day\(day).txt"))
}

// MARK: Setup Current Year

guard CommandLine.argc == 2 else {
    error("Unexpected number of arguments")
    usage()
    exit(1)
}

guard let year = Int(CommandLine.arguments[1]) else {
    error("Unable to parse given year")
    usage()
    exit(1)
}

let setupDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let sourcesDirectory = setupDirectory.appending(path: "../Sources")

createYearContext(
    year: year,
    at: sourcesDirectory,
    setupDirectory: setupDirectory
)

(1...25)
    .forEach { day in
        createDayContext(
            day: day,
            year: year,
            at: sourcesDirectory,
            setupDirectory: setupDirectory
        )
    }

let reminder = """
Remember to add the new year in:

- `Package.swift` for targets
- `AdventOfCode.swift` for imports
"""

print(reminder)
