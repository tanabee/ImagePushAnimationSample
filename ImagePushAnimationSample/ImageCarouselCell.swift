//
//  ImageCarouselCell.swift
//  ImagePushAnimationSample
//
//  Created by tanabe yuki on 2016/01/18.
//  Copyright © 2016年 monopocket. All rights reserved.
//

import UIKit
import Alamofire

protocol ImageCarouselCellDelegate {
    func imageSelected(imageUrlStr: String)
}

class ImageCarouselCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegateProperty: ImageCarouselCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageUrls = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        Alamofire
            .request(.GET, "https://api.photozou.jp/rest/search_public.json", parameters: ["keyword": "snow"])
            .responseJSON { response in
                if let result = response.result.value as? [String:AnyObject],
                info = result["info"] as? [String:AnyObject],
                photo = info["photo"] as? [[String:AnyObject]] {
                    self.imageUrls = photo.map({ (dict) -> String in
                        return dict["image_url"] as! String
                    })
                }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.mainImageView.sd_setImageWithURL(NSURL(string: imageUrls[indexPath.row]))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegateProperty?.imageSelected(imageUrls[indexPath.row])
    }
    
}
