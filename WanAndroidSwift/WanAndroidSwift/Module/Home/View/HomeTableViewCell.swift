//
//  HomeTableViewCell.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/29.
//  首页cell

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    // MARK: - Initialization and deinitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
//        contentView.backgroundColor = UIColor.systemPink
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(chapterLabel)
        layout()
    }
    
    private func layout() {
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
//            make.width.equalTo(80)
//            make.height.equalTo(25)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tagLabel.snp.right).offset(10)
            make.centerY.equalTo(tagLabel).offset(0)
        }
        chapterLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel).offset(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel).offset(0)
            make.top.equalTo(authorLabel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        tagLabel.sizeToFit()
//        tagLabel.frame.size.width += 10
//        printDebug("1距离是：\(tagLabel.frame)")
//        printDebug("2距离是：\(tagLabel.frame.inset(by: UIEdgeInsets(top: 10, left: -10, bottom: 5, right: -5)))")
//        printDebug("3距离是：\(tagLabel.frame.insetBy(dx: 10, dy: -10))")
    }
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tagLabel: MyUILabel = {
        let label = MyUILabel()
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.textColor = UIColor.systemRed
        label.textAlignment = .center
        label.textInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var chapterLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    // MARK: - Public properties
    var homeTopArticleModel: HomeTopArticleModel! {
        didSet {
            titleLabel.text = homeTopArticleModel.title
//            tagLabel.isHidden = homeTopArticleModel.tags.count < 0
            tagLabel.text = homeTopArticleModel.tags.count > 0 ? homeTopArticleModel.tags[0].name : ""
            if homeTopArticleModel.tags.count > 0 {
                tagLabel.text = homeTopArticleModel.tags[0].name
                tagLabel.isHidden = false
                authorLabel.snp.remakeConstraints { (make) in
                    make.left.equalTo(tagLabel.snp.right).offset(5)
                    make.centerY.equalTo(tagLabel).offset(0)
                }
            }
            else {
                tagLabel.text = ""
                tagLabel.isHidden = true
                authorLabel.snp.remakeConstraints { (make) in
                    make.left.equalTo(titleLabel).offset(0)
                    make.top.equalToSuperview().offset(10)
                }
            }
            authorLabel.text = homeTopArticleModel.author.count > 0 ? homeTopArticleModel.author : homeTopArticleModel.shareUser
            chapterLabel.text = homeTopArticleModel.superChapterName + "·" + homeTopArticleModel.chapterName
            timeLabel.text = homeTopArticleModel.niceDate
        }
    }
    
}
