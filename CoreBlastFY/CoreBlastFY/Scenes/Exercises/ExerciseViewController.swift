//
//  ExerciseViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/19/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import AVKit

protocol ExerciseDisplayLogic: class {
    func displayExercises(viewModel: Exercises.Videos.ViewModel)
}

class ExerciseViewController: UIViewController, ExerciseDisplayLogic
{
    var interactor: ExerciseBusinessLogic?
    var exerciseVM: [Exercises.Videos.ViewModel.ExerciseVM] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ExerciseInteractor()
        let presenter = ExercisePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getExercises()
        setUpTableView()
    }
    
    // MARK: Do something
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private func setUpTableView() {
        view.backgroundColor = .black
        navigationItem.title = "Exercises Available for Current Level"
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Videos")
    }
    
    func getExercises() {
        let request = Exercises.Videos.Request()
        interactor?.getExercises(request: request)
    }
    
    func displayExercises(viewModel: Exercises.Videos.ViewModel) {
        exerciseVM = viewModel.exerciseViewModel
        tableView.reloadData()
    }
}

extension ExerciseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = exerciseVM[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Videos", for: indexPath) as UITableViewCell
        cell.textLabel?.text = exercise.name.uppercased()
        cell.textLabel?.font = UIFont.makeAvenirNext(size: 18)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
         cell.tintColor = .white
        let image = #imageLiteral(resourceName: "forward").withRenderingMode(.alwaysTemplate)
        let forwardImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        forwardImageView.image = image
        cell.accessoryView = forwardImageView
        cell.selectionStyle = .none
        return cell
    }
    
    
    
}
extension ExerciseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = exerciseVM[indexPath.row].url
        let avPlayerVC = AVPlayerViewController()
        avPlayerVC.videoGravity = .resizeAspectFill
        avPlayerVC.player = AVPlayer(url: url)
        avPlayerVC.player?.isMuted = true
        present(avPlayerVC, animated: true) {
            avPlayerVC.player?.play()
        }
    }
}