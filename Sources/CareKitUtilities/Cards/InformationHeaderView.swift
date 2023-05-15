//
//  InformationHeaderView.swift
//  CareKitUtilities
//
//  Created by Julia Stekardis on 12/6/22.
//  Copyright © 2022 NetReconLab. All rights reserved.
//

import CareKitStore
import SwiftUI

/// Header used for most CareKit cards.
///
/// # Style
/// The card supports styling using `careKitStyle(_:)`.
///
/// ```
///    +----------------------------------------+
///    |                                        |
///    |  <Image> <Title>        <Info Image>   |
///    |  <Information>                         |
///    |                                        |
///    +----------------------------------------+
/// ```
public struct InformationHeaderView: View {

    // MARK: - Properties

    @Environment(\.careKitStyle) private var style
    @State var isShowingDetails = false

    private let title: Text
    private let information: Text?
    private let image: Image?
    private let task: OCKAnyTask
    private let detailsTitle: String?
    private let details: String?

    @OSValue<Font>(values: [.watchOS: .system(size: 13)],
                   defaultValue: .caption) private var font

    public var body: some View {
        HStack(spacing: style.dimension.directionalInsets2.trailing) {
            image?
                .font(.largeTitle)
                .foregroundColor(Color(UIColor.lightGray))
            VStack(alignment: .leading, spacing: style.dimension.directionalInsets1.top / 4.0) {
                title
                    .font(.headline)
                    .fontWeight(.bold)

                information?
                    .font(font)
                    .fontWeight(.medium)
            }.foregroundColor(Color.primary)
            Spacer()
            Button(action: {
                isShowingDetails = true
            }) {
                Image(systemName: "info.circle")
            }
            .clipShape(Circle())
            .fixedSize()
        }
        .sheet(isPresented: $isShowingDetails) {
            DetailsView(task: task, title: detailsTitle, details: details)
        }
    }

    // MARK: - Init

    /// Create an instance.
    /// - Parameters:
    ///   - title: The title text to display above the detail.
    ///   - information: The text to display below the title.
    ///   - image: Detail image to display beside the text.
    ///   - task: The task to display details for when the info button is tapped.
    ///   - detailsTitle: The title text to be displayed when the info button is tapped.
    ///   - details: The text to be displayed when the info button is tapped.
    public init(title: Text,
                information: Text? = nil,
                image: Image? = nil,
                task: OCKAnyTask,
                detailsTitle: String? = nil,
                details: String? = nil) {
        self.title = title
        self.information = information
        self.image = image
        self.task = task
        self.detailsTitle = detailsTitle
        self.details = details
    }
}

struct InformationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        InformationHeaderView(title: Text("Hello"),
                              task: OCKTask(id: "",
                                            title: "Hello",
                                            carePlanUUID: nil,
                                            schedule: .dailyAtTime(hour: 0,
                                                                   minutes: 0,
                                                                   start: Date(),
                                                                   end: nil,
                                                                   text: "")))
    }
}
