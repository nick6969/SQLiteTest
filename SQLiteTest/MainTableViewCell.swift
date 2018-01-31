//
//  MainTableViewCell.swift
//  SQLiteTest
//
//  Created by Nick Lin on 2018/2/1.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {

    fileprivate lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "CheckActive")
        return imgView
    }()

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(imgView)
        titleLabel.mLay(pin: .init(top: 15, left: 20, bottom: 15))
        imgView.mLay(.left, .equal, titleLabel, .right, constant: 10)
        imgView.mLay(.centerY, .equal, contentView)
        imgView.mLay(.right, .equal, contentView, constant: -20)
        imgView.mLay(size: CGSize(width: 40, height: 40))
    }

    func setup(with dic: [String: Any]) {
        imgView.isHidden = !(dic[Todo.isDone] as? Bool ?? false)
        titleLabel.text = dic[Todo.title] as? String ?? String()
    }

}
