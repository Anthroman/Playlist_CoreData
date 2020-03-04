//
//  Playlist+Convenience.swift
//  PlaylistCoredata
//
//  Created by Anthroman on 3/4/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation
import CoreData

extension Playlist {
    // ignore warning messages
    @discardableResult

    convenience init(name: String, songs: [Song] = [], moc: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
    }
}
