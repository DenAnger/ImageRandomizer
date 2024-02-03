//
//  CacheFileManager.swift
//  ImageRandomizer
//
//  Created by Denis Abramov on 02.02.2024.
//

import SwiftUI

class CacheFileManager {
    static let shared = CacheFileManager()
    
    private init() {}
    
    func saveImageToCache(image: UIImage, imageName: String) {
        
        if let data = image.pngData(),
           let cacheDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                         in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(imageName)
            try? data.write(to: fileURL)
        }
    }
    
    func loadImageFromCache(imageName: String) -> UIImage? {
        
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                         in: .userDomainMask).first {
            let fileURL = cacheDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }
    
    func clearCacheIfNeeded() {
        let defaults = UserDefaults.standard
        let lastRunDate = defaults.object(forKey: "LastRunDate") as? Date
        
        if let lastRunDate = lastRunDate {
            let timeInterval = Date().timeIntervalSince(lastRunDate)
            let minutesPassed = timeInterval / 60
            
            if minutesPassed > 5 {
                clearCache()
            }
        }
        defaults.set(Date(), forKey: "LastRunDate")
    }
    
    private func clearCache() {
        
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                         in: .userDomainMask).first {
            let fileManager = FileManager.default
            
            do {
                let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: .skipsHiddenFiles)
                
                for fileURL in fileURLs {
                    try fileManager.removeItem(at: fileURL)
                }
            } catch {
                print("Failed to clear cache: \(error)")
            }
        }
    }
}
