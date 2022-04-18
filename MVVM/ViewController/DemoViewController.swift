//
//  ViewController.swift
//  MVVM
//
//  Created by Aneri Parikh on 14/04/22.
//

import UIKit

class DemoViewController: UIViewController {

    var demoVM: DemoViewModelProtocol?
    var service: ServiceLayer?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        demoVM = DemoViewModel(service: Service())
        tableView.dataSource = self
        tableView.delegate = self
        demoVM?.fetchData()
        demoVM?.demoDataFetched = { [weak self] in
             DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension DemoViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoVM?.demo?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as? DemoViewCellTableViewCell {
            cell.imageView?.downloaded(from: demoVM?.demo?.data[indexPath.row].profileImage ?? "")
            cell.titleLabel.text = demoVM?.demo?.data[indexPath.row].employeeName
            cell.desc.text = "\(demoVM?.demo?.data[indexPath.row].employeeSalary ?? 0)"

            return cell
        }
        return UITableViewCell()
    }
}

extension DemoViewController {
    var testHook: TestHooks {
        return TestHooks(target: self)
    }

    struct TestHooks {
        private let target: DemoViewController

        fileprivate init(target: DemoViewController) {
            self.target = target
        }

        var demoVM: DemoViewModelProtocol? {
            target.demoVM
        }

        var service: ServiceLayer? {
            target.service
        }

        var tableView: UITableView {
            target.tableView
        }
    }

}
