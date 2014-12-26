//
//  STHomeViewController.swift
//  stinkytofu
//
//  Created by wil on 2014-12-23.
//  Copyright (c) 2014 Mountain Special. All rights reserved.
//

import UIKit

let reuseIdentifierMenuItem = "CellMenuItem"

class STHomeViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            return 2
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //if (indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierMenuItem, forIndexPath: indexPath) as STHomeMenuItemCell
            // Configure the cell
            switch indexPath.row {
            case 0:
                cell.label.text = NSLocalizedString("home take_photo", tableName: nil, bundle: NSBundle.mainBundle(), value: "Take Photo", comment: "home menu option")
            case 1:
                cell.label.text = NSLocalizedString("home load_picture", tableName: nil, bundle: NSBundle.mainBundle(), value: "Load Picture", comment: "home menu option")
            default:
                // TODO: what i really want here is the display name
                cell.label.text = NSBundle.mainBundle().infoDictionary!.description
//                localizedInfoDictionary.objectForKey("CFBundleDisplayName")

            }
        //} // section 0
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.row {
        case 0:
            if (STCameraUtil.isCameraAvailable())
            {
                STCameraUtil.loadCamera(self)
                return true
            }
        case 1:
            if (STCameraUtil.isAlbumAvailable())
            {
                STCameraUtil.loadAlbum(self)
                return true
            }
        default:
            break
        }
        return false
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
