//
//  ConfigView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/11.
//

import SwiftUI

struct ConfigView: View {
    @State private var currentLanguage: String = "en"
    @State private var showingAlert = false
    
    let availableLanguages = Bundle.main.localizations.filter { languageCode in
        Bundle.main.path(
            forResource: "Localizable",
            ofType: "strings",
            inDirectory: nil,
            forLocalization: languageCode
        ) != nil
    }
    

    var body: some View {
        HStack {
            Text("lang")
            Picker("Language", selection: $currentLanguage) {
                ForEach(availableLanguages, id: \.self) { languageCode in
                    Text(LocalizedStringKey(languageCode))
                        .tag(languageCode)
                }
            }
            .onChange(of: currentLanguage) { newValue in
                self.changeLanguage(to: newValue)
                showingAlert.toggle()
            }
            .alert("Restart your app", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
        }
    }
    
    func changeLanguage(to language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            _ = Locale(identifier: language)
            Bundle(path: path)?.load()
            currentLanguage = language
            UserDefaults.standard.set([language], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
