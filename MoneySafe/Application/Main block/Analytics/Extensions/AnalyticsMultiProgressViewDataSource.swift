//
//  AnalyticsMultiProgressViewDataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 06.01.2022.
//

import Foundation
import MultiProgressView

extension AnalyticsViewController: MultiProgressViewDataSource {
    
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return 1
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let section = ProgressViewSection()
        let currentColor = UIColor.mainYellow
        
        section.backgroundColor = currentColor
        
        return section
    }
}
