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
    let onSelect: (Option) -> Void
    
    @State private var isExpanded = false
    @State private var selectedOption: Option
    
    init(
        options: [Option],
        initialSelection: Option,
        onSelect: @escaping (Option) -> Void
    ) {
        self.options = options
        self._selectedOption = State(initialValue: initialSelection)
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: selectedOption.icon)
                        .foregroundStyle(.black)
                        .textStyle(.body)
                    
                    Text(selectedOption.title)
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
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    selectedOption = option
                                    onSelect(option)
                                }
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

#Preview {
    CustomDropdownBookDetail(
        options: ReadingStatus.allCases,
        initialSelection: .notRead,
    ) { selected in
        print("Selecionado: \(selected.rawValue)")
    }
}
