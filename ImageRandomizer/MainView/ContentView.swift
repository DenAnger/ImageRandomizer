//
//  ContentView.swift
//  ImageRandomizer
//
//  Created by Denis Abramov on 01.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var randomImage = UIImage(named: "cat")!
    
    @State private var isImageZoomed = false
    @State private var isPresented = false
    @State private var isButtonVisible = true
    
    private let urlString = "https://loremflickr.com/600/600"
    private let imageName = "cacheImage.png"
    
    private let manager = CacheFileManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            
            if isImageZoomed {
                RandomImageView(image: Image(uiImage: randomImage))
                    .padding()
                    .scaleEffect(2.5)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isImageZoomed.toggle()
                            isButtonVisible.toggle()
                        }
                    }
            } else {
                RandomImageView(image: Image(uiImage: randomImage))
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isImageZoomed.toggle()
                            isButtonVisible.toggle()
                        }
                    }
            }
            
            if isButtonVisible {
                RandomButton(action: changeImage)
            }
        }
        
        .onAppear(perform: {
            manager.clearCacheIfNeeded()
            loadImage()
        })
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification),
                   perform: { output in
            saveImage()
        })
    }
    
    // MARK: - Actions
    
    private func changeImage() {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    return
                }
                randomImage = image
            }
        }.resume()
    }
    
    // MARK: - Methods
    
    private func saveImage() {
        manager.saveImageToCache(image: randomImage, imageName: imageName)
    }
    
    private func loadImage() {
        
        if let image = manager.loadImageFromCache(imageName: imageName) {
            randomImage = image
        }
    }
}

#Preview {
    ContentView()
}
