//
//  Data.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let speciesData: [Species] = load("speciesData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    
    let dataUrl: URL = {
        let url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first!
        let dataUrl = url.appendingPathComponent(filename)
        return dataUrl
    }()
    
    let fileManager = FileManager.default
    
    //* for debug
    if fileManager.fileExists(atPath: dataUrl.path) {
        do {
            try fileManager.removeItem(at: dataUrl)
        } catch {
            fatalError("Couldn't remove \(file) at \(dataUrl):\n\(error)")
        }
    }
    //end for debug*/
    
    if !fileManager.fileExists(atPath: dataUrl.path) {
        do {
            try fileManager.copyItem(at: file, to: dataUrl)
        } catch {
            fatalError("Couldn't copy \(file) to \(dataUrl):\n\(error)")
        }
    }
    
    do {
        data = try Data(contentsOf: dataUrl)
    } catch {
        fatalError("Couldn't load \(filename):\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func update<T: Encodable>(_ rawData: T, to filename: String) {
    
    let file: URL = {
        let url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first!
        let dataUrl = url.appendingPathComponent(filename)
        return dataUrl
    }()
    
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(rawData)
        try data.write(to: file)
    } catch {
        fatalError("Couldn't update \(file):\n\(error)")
    }
}
