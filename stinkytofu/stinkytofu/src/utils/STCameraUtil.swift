//
//  STCameraUtil.swift
//  stinkytofu
//
//  Created by wil on 2014-12-24.
//  Copyright (c) 2014 Mountain Special. All rights reserved.
//

import UIKit
import MobileCoreServices

class STCameraUtil {
    // TODO: handle camera setup n' stuff
    // gotta check if camera is on device and is allow y'know
    
    class func isCameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    class func isAlbumAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) ||
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    class func loadCamera(viewcontroller: UIViewController, delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) {
        if (!isCameraAvailable())
        {
            return
        }
        
        let cameraVC = UIImagePickerController()
        cameraVC.sourceType = UIImagePickerControllerSourceType.Camera
        cameraVC.mediaTypes = [kUTTypeImage]
        cameraVC.allowsEditing = true
        cameraVC.delegate = delegate
        
        viewcontroller.presentViewController(cameraVC, animated: true, nil)
    }
    
    class func loadAlbum(viewcontroller: UIViewController, delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) {
        var albumVC: UIImagePickerController!
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum))
        {
            albumVC = UIImagePickerController()
            albumVC.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        else if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
        {
            albumVC = UIImagePickerController()
            albumVC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        albumVC.delegate = delegate
        
        viewcontroller.presentViewController(albumVC, animated: true, nil)
    }
}