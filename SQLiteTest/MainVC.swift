//
//  MainVC.swift
//  SQLiteTest
//
//  Created by Nick Lin on 2018/1/31.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {

    // Data
    var models: [[String: Any]] = []

    // UI
    let tableView = UITableView()
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        title = "TODO List Test"
        edgesForExtendedLayout = .init(rawValue: 0)
        view.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)

        view.addSubview(textField)
        view.addSubview(submitButton)
        view.addSubview(tableView)

        textField.mLay(pin: .init(top: 8, left: 20))
        textField.mLay(.height, 50)
        submitButton.mLay(.left, .equal, textField, .right, constant: 10)
        submitButton.mLay(.height, 50)
        submitButton.mLay(pin: .init(top: 8, right: 20))
        submitButton.mLay(.width, 50)
        tableView.mLay(.top, .equal, textField, .bottom, constant: 8)
        tableView.mLay(pin: .init(left: 0, bottom: 0, right: 0))

        tableView.registerCell(type: MainTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self

        loadData()
    }

    @objc func submitAction(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else { return }
        var data: [String: Any] = [:]
        data[Todo.title] = text
        data[Todo.createTime] = Int(Date().timeIntervalSince1970)
        data[Todo.isDone] = false
        DBM.instert(table: Todo.tableName, data: data)
        textField.text = nil
        textField.resignFirstResponder()
        loadData()
    }

    func loadData() {
        let query =
            " SELECT "         + " * "
                + " FROM "     + " \(Todo.tableName) "
                + " ORDER BY " + " \(Todo.createTime) " + " DESC "
        models = DBM.loadMatch(allmatch: query, value: [])
        tableView.reloadData()
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MainTableViewCell.self)
        cell.setup(with: models[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        var model = models[indexPath.row]
        if let bool = model[Todo.isDone] as? Bool {
            model[Todo.isDone] = !bool
        }
        models[indexPath.row] = model
        DBM.update(table: Todo.tableName, data: model)
        cell.setup(with: model)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction: UITableViewRowAction = .init(style: .default, title: "刪除") { [weak self] _, index in
            guard let `self` = self else { return }
            let model = self.models[index.row]
            DBM.delete(table: Todo.tableName, data: model)
            self.models.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return [deleteAction]
    }
}
