//
//  QuotesViewModel.swift
//  Test Project
//
//  Created by John Kim on 11/3/22.
//

import Foundation

class QuotesViewModel {
    
    var quotes: [Quote] = []
    var currentIndex = 0
    init() {
        fetchQuotes()
    }
    
    fileprivate func fetchQuotes() {
        if let url = Bundle.main.url(forResource: "AllQuotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Quote].self, from: data)
                self.quotes = jsonData
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
