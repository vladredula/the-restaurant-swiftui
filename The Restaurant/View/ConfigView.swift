//
//  ConfigView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/11.
//

import SwiftUI

struct ConfigView: View {
    @AppStorage("isDarkMode") private var isDark = false
    @State private var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? ""
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
        List {
            
            Toggle("Dark Mode", isOn: $isDark)
                .toggleStyle(SwitchToggleStyle(tint: Color.accentColor))
            
            HStack {
                
                Picker("lang", selection: $currentLanguage) {
                    ForEach(availableLanguages, id: \.self) { languageCode in
                        Text(LocalizedStringKey(languageCode))
                            .tag(languageCode)
                    }
                }
                .onChange(of: currentLanguage) { newValue in
                    self.changeLanguage(to: newValue)
                    showingAlert.toggle()
                }
                .alert("Please restart app to load changes", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background").ignoresSafeArea())
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
