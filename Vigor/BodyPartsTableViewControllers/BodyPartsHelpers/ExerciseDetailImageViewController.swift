//
//  ExerciseDetailImageViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/26/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var currentImageDetail = UIImage()

class ExerciseDetailImageViewController: UIViewController, UIScrollViewDelegate {

    // outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    let image = currentImageDetail

    override func viewDidLoad() {
        super.viewDidLoad()

        // scroller
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0

        // image
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        // double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {

        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(4.0, animated: true)
        }
    }

}
