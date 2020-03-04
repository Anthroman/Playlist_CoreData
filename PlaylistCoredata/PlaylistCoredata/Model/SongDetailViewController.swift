//
//  SongDetailViewController.swift
//  PlaylistCoredata
//
//  Created by Anthroman on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songTableView: UITableView!
    
    //MARK: - Properties
    
    var playlist: Playlist?
 
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.delegate = self
        songTableView.dataSource = self
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let playlist = playlist, let artistName = artistNameTextField.text, let songTitle = songTitleTextField.text else {return}
        
        SongController.createSong(with: artistName, and: songTitle, addTo: playlist)
        // Clean up the dust
        songTableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
    }
}

extension SongDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let playlist = playlist else {return 0}
        
        return playlist.songs?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songTableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let playlist = playlist else {return UITableViewCell()}
        if let song = playlist.songs?[indexPath.row] as? Song {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.artist
        }
        return cell
    }
}

extension SongDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist, let song = playlist.songs?[indexPath.row] as? Song else {return}
            
            SongController.deleteSong(song: song)
            songTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
