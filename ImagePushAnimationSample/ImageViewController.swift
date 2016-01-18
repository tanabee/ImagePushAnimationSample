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
    
    var imageUrlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.sd_setImageWithURL(NSURL(string: imageUrlStr))
    }
    
}
