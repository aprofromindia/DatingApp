//
//  ViewController.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 25.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MDCSwipeToChoose
import Kingfisher

final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel(repository: PersonRepository.instance)

    private var swipeView: PersonSwipeView!
    @IBOutlet private var wildCardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.fetchWeatherList()

        setupNetworkActivityIndicator()
        setupLabel()
        setupSwipeView()
    }

    private func setupSwipeView() {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = NSLocalizedString("Yes", comment: "")
        options.likedColor = Color.green
        options.nopeText = NSLocalizedString("No", comment: "")
        options.nopeColor = Color.red
        
        let rect = self.view.bounds

        viewModel.people.asDriver().drive(onNext: { [unowned self] people in
            if let first = people.first {
                let view = PersonSwipeView(person: first,
                                           frame: CGRect(x: 0, y: 100, width: rect.width, height: rect.height - 200),
                                           options: options)
                self.view.addSubview(view)
            }
        }).addDisposableTo(disposeBag)
    }

    private func setupNetworkActivityIndicator() {
        viewModel.networkReqOngoing.asDriver()
            .drive(onNext: { ongoing in
                UIApplication.shared.isNetworkActivityIndicatorVisible = ongoing
            }).addDisposableTo(disposeBag)
    }

    private func setupLabel() {
        viewModel.numOfWildCardsLeft.asDriver().drive(onNext: { [unowned self] num in
            self.wildCardLabel.text = NSLocalizedString("\(num) wildcard matches remaining.",
                                                        comment: "")
        }).addDisposableTo(disposeBag)
    }
}

extension ViewController: MDCSwipeToChooseDelegate {

    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        if shouldBeChosenWith == .left {
            return true
        } else {
            // Snap the view back and cancel the choice.
            UIView.animate(withDuration: 0.16, animations: { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = view.superview!.center
            })
            return false
        }
    }
}

