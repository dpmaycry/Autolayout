//
//  ViewController.swift
//  Autolayout
//
//  Created by DP on 16/4/4.
//  Copyright © 2016年 DP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginfield: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var passwordlabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var secure = false {
        didSet {updateUI()}
    }
    
    private func updateUI(){
        passwordfield.secureTextEntry = secure
        passwordlabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func toggleSecurity(sender: UIButton) {
        secure = !secure
    }
    var aspectRatioConstraint:NSLayoutConstraint?{
        willSet{
            if let existConstraint = aspectRatioConstraint{
                view.removeConstraint(existConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint{
                view.addConstraint(newConstraint)
            }
        }
    }
    var image:UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            if let constrainedView = imageView{
                if let newImage = newValue{
                    aspectRatioConstraint = NSLayoutConstraint(item:constrainedView, attribute: .Width, relatedBy: .Equal, toItem: constrainedView, attribute: .Height, multiplier: newImage.aspectRatio, constant: 0)
                }
            }
        }
    }
    var loggedInUser: User?{
        didSet{
            updateUI()
        }

    }
    @IBAction func toggleLogin(sender: UIButton) {
        loggedInUser = User.login(loginfield.text ?? "", password: passwordfield.text ?? "")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        loginfield?.resignFirstResponder()
        passwordfield?.resignFirstResponder()
    }
    
}

extension User{
    var image:UIImage? {
        if let image = UIImage(named: login){
            return image
        }else{
        return UIImage(named: "bat3")
        }
    }
    
}

extension UIImage{
    var aspectRatio:CGFloat{
        return size.height != 0 ? size.width / size.height : 0
    }
}

