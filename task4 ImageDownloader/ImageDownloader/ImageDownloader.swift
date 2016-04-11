//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Роман Ануфриев on 11.04.16.
//  Copyright © 2016 Роман Ануфриев. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    weak var delegate: ImageDownloaderDelegate?
    
    func downloadImageFromString(string: String) {
        guard let URLFromString = NSURL(string: string) else { return }
        guard let dataFromURL = NSData(contentsOfURL: URLFromString) else { return }
        guard let image = UIImage(data: dataFromURL) else { return }
        
        self.delegate?.showImage(self, image: image)
    }
}

protocol ImageDownloaderDelegate: NSObjectProtocol {
    func showImage(sender: ImageDownloader, image: UIImage)
}