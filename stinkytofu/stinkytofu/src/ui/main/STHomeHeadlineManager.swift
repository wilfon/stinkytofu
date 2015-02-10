//
//  STHomeHeadlineManager.swift
//  stinkytofu
//
//  Created by wil on 2015-02-10.
//  Copyright (c) 2015 Mountain Special. All rights reserved.
//

import Foundation
import UIKit


class STHomeHeadlineManager: NSObject, UIScrollViewDelegate {
    let colors: [UIColor]!
    var views = [UIView?]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override init() {
        colors = [UIColor.redColor(), UIColor.orangeColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.purpleColor()]
        
        let ccount = colors.count
        views.reserveCapacity(ccount)
        for _ in 0..<ccount {
            views += [nil]
        }
    }
    
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width;
        let page = Int(floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)));
        println("Current page: \(page)")
        
        // Update the page control
        pageControl.currentPage = page;
        
        // Work out which pages you want to load
        let firstPage = page - 1;
        let lastPage = page + 1;
        
        // Purge anything before the first page
        for var i = 0; i<firstPage; i++ {
            purgePage(i)
        }
        
        // Load pages in our range
        for i in firstPage...lastPage {//(NSInteger i=firstPage; i<=lastPage; i++) {
            loadPage(i)
        }
        
        // Purge anything after the last page
        for var i=lastPage+1; i<colors.count; i++ {
            purgePage(i)
        }
    }
    
    func loadPage(page: Int) {
        if (page < 0 || page >= colors.count) {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if views[page] == nil {
            // 2
            var frame = scrollView.bounds;
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            // 3
            var newPageView = UIView(frame: frame)
            newPageView.backgroundColor = colors[page]
            scrollView.addSubview(newPageView)
            views[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        if (page < 0 || page >= colors.count) {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = views[page] {
            pageView.removeFromSuperview()
            views[page] = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
}