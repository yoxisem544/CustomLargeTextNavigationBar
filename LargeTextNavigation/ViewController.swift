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
    // 這樣設定可以讓 inset = 0
    baseScrollView.contentInsetAdjustmentBehavior = .never

    ya = LargeTextNavigationBar()
    view.addSubview(ya)

    baseScrollView.contentInset.top = ya.maxHeight
    baseScrollView.contentOffset.y = -ya.maxHeight

    baseLabel = UILabel(frame: CGRect(x: 0,
                                      y: 0,
                                      width: view.bounds.width,
                                      height: 17))

    // 而內容開始的位置就在 bar 之下，也許之後可以設定 inset（但滑到底的值會變負的 比如 -88）
    // 但內容開始可以在 0，不過可能要調 offset 開始位置
    baseLabel.frame.origin.y = 0
    baseLabel.textColor = .black
    baseLabel.text = "brew install librsvg"
    baseScrollView.addSubview(baseLabel)
  }


}

extension ViewController : UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    print(scrollView.contentOffset)
    ya.updateBar(with: scrollView)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      // do something to hide/show bar
      ya.endDraggingWithoutDecelerate(scrollView)
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

  }

}
