//
//  ImageViewController.swift
//  ImagePushAnimationSample
//
//  Created by tanabe yuki on 2016/01/18.
//  Copyright © 2016年 monopocket. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var mainImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.image = mainImage
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
