//
//  EmailOrMobileRow.swift
//
//  An entry field row for Eureka that accepts either an Email Address
//  or a Mobile-like Number as a valid input.
// 
//  Also returns the likely type of the data entry, and provides a visual 
//  indicator of the allowed types while the field is empty.
//
//  Created by Tom Gordon (cro@apsumon.com) on 29/04/2020.
//

import Foundation
import Eureka

public class EmailOrMobileRowCell: Cell<String>, CellType {
    
    @IBOutlet weak var rowImage: UIImageView!
    @IBOutlet weak var rowLabel: UITextField!
    
    private var typeImages: [String] = ["envelope", "phone"]
    private var imageCounter: Int = 0
    private var timer = Timer()
    private var crossfadeOn: Bool = true
    
    enum LikelyType: String {
        case email
        case mobile
        case none
    }
    
    public override func setup() {
        super.setup()
        
        rowLabel.addTarget(self, action: #selector(EmailOrMobileRowCell.textFieldUpdated), for: .allEditingEvents)
        rowLabel.autocorrectionType = .no
        setupImageDissolve()
    }

    public override func update() {
        super.update()
    }
    
    @objc func textFieldUpdated() {
        guard let value = rowLabel.text else { return }
        
        if !value.isEmpty {
            let entryType = isLikelyMobileOrEmail(input: value)
            switch entryType {
            case .none:
                self.crossfadeOn = true
                setupImageDissolve()
            case .email:
                self.timer.invalidate()
                self.timer = Timer()
                self.crossfadeOn = false
                rowImage.image = UIImage(systemName: "envelope")
            case .mobile:
                self.timer.invalidate()
                self.timer = Timer()
                self.crossfadeOn = false
                rowImage.image = UIImage(systemName: "phone")
                rowLabel.text = value
                row.updateCell()
            }
            
        } else {
            crossfadeOn = true
            setupImageDissolve()
        }
        
        row.value = value
        row.updateCell()
    }
    
    private func isLikelyMobileOrEmail(input: String) -> LikelyType {
        // does it have an @ symbol?
        if input.contains("@") {
            return LikelyType.email
        }
        
        // is it letters only?
        let textOnlyLikeRegex = "^([^0-9]*)$"
        let textOnlyLike = NSPredicate(format: "SELF MATCHES %@", textOnlyLikeRegex)
        if textOnlyLike.evaluate(with: input) {
            return LikelyType.email
        }
        
        // does it have any letters anywhere?
        if input.range(of: "[a-zA-Z]", options: .regularExpression) != nil {
            return LikelyType.email
        }
        
        // is it numbers only?
        let numberLikeRegex = "^([+0-9 \\-()]*)$"
        let numberLike = NSPredicate(format: "SELF MATCHES %@", numberLikeRegex)
        if numberLike.evaluate(with: input) {
            return LikelyType.mobile
        }
        
        crossfadeOn = true
        return LikelyType.none
    }
    
    private func setupImageDissolve() {
        if crossfadeOn {
            self.imageCounter = 0
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(crossFade), userInfo: nil, repeats: true)
            crossfadeOn = false
        }
    }
    
    @objc private func crossFade() {
        if imageCounter < typeImages.count - 1 {
            imageCounter += 1
        } else {
            imageCounter = 0
        }

        UIView.transition(with: rowImage, duration: 2.0, options: .transitionCrossDissolve, animations: {
            self.rowImage.image = UIImage(systemName: self.typeImages[self.imageCounter])
        }, completion: nil)
    }
    
}

public final class EmailOrMobileRow: Row<EmailOrMobileRowCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<EmailOrMobileRowCell>(nibName: "EmailOrMobileRowCell")
        
    }
}
