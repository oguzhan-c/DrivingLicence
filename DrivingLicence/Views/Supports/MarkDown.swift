//
//  MarkDown.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct MarkDown: View {
    let text: String

    var body: some View {
        Text(safeAttributedString(text))
    }
}

private func safeAttributedString(_ sourceString: String) -> AttributedString {
    do {
        return try AttributedString(markdown: sourceString)
    } catch {
        print("Failed to convert Markdown to AttributedString: \(error.localizedDescription)")
        return try! AttributedString(markdown: "Text could not be rendered")
    }
}
