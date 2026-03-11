import SwiftUI
import ValidationKit
import ValidationKitUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var emailField = FieldValidation(AllRule<String>.all(
        .notEmpty.message("Email is required"),
        .email.message("Please enter a valid email address")
    ))
    @State private var passwordField = FieldValidation(AllRule<String>.all(
        .notEmpty.message("Password is required"),
        .minLength(8).message("Password must be at least 8 characters")
    ))
    @State private var group = GroupValidation()
    @State private var showSuccess = false
    @State private var showValidationError = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    TextField("Email", text: $email)
                        .validatedField(emailField, text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    ForEach(emailField.errors) { error in
                        Text(error.localizedDescription)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }

                VStack(alignment: .leading) {
                    SecureField("Password", text: $password)
                        .validatedField(passwordField, text: $password)
                        .textContentType(.newPassword)
                    ForEach(passwordField.errors) { error in
                        Text(error.localizedDescription)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }

                Spacer()

                Button("Sign Up") {
                    if group.validateAll() {
                        showSuccess = true
                    } else {
                        showValidationError = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .navigationTitle("Sign Up")
            .validationGroup(group)
            .alert("Please fix the errors", isPresented: $showValidationError) {
                Button("OK", role: .cancel) {}
            } message: {
                let errors = emailField.errors + passwordField.errors
                Text(errors.map(\.localizedDescription).joined(separator: "\n"))
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    email = ""
                    password = ""
                    group.reset()
                }
            } message: {
                Text("Account created for \(email)")
            }
        }
    }
}

#Preview {
    ContentView()
}
