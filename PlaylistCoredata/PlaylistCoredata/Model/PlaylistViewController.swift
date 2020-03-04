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
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
