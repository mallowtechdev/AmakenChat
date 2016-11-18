//
//  ACWelcomeTableViewCell.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit
import AlamofireImage

private let contentViewCellIdentifier = "ContentCell"

class ACWelcomeTableViewCell: ACCardCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var welcomeCard: ACWelcomeCardEntity?
    let cellHeight: CGFloat = 80.0

    @IBOutlet weak var cardImageView: ACImageView!
    @IBOutlet weak var channelNameLabel: ACLabel!
    @IBOutlet weak var channelNoLabel: ACLabel!
    @IBOutlet weak var addedDateLabel: ACLabel!
    @IBOutlet weak var headTextLabel: ACLabel!
    @IBOutlet weak var bodyTextLabel: ACLabel!
    @IBOutlet weak var bodyTextCharacterLimitLabel: ACLabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    // MARK:- Custom methods
    
    func updateCell() {
        collectionView.reloadData()
        
        channelNameLabel.text = welcomeCard?.channelName
        channelNameLabel.textColor = UIColor(hexString: (welcomeCard?.channelNameColor)!)
        channelNameLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (welcomeCard?.channelNameAlign)!)
        
        channelNoLabel.text = String(format: "Channel.: %@", (welcomeCard?.channelNo)!)
        channelNoLabel.textColor = UIColor(hexString: (welcomeCard?.channelNoColor)!)
        channelNoLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (welcomeCard?.channelNoAlign)!)
        
        addedDateLabel.text = ACHelper.changeWelcomeCardDateFormat(dateString: (welcomeCard?.addedDate)!)
        addedDateLabel.textColor = UIColor(hexString: (welcomeCard?.addedDateColor)!)
        
        headTextLabel.text = welcomeCard?.headText
        headTextLabel.textColor = UIColor(hexString: (welcomeCard?.headTextColor)!)
        headTextLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (welcomeCard?.headTextAlign)!)
        
        let bodyText = (welcomeCard?.bodyText)!
        var bodyTextArray = bodyText.components(separatedBy: "\\n ")
   
        bodyTextLabel.textColor = UIColor(hexString: (welcomeCard?.bodyTextColor)!)
        bodyTextLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (welcomeCard?.bodyTextAlign)!)
        bodyTextCharacterLimitLabel.textColor = UIColor(hexString: (welcomeCard?.bodyTextColor)!)
        bodyTextCharacterLimitLabel.textAlignment = ACHelper.parseTextAlignmentFromString(align: (welcomeCard?.bodyTextAlign)!)
        
        if bodyTextArray.count == 2 {
            bodyTextLabel.text = bodyTextArray[0]
            bodyTextCharacterLimitLabel.text = bodyTextArray[1]
        } else {
            bodyTextLabel.text = bodyText
            bodyTextCharacterLimitLabel.text = nil
        }
        
        let url = URL(string: (welcomeCard?.cardLogo)!)!
        cardImageView.af_setImage(withURL: url)
    }
    
    
    // MARK:- Collection view data source methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeCard?.contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentViewCellIdentifier, for: indexPath) as! ACContentCollectionViewCell
        cell.content = welcomeCard?.contents?.allObjects[indexPath.row] as! ACContentEntity?
        cell.updateCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }

}
