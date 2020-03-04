//
//  PlaylistViewController.swift
//  PlaylistCoredata
//
//  Created by Anthroman on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var playlistNameTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
   
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let playlistName = playlistNameTextField.text else {return}
        PlaylistController.sharedInstance.createPlaylist(with: playlistName)
        playlistTableView.reloadData()
        
        playlistNameTextField.text = ""
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? SongDetailViewController else {return}
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            destinationVC.playlist = playlist
        }
    }
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PlaylistController.sharedInstance.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for : indexPath)
        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
        
        let songCount = playlist.songs?.count ?? 0
        
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "Songs: \(songCount)"
        
        return cell
    }
}

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            PlaylistController.sharedInstance.deletePlaylist(playlist: playlist)
            playlistTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
