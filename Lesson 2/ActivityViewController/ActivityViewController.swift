//
//  TableViewCell.swift
//  fefuactivity
//
//  Created by Котик on 11.05.2022.
//

import UIKit


struct Section {
    let data: [String]
    let title: String
}

class ActivityViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self,
                           forCellReuseIdentifier: "identifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
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
    private var dataSourse: [Section] = [
        Section(data: ["Один", "Два", "Три"], title: "Вчера"),
        Section(data: ["Чертыре", "Пять"], title: "Сегодня"),
        Section(data: ["Шесть", "Семь"], title: "Завтра")
    ]

    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        layoutConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        startButton.addTarget(self,
                              action: #selector(openMapView),
                              for: .touchUpInside)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
    
    @objc func openTableView() {
        emptyState.isHidden = true
        tableView.isHidden = false
    }
    
    @objc func openMapView() {
        navigationController?.pushViewController(CreateActivityViewController(), animated: true)
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
        vc.title = "Велосипед"
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

    
 

