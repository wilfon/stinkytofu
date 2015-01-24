//
//  STWheelMock2dViewController.swift
//  stinkytofu
//
//  Created by wil on 2014-12-26.
//  Copyright (c) 2014 Mountain Special. All rights reserved.
//

import UIKit

class STWheelMock2dViewController: UIViewController {

    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override init() {
        super.init(nibName: "STWheelMock2dViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "STWheelMock2dViewController", bundle: NSBundle.mainBundle())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let lImageView = imageView
        {
            if let setImage = image
            {
                lImageView.image = image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
