//
//  ACImageSlidingCell.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 18/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACImageSlidingCell: ACCollectionViewCell {

    @IBOutlet weak var contentImageForView: ACImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var content: ACContentEntity?
    
    // MARK:- Custom methods
    
    func updateCell() {
        if content?.thumbnail != nil {
            activityIndicator.startAnimating()
            let url = URL(string: (content?.thumbnail)!)!
            let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
            
            self.contentImageForView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: concurrentQueue, imageTransition: .noTransition, runImageTransitionIfCached: true) { (response) in
                if response.data != nil {
                    self.contentImageForView.image = UIImage(data: response.data!)
                }

                self.activityIndicator.stopAnimating()
            }
        } else {
            self.activityIndicator.stopAnimating()
        }
    }

}
