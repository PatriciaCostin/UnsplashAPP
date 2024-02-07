//
//  PictureModel.swift
//  Unsplash
//
//  Created by Ion Belous on 10.10.2023.
//

import UIKit

struct PictureModel: Codable, Identifiable {
    let id: String
    let imageUrl: String
    let author: String
    let location: String
    let publicationDate: Date
    let device: String
    let licence: String
}

extension PictureModel {
    
    private struct Constants {
        static let infoLabelFontSize: CGFloat = 14
    }
    
    func formattedDescription() -> NSAttributedString {
        let regularFont = UIFont.systemFont(
            ofSize: Constants.infoLabelFontSize,
            weight: .regular
        )
        let semiBoldFont = UIFont.systemFont(
            ofSize: Constants.infoLabelFontSize,
            weight: .semibold
        )
        
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: regularFont
        ]
        
        let semiBoldAttributes: [NSAttributedString.Key: Any] = [
            .font: semiBoldFont
        ]
        
        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .font: regularFont,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        // - author
        let author = NSAttributedString(
            string: author,
            attributes: semiBoldAttributes
        )
        
        // - location
        let location = NSAttributedString(
            string: "\n" + location,
            attributes: regularAttributes
        )
        
        // - published date
        let dateString = publicationDate.daysAgoString()

        let date = NSMutableAttributedString(
            string: "\nPublished ",
            attributes: regularAttributes
        )
        let date2 = NSAttributedString(
            string: dateString,
            attributes: semiBoldAttributes
        )
        
        date.append(date2)
       
        // - device info
        let device = NSAttributedString(
            string: "\n" + device,
            attributes: regularAttributes
        )
        
        // - licence
        let licence = NSMutableAttributedString(
            string: "\nFree to use under the ",
            attributes: regularAttributes
        )
        let licence2 = NSAttributedString(
            string: self.licence,
            attributes: underlineAttributes
        )
        licence.append(licence2)

        // - merging
        let attributedText = NSMutableAttributedString()
        attributedText.append(author)
        attributedText.append(location)
        attributedText.append(date)
        attributedText.append(device)
        attributedText.append(licence)
        
       return attributedText
    }
}
