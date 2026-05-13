import SwiftUI

struct ClubDetailView: View {
    
    @EnvironmentObject private var repository: ClubRepository
    let club: Club
    
    // MARK: - Form State (User Input)
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userStudyArea = ""
    @State private var userMessage = ""
    @State private var showingForm = false
    @State private var showingJoinConfirmation = false
    
    // MARK: - Validation Logic
    // Checks if the name contains ONLY letters and spaces
    private var isNameValid: Bool {
        let nameRegex = "^[a-zA-Z\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: userName) && !userName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // Checks for specific UTS student email domain
    private var isEmailValid: Bool {
        let lowerEmail = userEmail.lowercased()
        return lowerEmail.contains("@") && lowerEmail.hasSuffix("student.uts.edu.au")
    }

    // Master switch for the submit button
    var isFormValid: Bool {
        let hasStudy = !userStudyArea.trimmingCharacters(in: .whitespaces).isEmpty
        return isNameValid && isEmailValid && hasStudy
    }

    // MARK: - Main View Layout
    var body: some View {
        ZStack {
            AppTheme.surface.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 22) {
                        header
                        details
                        events
                        ContactSection(club: club)
                        actions
                    }
                    .frame(maxWidth: 600) // Adaptive iPad width
                    .padding(20)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 16)
        }
        .navigationTitle(club.name)
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - Register Interest Sheet
        .sheet(isPresented: $showingForm) {
            NavigationStack {
                ZStack {
                    AppTheme.surface.ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 24) {
                            // Header Section
                            VStack(spacing: 12) {
                                Image(systemName: "envelope.badge.shield.half.filled")
                                    .font(.system(size: 60))
                                    .foregroundStyle(AppTheme.utsGreen.gradient)
                                Text("Join the Community")
                                    .font(.title2.bold())
                                Text("Send your details to \(club.name).")
                                    .font(.subheadline)
                                    .foregroundStyle(AppTheme.muted)
                            }
                            .padding(.top, 30)

                            // Input Fields Section
                            VStack(alignment: .leading, spacing: 18) {
                                
                                // NAME FIELD WITH ALPHABET VALIDATION
                                VStack(alignment: .leading, spacing: 6) {
                                    CustomInputField(label: "Full Name", icon: "person", text: $userName, placeholder: "e.g. Oliver Jack")
                                    
                                    if !userName.isEmpty && !isNameValid {
                                        Label("Use letters and spaces only", systemImage: "exclamationmark.circle")
                                            .font(.caption2)
                                            .foregroundStyle(.red)
                                    }
                                }
                                
                                // EMAIL FIELD WITH UTS VALIDATION
                                VStack(alignment: .leading, spacing: 6) {
                                    CustomInputField(label: "Student Email", icon: "envelope", text: $userEmail, placeholder: "name@student.uts.edu.au")
                                        .autocapitalization(.none)
                                        .keyboardType(.emailAddress)
                                    
                                    if userEmail.contains("@") && !isEmailValid {
                                        Label("Use your @student.uts.edu.au address", systemImage: "info.circle")
                                            .font(.caption2)
                                            .foregroundStyle(.orange)
                                    }
                                }
                                
                                CustomInputField(label: "Study Area", icon: "book", text: $userStudyArea, placeholder: "e.g. IT, Design")
                                
                                // Message Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Message (Optional)")
                                        .font(.caption.bold())
                                        .foregroundStyle(AppTheme.muted)
                                    TextEditor(text: $userMessage)
                                        .frame(height: 100)
                                        .padding(10)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
                                }
                            }
                            .frame(maxWidth: 500)
                            .padding(.horizontal, 20)
                            
                            // SUBMIT BUTTON
                            Button {
                                let impact = UIImpactFeedbackGenerator(style: .medium)
                                impact.impactOccurred()
                                showingForm = false
                                showingJoinConfirmation = true
                            } label: {
                                Text("Submit Registration")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 54)
                                    .background(isFormValid ? AppTheme.utsGreen : Color.gray.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(color: isFormValid ? AppTheme.utsGreen.opacity(0.3) : .clear, radius: 10, y: 5)
                            }
                            .disabled(!isFormValid)
                            .frame(maxWidth: 500)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") { showingForm = false }
                            .foregroundStyle(AppTheme.utsGreen)
                    }
                }
            }
            .presentationDragIndicator(.visible)
        }
        .alert("Interest registered", isPresented: $showingJoinConfirmation) {
            Button("Done", role: .cancel) {}
        } message: {
            Text("We saved your interest in \(club.name).")
        }
    }

    // MARK: - Subviews
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 14) {
                Image(systemName: club.category.icon)
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(AppTheme.utsGreen)
                    .frame(width: 64, height: 64)
                    .background(AppTheme.utsGreen.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                VStack(alignment: .leading, spacing: 5) {
                    Text(club.category.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppTheme.utsGreen)
                    Text(club.tagline)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(AppTheme.ink)
                }
            }
            Text(club.description)
                .font(.body)
                .foregroundStyle(AppTheme.muted)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 14) {
            InfoRow(icon: "mappin.and.ellipse", title: "Meeting place", value: club.meetingPlace)
            InfoRow(icon: "calendar", title: "Weekly meetup", value: club.weeklyMeetup)
            InfoRow(icon: "person.2.fill", title: "Members", value: "\(club.memberCount) students")

            FlowLayout(items: club.tags) { tag in
                Text(tag)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(AppTheme.utsGreen.opacity(0.10))
                    .foregroundStyle(AppTheme.utsGreen)
                    .clipShape(Capsule())
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var events: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming events")
                .font(.headline)

            ForEach(club.upcomingEvents) { event in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: event.isFeatured ? "star.circle.fill" : "calendar.circle.fill")
                        .foregroundStyle(event.isFeatured ? AppTheme.utsLime : AppTheme.utsGreen)
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                            .font(.subheadline.weight(.semibold))
                        Text("\(event.dateText) · \(event.location)")
                            .font(.caption)
                            .foregroundStyle(AppTheme.muted)
                    }
                    Spacer()
                }
                .padding(12)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var actions: some View {
        VStack(spacing: 10) {
            Button {
                repository.toggleFavourite(for: club)
            } label: {
                Label(repository.isFavourite(club) ? "Saved" : "Save club", systemImage: repository.isFavourite(club) ? "bookmark.fill" : "bookmark")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                showingForm = true
            } label: {
                Label("Register interest", systemImage: "checkmark.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}

// MARK: - Reusable UI Components

private struct CustomInputField: View {
    let label: String
    let icon: String
    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.caption.bold())
                .foregroundStyle(AppTheme.muted)
            
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(AppTheme.utsGreen)
                    .frame(width: 24)
                TextField(placeholder, text: $text)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

private struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(AppTheme.utsGreen)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(AppTheme.muted)
                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(AppTheme.ink)
            }
            Spacer()
        }
    }
}

private struct ContactSection: View {
    let club: Club
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            Text("Get in Touch")
                .font(.headline)
                .foregroundStyle(AppTheme.ink)
            
            HStack(spacing: 40) {
                if !club.facebookURL.isEmpty, let fbURL = URL(string: club.facebookURL) {
                    Link(destination: fbURL) {
                        ContactIcon(imageName: "fb_icon", systemFallback: "f.circle.fill", label: "Facebook")
                    }
                }
                
                if !club.instagramURL.isEmpty, let instaURL = URL(string: club.instagramURL) {
                    Link(destination: instaURL) {
                        ContactIcon(imageName: "ig_icon", systemFallback: "camera.fill", label: "Instagram")
                    }
                }
                
                if !club.websiteURL.isEmpty, let webURL = URL(string: club.websiteURL) {
                    Link(destination: webURL) {
                        ContactIcon(imageName: "web_icon", systemFallback: "globe", label: "Website")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}

private struct ContactIcon: View {
    let imageName: String
    let systemFallback: String
    let label: String
    
    var body: some View {
        VStack(spacing: 6) {
            if UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
            } else {
                Image(systemName: systemFallback)
                    .font(.title2)
                    .frame(height: 26)
            }
            
            Text(label)
                .font(.caption2)
                .bold()
        }
        .foregroundStyle(AppTheme.utsGreen)
    }
}

private struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 8)], alignment: .leading, spacing: 8) {
            ForEach(Array(items), id: \.self) { item in
                content(item)
            }
        }
    }
}
