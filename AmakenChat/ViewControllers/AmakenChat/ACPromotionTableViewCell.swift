//
//  ACPromotionTableViewCell.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

private let promotionContentViewCellIdentifier = "PromotionContentCell"

class ACPromotionTableViewCell: ACCardCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var promotionCard: ACPromotionCardEntity?
    let cellHeight: CGFloat = 130.0

    @IBOutlet weak var viewMoreButton: ACButton!
    @IBOutlet weak var startChatButton: ACButton!
    @IBOutlet weak var cardImageView: ACImageView!
    @IBOutlet weak var channelNameLabel: ACLabel!
    @IBOutlet weak var channelNoLabel: ACLabel!
    @IBOutlet weak var addedDateLabel: ACLabel!
    @IBOutlet weak var headTextLabel: ACLabel!
    @IBOutlet weak var commentsCount: ACLabel!
    @IBOutlet weak var likesCount: ACLabel!
    @IBOutlet weak var viewsCount: ACLabel!

   
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    // MARK:- Custom methods
    
    func updateCell() {
        collectionView.reloadData()
        
        channelNameLabel.text = promotionCard?.channelName
        channelNameLabel.textColor = UIColor(hexString: (promotionCard?.channelNameColor)!)
        channelNameLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (promotionCard?.channelNameAlign)!)
        
        channelNoLabel.text = String(format: "Channel No.: %d", (promotionCard?.channelNo)!)
        channelNoLabel.textColor = UIColor(hexString: (promotionCard?.channelNoColor)!)
        channelNoLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (promotionCard?.channelNoAlign)!)
        
        addedDateLabel.text = ACHelper.changePromotionCardDateFormat(dateString: (promotionCard?.addedDate)!)
        addedDateLabel.textColor = UIColor(hexString: (promotionCard?.addedDateColor)!)
        headTextLabel.text = promotionCard?.headText
        headTextLabel.textColor = UIColor(hexString: (promotionCard?.headTextColor)!)
        headTextLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (promotionCard?.headTextAlign)!)
        
        commentsCount.text = promotionCard?.commentsCount
        likesCount.text = promotionCard?.likeCount
        viewsCount.text = promotionCard?.viewersCount 
        
        let url = URL(string: (promotionCard?.cardLogo)!)!
        cardImageView.af_setImage(withURL: url)
        
    }
    
    
    // MARK:- Collection view data source methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotionCard?.contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: promotionContentViewCellIdentifier, for: indexPath) as! ACPromotionCollectionViewCell
        cell.content = promotionCard?.contents?.allObjects[indexPath.row] as! ACContentEntity?
        cell.updateCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
}
