//
//  ViewController.swift
//  ImagePushAnimationSample
//
//  Created by tanabe yuki on 2016/01/18.
//  Copyright © 2016年 monopocket. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImageCarouselCellDelegate, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var animationController = AnimationController()

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = UIView()
        header.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 300)
        header.backgroundColor = UIColor.grayColor()
        tableView.tableHeaderView = header
        
        let footer = UIView()
        footer.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 300)
        footer.backgroundColor = UIColor.grayColor()
        tableView.tableFooterView = footer
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "modalImage" {
            let vc = segue.destinationViewController as! ImageViewController
            vc.mainImage = sender as! UIImage
            vc.transitioningDelegate = self
        }
    }
    
    // MARK: UITableView
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageCarouselCell") as! ImageCarouselCell
        cell.delegateProperty = self
        return cell
    }
    
    // ImageCarouselCellDelegate
    
    func imageSelected(image: UIImage, imageRect: CGRect) {
        animationController.image = image
        var rectFrom = imageRect
        rectFrom.origin.y = 300
        animationController.rectFrom = rectFrom
        self.performSegueWithIdentifier("modalImage", sender: image)
    }
    
    // UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationController.isForward = true
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationController.isForward = false
        return animationController
    }
}

