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

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 1
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

