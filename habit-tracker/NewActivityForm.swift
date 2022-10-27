//
//  NewActivityForm.swift
//  habit-tracker
//
//  Created by RqwerKnot on 22/02/2022.
//

import SwiftUI

struct NewActivityForm: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var title: String
    @Binding var description: String
    @Binding var done: Bool
    
    @State private var showAlert = false
    @State private var prompted = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title, prompt: Text("Enter activity's title here"))
                } header: {
                    Text("Title")
                        .foregroundColor( prompted && title.isEmpty ? .red : .primary)
                }
                
                Section {
                    TextEditor(text: $description)
                } header: {
                    Text("Description")
                        .foregroundColor( prompted && description.isEmpty ? .red : .primary)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if title.isEmpty || description.isEmpty {
                            showAlert.toggle()
                        } else {
                            done = true
                            dismiss()
                        }
                    }
                }
            }
        }
        .alert("Oups!", isPresented: $showAlert) {
            Button("OK") {
                prompted = true
            }
        } message: {
            Text("Please enter a title and description for your new activity")
        }
        
    }
}

struct NewActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        
        NewActivityForm(title: .constant(""), description: .constant(""), done: .constant(false))
        
    }
}
