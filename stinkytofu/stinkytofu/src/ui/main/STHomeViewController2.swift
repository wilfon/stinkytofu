//
//  STHomeViewController2.swift
//  stinkytofu
//
//  Created by wil on 2015-01-24.
//  Copyright (c) 2015 Mountain Special. All rights reserved.
//

import UIKit
import MobileCoreServices


class STHomeViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var headlineManager = STHomeHeadlineManager()
    
    @IBOutlet weak var tableView: UITableView!
    var tableHeaderView: UIView!
    
    let reuseIdentifierMenuItem = "HomeMenuCell"
    let reuseIdentifierHeaderView = "HomeMenuHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        headlineManager.scrollView = scrollView
        headlineManager.pageControl = pageControl
        scrollView.delegate = headlineManager
        
        let pageCount = headlineManager.colors.count
        pageControl.currentPage = 0;
        pageControl.numberOfPages = pageCount;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let pagesScrollViewSize = self.scrollView.frame.size;
        self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(headlineManager.colors.count), pagesScrollViewSize.height);
        
        // 5
        headlineManager.loadVisiblePages();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierMenuItem, forIndexPath: indexPath) as STHomeMenuItem2

        // Configure the cell...
        switch indexPath.row
        {
        case 0:
            cell.label.text = NSLocalizedString("capture_vehicle", tableName: nil, bundle: NSBundle.mainBundle(), value: "Capture Vehicle", comment: "home menu option")
        case 1:
            cell.label.text = NSLocalizedString("load_image", tableName: nil, bundle: NSBundle.mainBundle(), value: "Load Image", comment: "home menu option")
        case 2:
            cell.label.text = NSLocalizedString("vehicle_list", tableName: nil, bundle: NSBundle.mainBundle(), value: "Vehicle List", comment: "home menu option")
        case 3:
            cell.label.text = NSLocalizedString("aftermarket_list", tableName: nil, bundle: NSBundle.mainBundle(), value: "Aftermarket List", comment: "home menu option")
        default:
            // TODO: what i really want here is the display name
            cell.label.text = NSBundle.mainBundle().infoDictionary!.description
//                localizedInfoDictionary.objectForKey("CFBundleDisplayName")
        }
        return cell
    }

//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(reuseIdentifierHeaderView) as UIView
//        return headerView
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            if STCameraUtil.isCameraAvailable()
            {
                STCameraUtil.loadCamera(self, delegate: self)
            }
        case 1:
            if STCameraUtil.isAlbumAvailable()
            {
                STCameraUtil.loadAlbum(self, delegate: self)
            }
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        // TODO: make sure we have image only
        var mediaType = info[UIImagePickerControllerMediaType] as String
        if (mediaType != kUTTypeImage) { return }
        
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil
        {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        if let notNilImage = image
        {
            var mockVC = STWheelMock2dViewController()
            mockVC.image = notNilImage
            self.navigationController?.pushViewController(mockVC, animated: true)
        }
        else
        {
            var alertView = UIAlertView(title: "Invalid Image", message: "", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
