//
//  RSDTableSection.swift
//  ResearchStack2
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

/// Defines a section in a table. A table is made up of sections, groups, and items.
///
/// For most group types, there is one cell per group and there can be one or more groups per section.
/// However, there are exceptions such as multiple-choice lists where each value is displayed in a
/// selectable table item.
open class RSDTableSection {
    
    /// The list of items included in this section.
    open private(set) var tableItems: [RSDTableItem]
    
    /// The table section index.
    open private(set) var index: Int
    
    /// The title for this section.
    public var title: String?
    
    /// The subtitle for this section.
    public var subtitle: String?
    
    /// Returns the total count of all Items in this section.
    /// - returns: The total number of `RSDTableItems` in this section.
    open func rowCount() -> Int {
        return tableItems.count
    }
    
    /// Default initializer.
    /// - parameters:
    ///     - sectionIndex: The table section index for this item.
    ///     - tableItems: The table items in this section.
    public init(sectionIndex: Int, tableItems: [RSDTableItem]) {
        self.index = sectionIndex
        for item in tableItems {
            item.sectionIndex = sectionIndex
        }
        self.tableItems = tableItems
    }
}
