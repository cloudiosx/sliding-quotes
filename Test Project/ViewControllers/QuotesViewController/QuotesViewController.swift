//
//  QuotesViewController.swift
//  Test Project
//
//  Created by John Kim on 11/3/22.
//

import UIKit

class QuotesViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    var viewModel: QuotesViewModel = QuotesViewModel()
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    // Setup inital state of views
    fileprivate func setupViews () {
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel.quotes.count
        scrollView.backgroundColor = .white
        let slides = createSlides()
        if slides.count > 0 {
            let duration = viewModel.quotes[viewModel.currentIndex].slideTransitionDelay / 1000
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(duration), target: self, selector: #selector(changeSlide), userInfo: nil, repeats: false)
        }
        setupSlideScrollView(slides: slides)
        
    }
    // Create slide view from json data
    fileprivate func createSlides() -> [QuoteSlideView] {
        var allSlides: [QuoteSlideView] = []
        for quote in viewModel.quotes {
            let slideView : QuoteSlideView = Bundle.main.loadNibNamed("QuoteSlideView", owner: self, options: nil)?.first as! QuoteSlideView
            slideView.quote = quote
            slideView.configure()
            allSlides.append(slideView)
        }
        return allSlides
    }
    // Setup scrollview
    fileprivate func setupSlideScrollView(slides : [QuoteSlideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(viewModel.quotes.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    // Change slide with animation when timer runs out
    @objc fileprivate func changeSlide() {
        
        UIView.animate(withDuration:1,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1,
                       options: .beginFromCurrentState,
                       animations: {
            self.timer.invalidate()
            self.viewModel.currentIndex += 1
            if self.viewModel.currentIndex == self.viewModel.quotes.count {
                self.pageControl.currentPage = 0
                self.scrollView.contentOffset.x = 0
                self.viewModel.currentIndex = 0
            } else {
                self.pageControl.currentPage = self.viewModel.currentIndex
                self.scrollView.contentOffset.x = self.scrollView.contentOffset.x + self.view.frame.width
            }
            let duration = self.viewModel.quotes[self.viewModel.currentIndex].slideTransitionDelay / 1000
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(duration), target: self, selector: #selector(self.changeSlide), userInfo: nil, repeats: false)
        }, completion: {
            (value: Bool) in
            
        })
    }
    
    
}

extension QuotesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        viewModel.currentIndex = Int(pageIndex)
        timer.invalidate()
    }
}
