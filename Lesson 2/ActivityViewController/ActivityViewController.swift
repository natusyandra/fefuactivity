//
//  TableViewCell.swift
//  fefuactivity
//
//  Created by Котик on 11.05.2022.
//

import UIKit
import CoreData


struct Section {
    let data: [ActivityEntity]
    let title: String
}

class ActivityViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self,
                           forCellReuseIdentifier: "identifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let emptyState: EmptyState = {
        let emptyState = EmptyState()
        return emptyState
    }()
    
    private let startButton: MyButton = {
        let button = MyButton()
        button.setTitle("Старт", for: .normal)
        return button
    }()
    
    //MARK: - Sections/Data
    
    public var dataSourse: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        layoutConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        startButton.addTarget(self, action: #selector(openMapView), for: .touchUpInside)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        
//        deleteAllCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        getFromCoreData()
        openEmptyState()
    }
    
    func openEmptyState() {
        
        if dataSourse.isEmpty {
            tableView.isHidden = true
            emptyState.isHidden = false
            
        } else {
            tableView.isHidden = false
            emptyState.isHidden = true
        }
    }
    
    func getFromCoreData() {
        let fechRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        let context = FEFUCoreDataContainer.instance.context
        
        do {
            let activities = try context.fetch(fechRequest)
            dataSourse = mappingList(activities)
            tableView.reloadData()
            
        } catch {
            print("ERROR")
        }
    }
    
    func deleteAllCoreData() {
        let fechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fechRequest)
        let context = FEFUCoreDataContainer.instance.context
        do {
            try context.execute(deleteRequest)
            try context.save()
            tableView.reloadData()
            
        } catch {
            print("ERROR")
        }
    }
    
    func addSubviews() {
        view.addSubview(startButton)
        view.addSubview(tableView)
        view.addSubview(emptyState)
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            
            emptyState.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            emptyState.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -38),
            emptyState.topAnchor.constraint(equalTo: view.topAnchor, constant: 360),
            emptyState.heightAnchor.constraint(equalToConstant: 91),
            emptyState.widthAnchor.constraint(equalToConstant: 297)
        ])
    }
    
    @objc func openMapView() {
        navigationController?.pushViewController(CreateActivityViewController(), animated: true)
    }
        
    func mappingList(_ list: [ActivityEntity]) -> [Section] {
        let dictionary = Dictionary(grouping: list, by: {
            convertDateToString(date: $0.finishTime ?? Date(), format:"yyyyMMdd")
        })
        let activities = dictionary
            .sorted(by: {$0.key > $1.key})
            .compactMap({
                Section(
                    data: $0.value,
                    title: getCurrentDay($0.key)
                )
            })
        
        return activities
    }
    
    func convertDateToString(date: Date,format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getCurrentDay(_ value: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ru_RU")
        guard let date = formatter.date(from: value) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}

//MARK: - TableView

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! FormTableViewCell
        cell.setupData(dataSourse[indexPath.section].data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSourse[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let vc = ActivityDeteilsViewController()
        vc.setupData(dataSourse[indexPath.section].data[indexPath.row])
        vc.title = dataSourse[indexPath.section].data[indexPath.row].type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: -10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.backgroundColor = .secondarySystemBackground
        label.text = dataSourse[section].title
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
}
    
 

