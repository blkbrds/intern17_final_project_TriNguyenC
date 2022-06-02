//
//  HeaderViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import UIKit

final class HeaderSectionViewModel {
    
    // MARK: - Properties
    var sectionType: NewsViewModel.SectionType
    
    // MARK: - init
    init(sectionType: NewsViewModel.SectionType) {
        self.sectionType = sectionType
    }
}
