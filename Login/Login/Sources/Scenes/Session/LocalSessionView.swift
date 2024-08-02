//
//  LocalSessionView.swift
//  Login
//
//  Created by Tiago Linhares on 22/06/24.
//

import SharpnezDesignSystem
import SwiftUI

struct LocalSessionView<ViewModel: LocalSessionViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(LoginConstants.Commons.localAuth)
                .font(.title2)
                .fontWeight(.bold)
            Text(LoginConstants.LoginFaceID.description)
        }
        .padding([.top], .xBig)
        .padding([.leading, .trailing, .bottom], .small)
        Spacer()
        Button {
            authenticate()
        } label: {
            Text(LoginConstants.Commons.access)
                .padding(.nano)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.small)
    }
    
    // MARK: Methods
    
    func authenticate() {
        viewModel.authenticate()
    }
}
