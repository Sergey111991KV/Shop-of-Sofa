//
//  ImageDetailViewController.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 17/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var pageDetail: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension ImageDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pagesWidth = scrollView.bounds.width
        pageDetail.currentPage = Int(scrollView.contentOffset.x / pagesWidth )
    }
}
