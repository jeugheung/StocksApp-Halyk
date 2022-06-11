//
//  FavoritesUpdateService.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 03.06.2022.
//

import Foundation

@objc protocol FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startObservingFavoriteNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setFavorite), name: NSNotification.Name.favoriteNotification, object: nil)
    }
}

extension NSNotification.Name {
    static let favoriteNotification = NSNotification.Name("set_favorite")
}

extension Notification {
    var stockId: String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String else { return nil }
        return id
    }
}
