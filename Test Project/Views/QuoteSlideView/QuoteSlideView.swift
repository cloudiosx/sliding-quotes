//
//  QuoteSlideView.swift
//  Test Project
//
//  Created by John Kim on 11/3/22.
//

import UIKit

class QuoteSlideView: UIView {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var author: UILabel!
    
    var quote: Quote!
    
    func configure() {
        self.quoteLabel.text = "\"\(quote.quote)\""
        self.author.text = quote.author
    }
    
}
