//
//  DropDownBookDetail.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 28/04/26.
//

import SwiftUI

protocol DropdownOption {
    var title: String { get }
    var icon: String { get }
}

struct CustomDropdownBookDetail<Option: Hashable & DropdownOption>: View {
    
    let options: [Option]
    let initialSelection: Option
    @Binding var bookReview: BookReview
    
    @State private var isExpanded = false
    @State private var isInitial = true
    @State private var selectedOption: Option?
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: isInitial ? initialSelection.icon : selectedOption!.icon)
                        .foregroundStyle(.black)
                        .textStyle(.body)
                    
                    Text(isInitial ? initialSelection.title : selectedOption!.title)
                        .foregroundStyle(.black)
                        .textStyle(.body)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .padding(.horizontal, 20)
                .frame(height: 64)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(options.filter { $0 != selectedOption }, id: \.self) { option in
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isExpanded = false
                            }
                            isInitial = false
                            selectedOption = option
                            bookReview.readingStatus = selectedOption as! ReadingStatus
                        } label: {
                            HStack(spacing: 16) {
                                Image(systemName: option.icon)
                                    .frame(width: 24)
                                
                                Text(option.title)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .frame(height: 58)
                        }
                        .buttonStyle(.plain)
                        
                        if option != options.filter({ $0 != selectedOption }).last {
                            Divider()
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .scaleEffect(
                    x: 1,
                    y: isExpanded ? 1 : 0,
                    anchor: .top
                )
                .opacity(isExpanded ? 1 : 0)
                .clipped()
                .animation(.easeInOut(duration: 0.25), value: isExpanded)
            }
        }
    }
}

