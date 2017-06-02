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

private let kCardsToShow = 3
private let kMargin: CGFloat = 10
private let kTopBottomMargin: CGFloat = 100
private let kCardHeightDiff: CGFloat = 5

final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    fileprivate let viewModel = ViewProvider.provideVM()
    fileprivate var swipeViews = [PersonSwipeView]() // TODO: - use/implement a queue
    @IBOutlet private var wildCardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.fetchWildCards()

        setupNetworkActivityIndicator()
        setupWildCardLabel()
        setupSwipeView()
    }

    private func setupSwipeView() {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = NSLocalizedString("Like", comment: "")
        options.likedColor = UIColor.green
        options.nopeText = NSLocalizedString("Nope", comment: "")
        options.nopeColor = UIColor.red

        let rect = self.view.bounds

        viewModel.people.asDriver().drive(onNext: { [unowned self] people in
            for (index, person) in people.prefix(3).enumerated() {
                let swipeView = PersonSwipeView(person: person,
                                                frame: CGRect(x: kMargin,
                                                              y: CGFloat(kTopBottomMargin - (CGFloat(index) * kCardHeightDiff)),
                                                              width: rect.width - (2 * kMargin),
                                                              height: rect.height - (2 * kTopBottomMargin)),
                                                options: options)
                self.view.insertSubview(swipeView, at: 0)
                self.swipeViews.append(swipeView)
            }
            self.wildCardLabel.text = NSLocalizedString("\(people.count) wildcard matches remaining.", comment: "")
        }).addDisposableTo(disposeBag)

        viewModel.currentPersonIndex.asDriver().filter({ [unowned self] idx in
            self.viewModel.people.value.count >= idx + kCardsToShow
        }).drive(onNext: { [unowned self] idx in

            for (idx, view) in self.swipeViews.enumerated() {
                view.frame.origin = CGPoint(x: kMargin, y: kTopBottomMargin - (CGFloat(idx) * kCardHeightDiff))
            }

            let swipeView = PersonSwipeView(person: self.viewModel.people.value[idx + kCardsToShow - 1],
                                            frame: CGRect(x: kMargin, y: (kTopBottomMargin - kMargin),
                                                          width: rect.width - (2 * kMargin),
                                                          height: rect.height - (2 * kTopBottomMargin)),
                                            options: options)
            self.swipeViews.append(swipeView)
            self.view.insertSubview(swipeView, at: 0)
        }).addDisposableTo(disposeBag)
    }

    private func setupNetworkActivityIndicator() {
        viewModel.networkReqOngoing.asDriver()
            .drive(onNext: { ongoing in
                UIApplication.shared.isNetworkActivityIndicatorVisible = ongoing
            }).addDisposableTo(disposeBag)
    }

    private func setupWildCardLabel() {
        viewModel.currentPersonIndex.asDriver().drive(onNext: { [unowned self] idx in
            self.wildCardLabel.text = NSLocalizedString("\(self.viewModel.people.value.count - idx) wildcard matches remaining.", comment: "")
        }).addDisposableTo(disposeBag)
    }
}

extension ViewController: MDCSwipeToChooseDelegate {

    func view(_ view: UIView!, wasChosenWith direction: MDCSwipeDirection) {
        swipeViews.remove(at: 0)
        view.removeFromSuperview()
        viewModel.currentPersonIndex.value += 1
    }
}
