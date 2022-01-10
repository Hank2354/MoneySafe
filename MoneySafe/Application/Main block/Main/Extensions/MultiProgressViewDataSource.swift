//
//  MultiProgressViewDataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 29.12.2021.
//

import Foundation
import MultiProgressView

extension MainViewController: MultiProgressViewDataSource {
    
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return 1
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let section = ProgressViewSection()
        var currentColor = UIColor.mainGreen
        
        guard let pos = progressView.pos else { return ProgressViewSection() }
        
        if pos > 0.75 {
            currentColor = .mainRed
        } else if pos > 0.5 && pos <= 0.75 {
            currentColor = .mainOrange
        } else if pos > 0.25 && pos <= 0.5 {
            currentColor = .mainYellow
        }
        
        section.backgroundColor = currentColor
        
        return section
    }
}
