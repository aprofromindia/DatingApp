//
//  ViewController.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 25.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit
import RxSwift
import Koloda

final class ViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel(repository: PersonRepository.instance)
    @IBOutlet weak var swipeView: KolodaView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.fetchWeatherList()
        
        swipeView.delegate = self
        swipeView.dataSource = self
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.people.value.count
    }
}

