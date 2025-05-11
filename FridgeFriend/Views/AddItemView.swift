//
//  AddItemView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI
import PhotosUI

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var expiryDate: Date = Date()
    @State private var isLeftover: Bool = false
    @State private var selectedImage: PhotosPickerItem?

    @StateObject private var speechRecognitionManager = SpeechRecognitionManager()

    @State private var pendingVoiceInput: String = ""
    @State private var showVoiceInputConfirmation = false
    @State private var animateMic = false
    @State private var showUndoSnackbar = false
    @State private var lastSavedItem: FridgeItem?

    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("Item Info").font(.headline)) {
                        TextField("Item Name", text: $name)
                            .font(.system(size: 17, design: .rounded))
                            .autocapitalization(.words)

                        DatePicker("Expiry Date", selection: $expiryDate, displayedComponents: .date)

                        Toggle("Is this a leftover?", isOn: $isLeftover)
                    }

                    VStack(spacing: 10) {
                        Button(action: {
                            if speechRecognitionManager.isListening {
                                speechRecognitionManager.stopListening()
                            } else {
                                speechRecognitionManager.startListening()
                            }
                        }) {
                            Text(speechRecognitionManager.isListening ? "Stop Listening" : "Use Voice Input")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("Periwinkle"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                        }

                        if speechRecognitionManager.isListening {
                            ZStack {
                                Circle()
                                    .fill(Color("Periwinkle").opacity(0.3))
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(animateMic ? 1.2 : 1.0)
                                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(), value: animateMic)
                                Image(systemName: "mic.fill")
                                    .foregroundColor(Color("Periwinkle"))
                                    .font(.system(size: 30))
                            }
                            .frame(height: 70)
                            .onAppear { animateMic = true }
                            .onDisappear { animateMic = false }
                        }
                    }

                    PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()) {
                        Label("Pick Photo", systemImage: "photo.on.rectangle")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PaleDogwood"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                    .onChange(of: selectedImage) {
                        handleImageSelection(item: selectedImage)
                    }

                    Button(action: saveItem) {
                        Text("Add to Inventory")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("MimiPink"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .background(Color("Almond"))
                .navigationTitle("Add Item")
            }

            if showUndoSnackbar {
                VStack {
                    Spacer()
                    HStack {
                        Text("Item saved")
                        Spacer()
                        Button("Undo") {
                            undoSave()
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showUndoSnackbar)
                }
            }
        }
        .onReceive(speechRecognitionManager.$recognizedText) { text in
            if !text.isEmpty {
                pendingVoiceInput = text
                showVoiceInputConfirmation = true
                speechRecognitionManager.stopListening()
            }
        }
        .alert("Use this name?", isPresented: $showVoiceInputConfirmation, actions: {
            Button("Yes") {
                name = pendingVoiceInput
            }
            Button("No", role: .cancel) {
                pendingVoiceInput = ""
            }
        }, message: {
            Text("\"\(pendingVoiceInput)\"")
        })
    }

    private func saveItem() {
        let newItem = FridgeItem(context: viewContext)
        newItem.name = name
        newItem.expiryDate = expiryDate
        newItem.isLeftover = isLeftover
        newItem.addedDate = Date()

        do {
            try viewContext.save()
            lastSavedItem = newItem

            if isLeftover {
                NotificationManager.scheduleNotification(
                    title: "Leftover Reminder",
                    body: "\(name) might need to be eaten soon!",
                    date: expiryDate.addingTimeInterval(-86400) // 1 day before expiry
                )
            }

            withAnimation {
                showUndoSnackbar = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showUndoSnackbar = false
                }
            }
            dismiss()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }

    private func undoSave() {
        if let item = lastSavedItem {
            viewContext.delete(item)
            do {
                try viewContext.save()
            } catch {
                print("Failed to undo save: \(error.localizedDescription)")
            }
            showUndoSnackbar = false
        }
    }

    private func handleImageSelection(item: PhotosPickerItem?) {
        guard let item = item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                PhotoItemParser.extractText(from: image) { results in
                    DispatchQueue.main.async {
                        if let firstWord = results.first {
                            name = firstWord
                        }
                    }
                }
            }
        }
    }
}
