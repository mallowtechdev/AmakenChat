//
//  ACCardCell.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 18/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACCardCell: ACTableViewCell {

    @IBOutlet weak var collectionView: ACCollectionView!


    // MARK:- IBAction methods
    
    @IBAction func rightContentButtonPressed(_ sender: UIButton) {
        let cellSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
    
    @IBAction func leftContentButtonPressed(_ sender: UIButton) {
        let cellSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x - cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
    }
    

}
