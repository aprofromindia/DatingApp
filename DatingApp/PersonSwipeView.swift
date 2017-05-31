//
//  PersonSwipeView.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 29.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import MDCSwipeToChoose
import Kingfisher

final class PersonSwipeView: MDCSwipeToChooseView {

    private var person: Person!

    @IBOutlet private var personImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var employmentLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var smokingLabel: UILabel!
    @IBOutlet private var childLabel: UILabel!
    @IBOutlet private var bottomLabel: UILabel!

    init(person: Person, frame: CGRect, options: MDCSwipeToChooseViewOptions) {
        self.person = person
        super.init(frame: frame, options: options)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        personImage.layer.cornerRadius = personImage.frame.width/2
    }
    
    private func setup(){
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        
        self.likedView.center = center
        self.nopeView.center = center
        addSubview(likedView)
        addSubview(nopeView)
        
        setupPerson()
    }

    private func setupPerson() {
        let firstName = person.name.components(separatedBy: " ").first ?? ""
        
        personImage.kf.setImage(with: URL(string: person.images.first ?? ""))
        nameLabel.text = "\(firstName), \(person.age)"
        employmentLabel.text = "\(NSLocalizedString("Employment", comment: "")) - \(person.job)"
        smokingLabel.text = "\(NSLocalizedString("Smoker", comment: "")) - \(person.isSmoker ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: ""))"
        childLabel.text = "\(NSLocalizedString("Want children", comment: "")) - \(person.wantChildren ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: ""))"
        bottomLabel.text = "\(NSLocalizedString("What you should know about", comment: "")) \(firstName)"
    }
}
