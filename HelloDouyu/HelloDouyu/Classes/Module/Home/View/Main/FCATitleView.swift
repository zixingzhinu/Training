//
//  FCATitleView.swift
//  HelloDouyu
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

protocol FCATitleViewDelegate: class {
    func titleView(_ titleView: FCATitleView, selectedIndex: Int)
}

class FCATitleView: UIView {

    private let titles: [String]
    private let pageConfig: FCAPageConfig
    private var previousLabel: UILabel!
    weak var delegate: FCATitleViewDelegate?
    fileprivate var preSelectedPage: CGFloat?
    fileprivate var recordProgress: CGFloat = 0    //记录的进度
    
    // MARK:- lazy
    lazy var horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    // MARK:- lifeCycle
    init(frame: CGRect, titles: [String], pageConfig: FCAPageConfig) {
        self.titles = titles
        self.pageConfig = pageConfig
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("we have not implements this init function")
    }
    
    // MARK:- private
    private func setupSubviews() {
        addSubview(horizontalScrollView)
        setupScrollViewSubviews()
        layoutScrollViewSubviews()
    }
    
    /// 初始化
    private func setupScrollViewSubviews() {
        for (i, title) in titles.enumerated() {
            let label = UILabel()
            label.tag = i
            label.textColor = i == 0 ? pageConfig.titleColorSelected : pageConfig.titleColorNormally
            label.font = UIFont.systemFont(ofSize: pageConfig.titleFontSelected)
            label.text = title
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            horizontalScrollView.addSubview(label)
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelDidClick(tap:)))
            label.addGestureRecognizer(tap)
            if i == 0 {
                previousLabel = label
            }
            else {
                let fontOffset = pageConfig.titleFontNormally / pageConfig.titleFontSelected
                label.transform = CGAffineTransform.identity.scaledBy(x: fontOffset, y: fontOffset)
            }
        }
    }
    
    /// 布局ScrollView的子控件
    private func layoutScrollViewSubviews() {
        var left: CGFloat = pageConfig.titleLeftMargin
        let top: CGFloat = 0
        var width: CGFloat = 0
        let height: CGFloat = bounds.height
        let subViewArray = horizontalScrollView.subviews
        for (i, subView) in subViewArray.enumerated() {
            if !(subView is UILabel) {
                continue
            }
            let label = subView as! UILabel
            if pageConfig.isHorizontalScrollEnabled {
                guard let text = label.text else {
                    return
                }
                let textWidth = getNormalStrW(str: text, strFont: pageConfig.titleFontSelected, h: bounds.height)
                width = textWidth + pageConfig.titleTextPadding
                if i > 0 {
                    let previousLabel = subViewArray[i - 1]
                    left += (previousLabel.frame.width + pageConfig.titleItemSpacing)
                }
            }
            else {
                width = (bounds.width - pageConfig.titleLeftMargin - pageConfig.titleRightMargin) / CGFloat(subViewArray.count)
                left = CGFloat(i) * width + pageConfig.titleLeftMargin
            }
            label.frame = CGRect(x: left, y: top, width: width, height: height)
        }
        horizontalScrollView.contentSize = pageConfig.isHorizontalScrollEnabled ? CGSize(width: subViewArray.last!.frame.maxX + pageConfig.titleRightMargin, height: 0) : CGSize.zero
    }
    
    // MARK:- Action
    @objc func titleLabelDidClick(tap: UITapGestureRecognizer) {
        print("点击了:\(tap)")
        print("target:\(tap.view!)")
        let label = tap.view as! UILabel
        previousLabel.textColor = pageConfig.titleColorNormally
        previousLabel.font = UIFont.systemFont(ofSize: pageConfig.titleFontNormally)
        label.textColor = pageConfig.titleColorSelected
        label.font = UIFont.systemFont(ofSize: pageConfig.titleFontSelected)
        previousLabel = label
        titleScrollOffsetX(label: label)
        // 设置代理，通知ContentView进行滚动
        delegate?.titleView(self, selectedIndex: label.tag)
        
    }
    
    fileprivate func titleScrollOffsetX(label: UILabel) {
        var offsetX = label.center.x - bounds.width / 2
        let rightAnchor = horizontalScrollView.contentSize.width - label.center.x
        if offsetX > 0 && rightAnchor >= bounds.width / 2 {
            // 此时offsetX的值就是上边计算出的偏移量，不用赋值
        }
        else if offsetX < 0 {
            offsetX = 0
        }
        else if rightAnchor < bounds.width / 2 {
            offsetX = horizontalScrollView.contentSize.width - bounds.width
        }
        horizontalScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension FCATitleView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView's offset: \(scrollView.contentOffset)")
    }
}

extension FCATitleView: FCAContentViewDelegate {
    
    func contentView(_ contentView: FCAContentView, selectedPage: CGFloat, progress: CGFloat) {
        let preIndex = Int(selectedPage.rounded(.down))
        let tarIndex = Int(selectedPage.rounded(.up))
        if preIndex == tarIndex || progress == 0 {
            return
        }
//        let progress1 = selectedPage - CGFloat(preIndex)
        print("preIndex: \(preIndex), tarIndex: \(tarIndex), progress: \(progress)")
        let subViewArray = horizontalScrollView.subviews
        //        print("当前子类：\(subViewArray)")
        let preLabel = subViewArray[preIndex] as! UILabel
        let tarLabel = subViewArray[tarIndex] as! UILabel

        let normalColor = pageConfig.titleColorNormally.getRGBAValue()
        let selectColor = pageConfig.titleColorSelected.getRGBAValue()
        let redOffset = selectColor.red - normalColor.red
        let greenOffset = selectColor.green - normalColor.green
        let blueOffset = selectColor.blue - normalColor.blue
        
        let preColor = UIColor(red: selectColor.red - redOffset * progress, green: selectColor.green - greenOffset * progress, blue: selectColor.blue - blueOffset * progress, alpha: selectColor.alpha)
        let tarColor = UIColor(red: normalColor.red + redOffset * progress, green: normalColor.green + greenOffset * progress, blue: normalColor.blue + blueOffset * progress, alpha: normalColor.alpha)
        
        // FIXME: 这个地方使用缩放动画更好，不应该直接修改font
        let fontOffset = pageConfig.titleFontNormally / pageConfig.titleFontSelected
        let fontPreRate = fontOffset + (1 - fontOffset) * progress
        let fontTarRate = 1 - (1 - fontOffset) * progress
        print("fontOffset: \(fontOffset), fontPreRate: \(fontPreRate), fontTarRate: \(fontTarRate)")
        preLabel.transform = CGAffineTransform.identity.scaledBy(x: fontTarRate, y: fontTarRate)
        tarLabel.transform = CGAffineTransform.identity.scaledBy(x: fontPreRate, y: fontPreRate)
        preLabel.textColor = preColor
        tarLabel.textColor = tarColor
        if progress > recordProgress {
            //向右scroll
            titleScrollOffsetX(label: tarLabel)
        }
        else {
            // 向左scroll
            titleScrollOffsetX(label: preLabel)
        }
        recordProgress = progress
        
    }
    
}

extension FCATitleView {
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
        
    }
    
    func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }

    func getNormalStrW(str: String, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }

    func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }

    func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }

}
