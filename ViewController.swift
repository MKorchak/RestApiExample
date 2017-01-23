//
//  ViewController.swift
//  RestApiExample
//
//  Created by Misha Korchak on 20.12.16.
//  Copyright © 2016 Misha Korchak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var posterImage: UIImageView!
    var myImage: UIImage?
    var myTitle: String?
    
    override func viewDidLoad() {
        self.title = myTitle
        posterImage.image = myImage
        
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        var zoom: UIScrollView = UIScrollView()
        
        zoom.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        zoom.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        zoom.delegate = self
        zoom.alwaysBounceVertical = false
        zoom.alwaysBounceHorizontal = false
        zoom.showsVerticalScrollIndicator = true
        zoom.flashScrollIndicators()
        zoom.minimumZoomScale = 1.0
        zoom.maximumZoomScale = 10.0
        
        self.view.addSubview(zoom)
        posterImage!.layer.cornerRadius = 11.0
        posterImage!.clipsToBounds = false
        zoom.addSubview(posterImage)
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return posterImage
    }


}

