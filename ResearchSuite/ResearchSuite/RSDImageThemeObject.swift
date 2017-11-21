//
//  RSDImageThemeObject.swift
//  ResearchSuite
//
//
//  Copyright © 2017 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation

/// An extension of `RSDImageWrapper` that implements the `RSDFetchableImageThemeElement` protocol
/// with `nil` values for the properties of that protocol. This allows for coding an image on an
/// `RSDThemedUIStep` using just the image name as oppose to the more complex schema that supports
/// additional information about the presentation of the image.
extension RSDImageWrapper : RSDFetchableImageThemeElement {

    /// The placement type for the image. This is `nil` for an `RSDImageWrapper`.
    public var placementType: RSDImagePlacementType? {
        return nil
    }
    
    /// The size of the image. This is `nil` for an `RSDImageWrapper`.
    public var size: CGSize? {
        return nil
    }
    
    /// The bundle for the image. This is `nil` for an `RSDImageWrapper`.
    public var bundle: Bundle? {
        return nil
    }
}

/// `RSDFetchableImageThemeElementObject` is a `Codable` concrete implementation of `RSDFetchableImageThemeElement`.
public struct RSDFetchableImageThemeElementObject : RSDFetchableImageThemeElement, RSDDecodableBundleInfo, Codable {

    /// The name of the image.
    public let imageName: String
    
    /// The bundle identifier for the image resource bundle.
    public let bundleIdentifier: String?
    
    /// The preferred placement of the image. Default placement is `iconBefore` if undefined.
    public let placementType: RSDImagePlacementType?
    
    /// The image size. If undefined then default sizing will be used.
    public var size: CGSize? {
        return _size?.size
    }
    private let _size: RSDSizeWrapper?
    
    /// The unique identifier for the image
    public var identifier: String {
        guard let bundleIdentifier = bundleIdentifier else { return imageName }
        return "\(bundleIdentifier).\(imageName)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case imageName, bundleIdentifier, placementType, _size = "size"
    }
    
    /// Default initializer.
    ///
    /// - parameters:
    ///     - imageName: The name of the image.
    ///     - bundleIdentifier: The bundle identifier for the image resource bundle. Default = `nil`.
    ///     - placementType: The preferred placement of the image. Default = `nil`.
    ///     - size: The image size. Default = `nil`.
    public init(imageName: String, bundleIdentifier: String? = nil, placementType: RSDImagePlacementType? = nil, size: CGSize? = nil) {
        self.imageName = imageName
        self.bundleIdentifier = bundleIdentifier
        self._size = RSDSizeWrapper(size)
        self.placementType = placementType
    }
    
    /// A method for fetching the image.
    ///
    /// - parameters:
    ///     - size:        The size of the image to return.
    ///     - callback:    The callback with the image, run on the main thread.
    public func fetchImage(for size: CGSize, callback: @escaping ((UIImage?) -> Void)) {
        let fetchedImage = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        DispatchQueue.main.async {
            callback(fetchedImage)
        }
    }
}

/// `RSDAnimatedImageThemeElementObject` is a `Codable` concrete implementation of `RSDAnimatedImageThemeElement`.
public struct RSDAnimatedImageThemeElementObject : RSDAnimatedImageThemeElement, RSDDecodableBundleInfo, Codable {
    
    /// The list of image names for the images to include in this animation.
    public let imageNames: [String]
    
    /// The animation duration for the image animation.
    public let animationDuration: TimeInterval
    
    /// The preferred placement of the image.
    public let placementType: RSDImagePlacementType?
    
    /// The bundle identifier for the image resource bundle.
    public let bundleIdentifier: String?
    
    /// The image size.
    public var size: CGSize? {
        return _size?.size
    }
    private let _size: RSDSizeWrapper?
    
    /// The unique identifier for the image
    public var identifier: String {
        guard let bundleIdentifier = bundleIdentifier else { return imageNames.first! }
        return "\(bundleIdentifier).\(imageNames.first!)"
    }

    private enum CodingKeys: String, CodingKey {
        case imageNames, animationDuration, bundleIdentifier, placementType, _size = "size"
    }

    /// Default initializer.
    ///
    /// - parameters:
    ///     - imageNames: The names of the images.
    ///     - bundleIdentifier: The bundle identifier for the image resource bundle. Default = `nil`.
    ///     - animationDuration: The animation duration.
    ///     - placementType: The preferred placement of the image. Default = `nil`.
    ///     - size: The image size. Default = `nil`.
    public init(imageNames: [String], animationDuration: TimeInterval, bundleIdentifier: String? = nil, placementType: RSDImagePlacementType? = nil, size: CGSize? = nil) {
        self.imageNames = imageNames
        self.bundleIdentifier = bundleIdentifier
        self.animationDuration = animationDuration
        self._size = RSDSizeWrapper(size)
        self.placementType = placementType
    }
    
    /// The animated images to display.
    /// - parameter traitCollection: The trait collection.
    /// - returns: The images for this step.
    public func images(compatibleWith traitCollection: UITraitCollection? = nil) -> [UIImage] {
        return imageNames.rsd_mapAndFilter {
            UIImage(named: $0, in: bundle, compatibleWith: traitCollection)
        }
    }
    
    /// A method for fetching the image.
    ///
    /// - parameters:
    ///     - size:        The size of the image to return.
    ///     - callback:    The callback with the image, run on the main thread.
    public func fetchImage(for size: CGSize, callback: @escaping ((UIImage?) -> Void)) {
        let fetchedImage = self.images().first
        DispatchQueue.main.async {
            callback(fetchedImage)
        }
    }
}

/// A `Codable` wrapper for `CGSize`.
struct RSDSizeWrapper : Codable {
    let width: CGFloat
    let height: CGFloat
    
    init?(_ size: CGSize?) {
        guard let size = size else { return nil }
        width = size.width
        height = size.height
    }
    
    var size: CGSize {
        return CGSize(width: width, height: height)
    }
}

extension RSDFetchableImageThemeElementObject : RSDDocumentableCodableObject {
    
    static func codingMap() -> Array<(CodingKey, Any.Type, String)> {
        let codingKeys: [CodingKeys] = [.imageName, .bundleIdentifier, .placementType, ._size]
        return codingKeys.map {
            switch $0 {
            case .imageName:
                return ($0, String.self, "The name of the image.")
            case .bundleIdentifier:
                return ($0, String.self, "The bundle identifier for the image. Default = `nil`.")
            case .placementType:
                return ($0, RSDImagePlacementType.self, "The preferred placement of the image. Default = `nil`.")
            case ._size:
                return ($0, RSDSizeWrapper.self, "The size of the image. Default = `nil`.")
            }
        }
    }
    
    static func imageThemeExamples() -> [RSDFetchableImageThemeElementObject] {
        let imageA = RSDFetchableImageThemeElementObject(imageName: "blueDog")
        let imageB = RSDFetchableImageThemeElementObject(imageName: "redCat", bundleIdentifier: "org.example.SharedResources", placementType: .topBackground, size: CGSize(width: 100, height: 120))
        return [imageA, imageB]
    }
    
    static func examples() -> [Encodable] {
        return imageThemeExamples()
    }
}

extension RSDAnimatedImageThemeElementObject : RSDDocumentableCodableObject {
    
    static func codingMap() -> Array<(CodingKey, Any.Type, String)> {
        let codingKeys: [CodingKeys] = [.imageNames, .animationDuration, .bundleIdentifier, .placementType, ._size]
        return codingKeys.map {
            switch $0 {
            case .imageNames:
                return ($0, [String].self, "The names of the images.")
            case .animationDuration:
                return ($0, TimeInterval.self, "The animation duration.")
            case .bundleIdentifier:
                return ($0, String.self, "The bundle identifier for the image. Default = `nil`.")
            case .placementType:
                return ($0, RSDImagePlacementType.self, "The preferred placement of the image. Default = `nil`.")
            case ._size:
                return ($0, RSDSizeWrapper.self, "The size of the image. Default = `nil`.")
            }
        }
    }
    
    static func imageThemeExamples() -> [RSDAnimatedImageThemeElementObject] {
        let imageA = RSDAnimatedImageThemeElementObject(imageNames: ["blueDog1", "blueDog2", "blueDog3"], animationDuration: 2)
        let imageB = RSDAnimatedImageThemeElementObject(imageNames: ["redCat1", "redCat2", "redCat3"], animationDuration: 2, bundleIdentifier: "org.example.SharedResources", placementType: .topBackground, size: CGSize(width: 100, height: 120))
        return [imageA, imageB]
    }
    
    static func examples() -> [Encodable] {
        return imageThemeExamples()
    }
}
