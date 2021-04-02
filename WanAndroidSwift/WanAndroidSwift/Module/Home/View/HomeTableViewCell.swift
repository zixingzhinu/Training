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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
            
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tagLabel.snp.right).offset(10)
            make.top.equalTo(tagLabel).offset(0)
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
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.textColor = UIColor.systemRed
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
                authorLabel.snp.updateConstraints { (make) in
                    make.left.equalTo(tagLabel.snp.right).offset(5)
                }
            }
            else {
                tagLabel.text = ""
                tagLabel.isHidden = true
                authorLabel.snp.updateConstraints { (make) in
                    make.left.equalTo(tagLabel.snp.right).offset(0)
                }
            }
            authorLabel.text = homeTopArticleModel.author
            chapterLabel.text = homeTopArticleModel.superChapterName + "·" + homeTopArticleModel.chapterName
            timeLabel.text = homeTopArticleModel.niceDate
        }
    }
    
}
