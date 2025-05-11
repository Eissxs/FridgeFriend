//
//  PhotoItemParser.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import Foundation
import Vision
import UIKit

struct PhotoItemParser {
    static func extractText(from image: UIImage, completion: @escaping ([String]) -> Void) {
        guard let cgImage = image.cgImage else {
            completion([])
            return
        }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                completion([])
                return
            }

            let observations = request.results as? [VNRecognizedTextObservation] ?? []
            let words = observations.compactMap { $0.topCandidates(1).first?.string }
            completion(words)
        }

        request.recognitionLevel = .accurate

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Text recognition failed: \(error)")
                completion([])
            }
        }
    }
}
