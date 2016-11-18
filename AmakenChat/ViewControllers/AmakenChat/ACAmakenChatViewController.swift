//
//  ACAmakenChatViewController.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit
import CoreData

private let welcomeCellIdentifier = "WelcomeCell"
private let promotionCellIdentifier = "PromotionCell"
private let userCellIdentifier = "UserCardCell"

class ACAmakenChatViewController: ACViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    
    var cards = [NSManagedObject]()
    var fetchedResultController: NSFetchedResultsController<ACCardEntity> = NSFetchedResultsController()
    
    
    // MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
        fetchedResultController.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(soapRequest), name: .UIApplicationWillEnterForeground, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ACAmakenChatViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        self.performFetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        soapRequest()
    }

    
    // MARK:- Custom methods
    
    func customizeNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width, height: navigationBar.frame.height / 2)
            let secondFrame = CGRect(x: 0, y: navigationBar.frame.height / 2, width: navigationBar.frame.width, height: navigationBar.frame.height / 2)
            
            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.textAlignment = .center
            firstLabel.textColor = UIColor.acWhiteColor()
            firstLabel.font = UIFont.acBoldFontWithSize(size: 17.0)
            firstLabel.text = "Al Amaken TV Chat"
            
            let secondLabel = UILabel(frame: secondFrame)
            secondLabel.textAlignment = .center
            secondLabel.textColor = UIColor.acLightGrayColor()
            secondLabel.font = UIFont.acSmallFont()
            secondLabel.text = "(Memebers 28083)"
            
            navigationBar.addSubview(firstLabel)
            navigationBar.addSubview(secondLabel)
            
            var logoImage = UIImage(named: "logo")
            logoImage = logoImage?.withRenderingMode(.alwaysOriginal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func soapRequest() {
        ACNetworkRequest.sharedInstance.soapRequest { (json, error) in
            if let errorData = error {
                let alertController = UIAlertController(title: "Error!", message: errorData.localizedDescription, preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if let json = json {
                print(json)
                let managedContext = kAppDelegate.managedObjectContext
                let cardArray = self.performFetchRequest()   // Fetching from core data using fetch request
                
                for element in json {      // Iterating each element from json response
                    var idArray: [Int] = []
                    var currentCardValue: ACCardEntity?
                    var currentWelcomeCardValue: ACWelcomeCardEntity?
                    var currentPromotionCardValue: ACPromotionCardEntity?
                    var currentUserCardValue: ACUserCardEntity?
                    
                    for eachCard in cardArray! {   // Iterating elements from core data
                        idArray.append(eachCard.id)
                        if eachCard.id == element["Id"] as! Int {
                            currentCardValue = eachCard                         // Getting current value from core data
                            currentWelcomeCardValue = eachCard.welcomeCard
                            currentPromotionCardValue = eachCard.promotionCard
                            currentUserCardValue = eachCard.userCard
                        }
                    }
                    if idArray.contains(element["Id"] as! Int) {
                        if element["CardTypeId"] as! Int == CardType.WelcomeCard.rawValue || element["CardTypeId"] as! Int == CardType.PromotionCard.rawValue || element["CardTypeId"] as! Int == CardType.UserCard.rawValue {
                            ACCardEntity.sharedInstance.updateCard(managedContext: managedContext, element: element, oldCard: currentCardValue!)
                            if CardType.WelcomeCard.rawValue == element["CardTypeId"] as! Int {
                                ACWelcomeCardEntity.sharedInstance.updateWelcomeCard(managedContext: managedContext, element: element["WelcomeCard"] as! [String : AnyObject], card: currentWelcomeCardValue!)
                            } else if CardType.PromotionCard.rawValue == element["CardTypeId"] as! Int {
                                ACPromotionCardEntity.sharedInstance.updatePromotionCard(managedContext: managedContext, element: element["PromotionCard"] as! [String : AnyObject], card: currentPromotionCardValue!)
                            } else if CardType.UserCard.rawValue == element["CardTypeId"] as! Int {
                                ACUserCardEntity.sharedInstance.updateUserCard(managedContext: managedContext, element: element["UserCard"] as! [String : AnyObject], oldCard: currentUserCardValue!)
                            }
                        }
                    } else {
                        if element["CardTypeId"] as! Int == CardType.WelcomeCard.rawValue || element["CardTypeId"] as! Int == CardType.PromotionCard.rawValue || element["CardTypeId"] as! Int == CardType.UserCard.rawValue
                        {
                            let card = ACCardEntity.sharedInstance.createCard(managedContext: managedContext, element: element) as! ACCardEntity
                            
                            if CardType.WelcomeCard.rawValue == element["CardTypeId"] as! Int {
                                let welcomeCard = ACWelcomeCardEntity.sharedInstance.createWelcomeCard(managedContext: managedContext, element: element)
                                
                                // Add Welcome card to Cards
                                card.setValue(welcomeCard, forKey: "welcomeCard")
                            } else if CardType.PromotionCard.rawValue == element["CardTypeId"] as! Int {
                                let promotionCard = ACPromotionCardEntity.sharedInstance.createPrmotionCard(managedContext: managedContext, element: element)
                                
                                // Add promotion card to Cards
                                card.setValue(promotionCard, forKey: "promotionCard")
                            } else if CardType.UserCard.rawValue == element["CardTypeId"] as! Int {
                                let userCard = ACUserCardEntity.sharedInstance.createUserCard(managedContext: managedContext, element: element)
                                
                                // Add User card to Cards
                                card.setValue(userCard, forKey: "userCard")
                            }
                            self.cards.append(card)
                            do {
                                try managedContext.save()
                            } catch let error as NSError  {
                                print("Could not save \(error), \(error.userInfo)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func performFetchRequest() -> [ACCardEntity]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let cardEntity = NSEntityDescription.entity(forEntityName: "ACCardEntity", in: kAppDelegate.managedObjectContext)
        let predicate = NSPredicate(format: "cardTypeId == %d OR cardTypeId == %d OR cardTypeId == %d", CardType.WelcomeCard.rawValue, CardType.PromotionCard.rawValue, CardType.UserCard.rawValue)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.entity = cardEntity
        do {
            let result = try kAppDelegate.managedObjectContext.fetch(fetchRequest) as! [ACCardEntity]
            return result
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    func initializeFetchResultController() -> NSFetchedResultsController<ACCardEntity> {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let cardEntity = NSEntityDescription.entity(forEntityName: "ACCardEntity", in: kAppDelegate.managedObjectContext)
        
        let predicate = NSPredicate(format: "cardTypeId == %d OR cardTypeId == %d  OR cardTypeId == %d", CardType.WelcomeCard.rawValue, CardType.PromotionCard.rawValue, CardType.UserCard.rawValue)
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "cardTypeId", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.entity = cardEntity
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: kAppDelegate.managedObjectContext, sectionNameKeyPath: nil , cacheName: nil)
        frc.delegate = self
        return frc as! NSFetchedResultsController<ACCardEntity>
    }
    
    //To fetch the objects from the core data
    func performFetch() {
        fetchedResultController = initializeFetchResultController()
        do {
            try self.fetchedResultController.performFetch()
        } catch {
            print("An error occurred")
        }
    }
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            chatViewBottomConstraint.constant = 0
        } else {
            chatViewBottomConstraint.constant = keyboardViewEndFrame.height
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK:- Table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: welcomeCellIdentifier) as! ACWelcomeTableViewCell
            cell.welcomeCard = fetchedResultController.object(at: indexPath).welcomeCard
            cell.updateCell()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: promotionCellIdentifier) as! ACPromotionTableViewCell
            cell.promotionCard = fetchedResultController.object(at: indexPath).promotionCard
            cell.updateCell()
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier) as! ACUserCardTableViewCell
            cell.userCard = fetchedResultController.object(at: indexPath).userCard
            cell.updateCell()
            return cell
        }
        return UITableViewCell()
    }
    
    
    // MARK: Fetched Results Controller Delegate Methods
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
