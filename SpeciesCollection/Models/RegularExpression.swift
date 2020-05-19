//
//  RegularExpression.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/18.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import Foundation

extension String {
  func match(pattern:RegexPattern) -> Bool {
    let pattern = pattern.rawValue
    let regex = try! NSRegularExpression(pattern:pattern)
    return regex.firstMatch(in:self, range:NSRange(self.startIndex..., in:self)) != nil
  }

  func extractAll(pattern:RegexPattern) -> [String] {
    let pattern = pattern.rawValue
    let regex = try! NSRegularExpression(pattern:pattern)
    return regex.matches(in:self, range:NSRange(self.startIndex..., in:self)).map { String(self[Range($0.range, in:self)!]) }
  }

  func strip() -> String {
    return self.replacingOccurrences(of:"</?\\w+>", with:"", options:NSString.CompareOptions.regularExpression, range:self.range(of:self))
  }
}

enum RegexPattern: String {
    case image = "^<image>.*</image>$"
    case caption = "^<caption>.*</caption>$"
}
