//ok 20 giugno 18
//  ViewController.swift
//  SJSegmentedScrollView
//
//  Created by Subins Jose on 06/10/2016.
//  Copyright © 2016 Subins Jose. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class SegmentedViewController: SJSegmentedViewController {

	var selectedSegment: SJSegmentTab?

	override func viewDidLoad() {
		if let storyboard = self.storyboard {



			let firstViewController = storyboard
				.instantiateViewController(withIdentifier: "Firstcontroller")
			firstViewController.title = "My Activities"

            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "SecondViewController")
            secondViewController.title = "Others"


            
			segmentControllers = [firstViewController,
                                  secondViewController]
            
//            headerViewHeight = 0
			selectedSegmentViewHeight = 3.0
			headerViewOffsetHeight = 31.0
			segmentTitleColor = .gray
          
           
            segmentViewHeight = 50.0
            
			selectedSegmentViewColor = UIColor(red: 51.0/255.0, green: 120.0/255.0, blue: 244.0/255.0, alpha: 1)
			segmentShadow = SJShadow.light()
			showsHorizontalScrollIndicator = false
			showsVerticalScrollIndicator = false
			segmentBounces = false
			delegate = self
		}

		
		super.viewDidLoad()
	}

	func getSegmentTabWithImage(_ imageName: String) -> UIView {

		let view = UIImageView()
		view.frame.size.width = 100
		view.image = UIImage(named: imageName)
		view.contentMode = .scaleAspectFit
		view.backgroundColor = .white
		return view
	}
}

extension SegmentedViewController: SJSegmentedViewControllerDelegate {

	func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {

		if selectedSegment != nil {
			selectedSegment?.titleColor(.lightGray)
		}

		if segments.count > 0 {

			selectedSegment = segments[index]
			selectedSegment?.titleColor(UIColor(red: 51.0/255.0, green: 120.0/255.0, blue: 244.0/255.0, alpha: 1))
		}
	}
}

