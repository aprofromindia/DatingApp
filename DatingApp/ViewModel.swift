//
//  ViewModel.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 27.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit
import RxSwift

final class ViewModel {
    private let _repository: PersonRepository
    
    var people = Variable([Person]())
    var currentPersonIndex = Variable(0)
    var networkReqOngoing = Variable(true)

    init(repository: PersonRepository) {
        _repository = repository
    }

    func fetchWeatherList() {
        networkReqOngoing.value = true
        _repository.getPeople { [weak self] people in
            self?.people.value = people
            self?.networkReqOngoing.value = false
        }
    }
}
