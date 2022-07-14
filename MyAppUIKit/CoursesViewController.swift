//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by Ömer Faruk Kılıçaslan on 14.07.2022.
//

import UIKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String])-> Void)
}

struct Course {
    let name: String
}

public class CoursesViewController: UIViewController {
    
    private let tableView: UITableView = {
       
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
        
    }()
    
    
    let dataFetchable:DataFetchable

    public init(dataFetchable: DataFetchable){
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var courses: [Course] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseNames { [weak self] names in
            self?.courses = names.map { Course(name: $0) }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
        
    }
}
