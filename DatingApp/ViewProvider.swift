//
//  ViewProvider.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 02.06.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit

class ViewProvider {
    
    static func provideVM() -> ViewModel {
        return ViewModel(repository: AppProvider.providePersonRepository())
    }
}
