//
//  LocalFileManager.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private let folderName = "WatchVault"
    
    init() {
        createFolderIfNeeded()
    }

    func add(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0), let path = getPathForImage(name: name)
        else {
            print("Failed to get data for image named: \(name)")
            return
        }
        do {
            try data.write(to: path)
            print("Successfully saved to path: \(path)")
        } catch let error {
            print("Failed to save image to path: \(path) with error: \(error)")
        }
    }
    
    func get(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path, FileManager.default.fileExists(atPath: path)
        else {
            print("Failed to get path for: \(name)")
            return nil
        }
        print("Image named \(name) returned from saved files.")
        return UIImage(contentsOfFile: path)
    }
    
    func remove(name: String) {
        guard let path = getPathForImage(name: name)?.path, FileManager.default.fileExists(atPath: path)
        else {
            print("Failed to get path for: \(name)")
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Sucessfully deleted image from path: \(path)")
        } catch let error {
            print("Failed to delete image named: \(name) with error: \(error)")
        }
    }
    
    func deleteFolder() {
        guard let path = getPath()?.path else { return }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Successfully deleted folder named \(path).")
        } catch let error {
            print("Failed to delete folder for \(path) with error: \(error)")
        }
    }
    
    private func createFolderIfNeeded() {
        guard let path = getPath()?.path else { return }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Successfully created folder named: \(path)")
            } catch let error {
                print("Failed to create folder for \(path) with error: \(error)")
            }
        }
    }
    
    private func getPath() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    private func getPathForImage(name: String) -> URL? {
        guard let path = getPath()?.appendingPathComponent(name)
        else {
            print("Failed to get path for: \(name)")
            return nil
        }
        return path
    }
}
