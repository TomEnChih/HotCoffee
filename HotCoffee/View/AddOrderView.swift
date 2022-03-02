//
//  AddOrderView.swift
//  HotCoffee
//
//  Created by 董恩志 on 2022/2/26.
//

import UIKit
import SnapKit

class AddOrderView: UIView {

    // MARK: - Properties
    var coffeeSize: CoffeeSize! {
        didSet {
            smallBtn.isSelected = (coffeeSize.tag == smallBtn.tag)
            mediumBtn.isSelected = (coffeeSize.tag == mediumBtn.tag)
            LargeBtn.isSelected = (coffeeSize.tag == LargeBtn.tag)
        }
    }
    
    // MARK: - UIElements
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    //MARK: - btnStackView
    lazy var smallBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Small", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.systemBlue, for: .selected)
        btn.tag = 1
        btn.addTarget(self, action: #selector(chooseSize), for: .touchUpInside)
        return btn
    }()
    
    lazy var mediumBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Medium", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.systemBlue, for: .selected)
        btn.tag = 2
        btn.addTarget(self, action: #selector(chooseSize), for: .touchUpInside)
        return btn
    }()
    
    lazy var LargeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Large", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.systemBlue, for: .selected)
        btn.tag = 3
        btn.addTarget(self, action: #selector(chooseSize), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [smallBtn,mediumBtn,LargeBtn])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 5
        sv.layer.cornerRadius = 5
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor.lightGray.cgColor
        return sv
    }()
    
    //MARK: - textFieldStackView
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        return tf
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameTextField,emailTextField])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()

    
    // MARK: - Autolayout
    private func setConstraints() {
        addSubview(tableView)
        addSubview(btnStackView)
        addSubview(textFieldStackView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        
        btnStackView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.7)
        }
        
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(btnStackView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
        
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setConstraints()
        
        #warning("必須放在主線程，不然會在 setConstraints 之前就呼叫結束，原理不太清楚？")
        DispatchQueue.main.async {
            self.coffeeSize = .small
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func chooseSize(_ sender: UIButton) {
        
        if sender == smallBtn {
            print("small")
            coffeeSize = .small
            
        } else if sender == mediumBtn {
            print("medium")
            coffeeSize = .medium
            
        } else if sender == LargeBtn {
            print("large")
            coffeeSize = .large
        }
    }

}

