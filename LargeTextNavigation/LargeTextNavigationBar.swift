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

  private var floatingBarView: UIView!
  private var floatingBarTitleLabel: UILabel!

  public var currentHeight: CGFloat {
    return staticBarView.bounds.height
  }

  /// Extra nav bar height is used for large text extra height
  ///
  /// iPhone X:
  ///  - standard height 88pt
  ///  - large text height 140pt
  ///
  /// Other iPhone:
  ///  - standard height 64pt
  ///  - large text height 116pt
  ///
  /// (large - standard) is **52pt**
  private var extraNavBarHeight: CGFloat {
    return 52.0
  }

  /// This Nav Bar's max height
  public var maxHeight: CGFloat {
    return extraNavBarHeight + statusBarHeight + staticBarHeight
  }

  /// use for trigger animation for show and hide of static bar title label
  ///
  /// - positive for earier show
  ///
  /// - negative for delay show
  private var staticBarAnimatingOffsetDelta: CGFloat {
    return 7.0
  }



  // MARK: - Init
  public convenience init() {
    self.init(frame: CGRect.zero)

    configureStaticBarView()
    configureStaticBarTitleLabel()

    configureFloatingBarView()
    configureFloatingBarTitleLabel()
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

  private func configureFloatingBarView() {
    floatingBarView = UIView()
    floatingBarView.frame.size.width = staticBarView.bounds.width
    floatingBarView.frame.size.height = extraNavBarHeight

    // style
    floatingBarView.backgroundColor = .white

    floatingBarView.frame.origin.y = staticBarView.bounds.height
    insertSubview(floatingBarView, belowSubview: staticBarView)
  }

  private func configureFloatingBarTitleLabel() {
    let leftMargin: CGFloat = 20
    let fontSize: CGFloat = 34
    floatingBarTitleLabel = UILabel()
    floatingBarTitleLabel.frame.size.width = floatingBarView.bounds.width - 2 * leftMargin
    floatingBarTitleLabel.frame.size.height = fontSize

    // style
    floatingBarTitleLabel.textColor = .black
    floatingBarTitleLabel.text = "Setting"
    floatingBarTitleLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    floatingBarTitleLabel.sizeToFit()

    // position
    floatingBarTitleLabel.center.y = floatingBarView.bounds.height / 2
    floatingBarTitleLabel.frame.origin.x = leftMargin
    floatingBarView.addSubview(floatingBarTitleLabel)
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
  public func updateBar(with scrollView: UIScrollView) {
    if scrollView.contentOffset.y > (0 - scrollView.contentInset.top + extraNavBarHeight - staticBarAnimatingOffsetDelta) {
      // scrolling up for more content
      showStaticTitleLabel()
    } else {
      // scrolling down and reach top, no more content
      hideStaticTitleLabel()
    }
    moveFloatingBar(with: scrollView.contentOffset.y)
  }

  private func hideStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 0.0, animated: animated)
  }

  private func showStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 1.0, animated: animated)
  }

  private func animateStaticTitleLabel(alpha: CGFloat, animated: Bool) {
    UIView.animate(
      withDuration: 0.15,
      delay: 0,
      options: [],
      animations: {
        self.staticBarTitleLabel.alpha = alpha
      },
      completion: nil)
  }

  private func moveFloatingBar(with offsetY: CGFloat) {
    let barY = -(offsetY + maxHeight) // set offset to 0, for ease to deal with offset
    if barY >= 0 {
      // user pulling down
      floatingBarView.frame.origin.y = staticBarView.bounds.height
    } else {
      // user pushing up, floating bar goes up
      floatingBarView.frame.origin.y = barY + staticBarView.bounds.height
    }
  }

  public func endDraggingWithoutDecelerate(_ scrollView: UIScrollView) {
    let barY = -(scrollView.contentOffset.y + maxHeight)
    if barY < -(extraNavBarHeight / 2) {
      // push up, need to hide floating view
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
        scrollView.contentOffset.y = (self.extraNavBarHeight - scrollView.contentInset.top)
      }, completion: nil)
    } else {
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
        scrollView.contentOffset.y = -scrollView.contentInset.top
      }, completion: nil)
    }
  }

}
