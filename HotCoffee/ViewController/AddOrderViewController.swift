//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by 董恩志 on 2022/2/26.
//

import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
}

class AddOrderViewController: UIViewController {
    
    // MARK: - Properties
    private let addOrderView = AddOrderView()
    
    private var vm = AddCoffeeOrderViewModel()
    
    var delegate: AddCoffeeOrderDelegate?
    
    // MARK: - UIElements
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Methods
    private func setup() {
        view = addOrderView
        self.navigationItem.title = "Add New Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        
        addOrderView.tableView.dataSource = self
        addOrderView.tableView.delegate = self
    }
    
    @objc func handleSave() {
        let name = self.addOrderView.nameTextField.text
        let email = self.addOrderView.emailTextField.text
        
        guard let indexPath = self.addOrderView.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee")
        }
        
        self.vm.name = name
        self.vm.email = email
        
        self.vm.selectedSize = self.addOrderView.coffeeSize.rawValue.capitalized
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        Webservice().load(resource: Order.create(vm: self.vm)) { result in
            
            switch result {
            case .success(let order):
                
                if let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - AddOrderViewController
extension AddOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
