//
//  LargeTextNavigationBar.swift
//  LargeTextNavigation
//
//  Created by David on 2018/5/30.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class LargeTextNavigationBar: UIView {

  /// determine status bar's height wether its iPhone X or other device
  ///
  /// iPhone X's status bar height is 44.
  /// Other devices' are 20
  private var statusBarHeight: CGFloat {
    return UIDevice.type == .iPhoneX ? 44 : 20
  }

  /// static bar's height
  let staticBarHeight: CGFloat = 44.0

  private var staticBarView: UIView!
  private var staticBarTitleLabel: UILabel!

  public var currentHeight: CGFloat {
    return staticBarView.bounds.height
  }

  // MARK: - Init
  public convenience init() {
    self.init(frame: CGRect.zero)

    configureStaticBarView()
    configureStaticBarTitleLabel()
  }

  private func configureStaticBarView() {
    staticBarView = UIView()
    staticBarView.frame.size.width = UIScreen.main.bounds.width
    staticBarView.frame.size.height = staticBarHeight + statusBarHeight

    // style
    staticBarView.backgroundColor = .white

    addSubview(staticBarView)
  }

  private func configureStaticBarTitleLabel() {
    let fontSize: CGFloat = 18
    staticBarTitleLabel = UILabel()
    staticBarTitleLabel.frame.size.height = fontSize
    staticBarTitleLabel.frame.size.width = staticBarView.bounds.width

    // style
    staticBarTitleLabel.textColor = .black
    staticBarTitleLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    staticBarTitleLabel.textAlignment = .center
    staticBarTitleLabel.text = "Yahoo"

    staticBarTitleLabel.center.y = statusBarHeight + staticBarHeight / 2
    staticBarView.addSubview(staticBarTitleLabel)
  }

  private override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// adjust view's arrangement with content offset
  ///
  /// - Parameter offset: scroll view's content offset
  public func updateBar(with offset: CGPoint) {
    if offset.y > 0 { // scrolling up for more content
      hideStaticTitleLabel()
    } else { // scrolling down and reach top, no more content
      showStaticTitleLabel()
    }
  }

  private func hideStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 0.0, animated: animated)
  }

  private func showStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 1.0, animated: animated)
  }

  private func animateStaticTitleLabel(alpha: CGFloat, animated: Bool) {
    UIView.animate(
      withDuration: 0.2,
      delay: 0,
      options: [],
      animations: {
        self.staticBarTitleLabel.alpha = alpha
      },
      completion: nil)
  }

}
