//
//  String+Extension.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

import UIKit

extension String {
    
     func verifyUrl() -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)

    }

    func getLinkSearchKey() -> URL {
        var result = ""
        var key = self.replacingOccurrences(of: "http://", with: "")
        key = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        key = key.replacingOccurrences(of: " ", with: "+")
        if let language = Locale.preferredLanguages.first, let _ = language.components(separatedBy: "-").first {
            result = "https://google.com"
        }
        return URL(string: result)!
    }


}
