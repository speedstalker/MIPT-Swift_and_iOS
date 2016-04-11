//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Роман Ануфриев on 11.04.16.
//  Copyright © 2016 Роман Ануфриев. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ImageDownloaderDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var URLLink: UITextField!
    
    let imageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageDownloader.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downloadButtonPressed(sender: UIButton) {
        guard let link = URLLink.text else { return }
        imageDownloader.downloadImageFromString(link)
    }
    
    func showImage(sender: ImageDownloader, image: UIImage) {
        imageView.image = image
    }
}

