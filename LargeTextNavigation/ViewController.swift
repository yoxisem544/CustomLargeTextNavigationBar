//
//  ViewController.swift
//  LargeTextNavigation
//
//  Created by David on 2018/5/30.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var baseScrollView: UIScrollView!
  var baseLabel: UILabel!

  var ya: LargeTextNavigationBar!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    configure()
  }

  private func configure() {
    baseScrollView = UIScrollView(frame: view.bounds)
    view.addSubview(baseScrollView)

    baseScrollView.contentSize.height = view.bounds.height * 4
    baseScrollView.contentSize.width = view.bounds.width

    baseScrollView.backgroundColor = .gray

    baseScrollView.delegate = self
    baseScrollView.contentInsetAdjustmentBehavior = .never

    ya = LargeTextNavigationBar()
    view.addSubview(ya)

//    baseScrollView.contentInset.top = ya.currentHeight

    baseLabel = UILabel(frame: CGRect(x: 0,
                                      y: 0,
                                      width: view.bounds.width,
                                      height: 17))
    baseLabel.frame.origin.y = ya.currentHeight
    baseLabel.textColor = .black
    baseLabel.text = "brew install librsvg"
    baseScrollView.addSubview(baseLabel)
  }


}

extension ViewController : UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset)
    ya.updateBar(with: scrollView.contentOffset)
  }

}
