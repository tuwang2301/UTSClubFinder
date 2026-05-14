import SwiftUI
import PhotosUI

private final class ProfileStore: ObservableObject {
    let email : String
    
    private var nameKey: String{"profile_\(email)_name"}
    private var interestsKey    : String{"profile_\(email)_interests"}
    private var photoKey    : String{"profile_\(email)_photo"}
    
    @Published var name: String{
        didSet {UserDefaults.standard.set(name, forKey: nameKey)}
    }
    @Published var interestsRaw: String{
        didSet {UserDefaults.standard.set(interestsRaw, forKey: interestsKey)}
    }
    @Published var photoDataStr: String{
        didSet {UserDefaults.standard.set(photoDataStr, forKey: photoKey)}
    }
    
    init(email: String) {
        self.email = email
        self.name = UserDefaults.standard.string(forKey: "profile_\(email)_name") ?? "Student Explorer"
        self.interestsRaw = UserDefaults.standard.string(forKey: "profile_\(email)_interests") ?? ""
        self.photoDataStr = UserDefaults.standard.string(forKey: "profile_\(email)_photo") ?? ""
    }
    var selectedInterests: Set<ClubCategory> {
        Set(interestsRaw
            .split(separator: ",")
            .compactMap{ ClubCategory(rawValue: String($0))})
    }
    
    func toggleInterest(_ category: ClubCategory){
        var current = selectedInterests
        if current.contains(category){
            current.remove(category)
        } else{
            current.insert(category)
        }
        interestsRaw = current.map(\.rawValue).joined(separator: ",")
    }
}

struct ProfileView: View {
    @EnvironmentObject private var repository: ClubRepository
    @EnvironmentObject private var geofenceManager: GeofenceManager
    
    @AppStorage("profile_isSignedIn") private var isSignedIn: Bool = false
    @AppStorage("profile_email") private var storedEmail: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                if isSignedIn {
                    SignedInProfileView(email: storedEmail, repository: repository, geofenceManager: geofenceManager, onSignOut: signOut)
                } else {
                    SignInCard(onSignIn: {email in
                        storedEmail = email
                        isSignedIn = true
                    })
                }
            }
            .padding(20)
        }
        .background(AppTheme.surface)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func signOut(){
        isSignedIn = false
        storedEmail = ""
    }
}

// MARK: Sign-In Card
private struct SignInCard: View{
    let onSignIn: (String) -> Void
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    private var isValidEmail: Bool {
        let lower = email.lowercased()
        return lower.hasSuffix("@student.uts.edu.au") || lower.hasSuffix("@uts.edu.au")
    }
    
    private var canSubmit: Bool {isValidEmail && password.count >= 6}
    
    var body: some View{
        VStack(spacing: 0){
            
            VStack(spacing: 8){
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                Text("UTS Club Finder")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                Text("Sign in with your UTS Student Email")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
            .background(AppTheme.utsGreen)
            
            VStack(spacing: 14){
                Picker("", selection: $isSignUp){
                    Text("Sign In").tag(false)
                    Text("Sign Up").tag(true)
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 4)
                //email section
                VStack(alignment: .leading, spacing: 4){
                    Text("UTS Email")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(AppTheme.muted)
                    HStack{
                        Image(systemName: "envelope").foregroundStyle(AppTheme.muted)
                        TextField("you@student.uts.edu.au", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    .padding(12)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(emailBorderColor, lineWidth: 1.5))
                    
                    if !email.isEmpty && !isValidEmail {
                        Text("Must be a @student.uts.edu.au or @uts.edu.au address")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
                //password section
                VStack(alignment: .leading, spacing: 4){
                    Text("Password")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(AppTheme.muted)
                    HStack{
                        Image(systemName: "lock").foregroundStyle(AppTheme.muted)
                        SecureField("At least 6 characters", text: $password)
                    }
                    .padding(12)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppTheme.line, lineWidth: 1.5))
                }
                
                
                Button(action: submit){
                    Text(isSignUp ? "Create Account" : "Sign In")
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(canSubmit ? AppTheme.utsGreen : AppTheme.line)
                        .foregroundStyle(canSubmit ? Color.white : AppTheme.muted)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .disabled(!canSubmit)
                .animation(.easeInOut(duration: 0.2), value: canSubmit)
                
            }
            .padding(20)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        .shadow(color: .black.opacity(0.06), radius: 8, y : 4)
    }
    
    private var emailBorderColor: Color {
        if email.isEmpty {return AppTheme.line}
        return isValidEmail ? AppTheme.utsGreen : .red
    }
    
    private func submit(){
        guard canSubmit else {return}
        onSignIn(email.lowercased())
    }
}

// Mark: Signed In Profile

private struct SignedInProfileView : View {
    let email : String
    let repository : ClubRepository
    let geofenceManager : GeofenceManager
    let onSignOut: () -> Void
    
    @StateObject private var store: ProfileStore
    
    @State private var isEditingName    = false
    @State private var draftName        = ""
    @State private var photoItem:        PhotosPickerItem?  = nil
    @State private var profileImage:     Image? = nil
    @State private var showSignOutAlert = false
    
    init(email: String, repository: ClubRepository, geofenceManager: GeofenceManager, onSignOut: @escaping () -> Void) {
        self.email = email
        self.repository = repository
        self.geofenceManager = geofenceManager
        self.onSignOut = onSignOut
        _store = StateObject(wrappedValue: ProfileStore(email: email))
    }
    
    var body: some View{
        profileHeader
        interestsSection
        statsSection
        signOutButton
    }
    
    private var profileHeader: some View{
        VStack(spacing: 16){
            //avatar
            VStack(spacing: 8){
                PhotosPicker(selection: $photoItem, matching: .images){
                    ZStack(alignment: .bottomTrailing){
                        Group{
                            if let profileImage{
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(AppTheme.utsGreen)
                            }
                        }
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(AppTheme.line, lineWidth: 2))
                        
                        Image(systemName: "camera.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(6)
                            .background(AppTheme.utsGreen)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                            .offset(x:4 , y:4)
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: photoItem){ _, newItem in loadPhoto(from: newItem)}
                
                Text("Tap to change photo")
                    .font(.caption2)
                    .foregroundStyle(AppTheme.muted)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            //Name Section
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 4){
                    Text("Name")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(AppTheme.muted)
                    
                    if isEditingName{
                        TextField("Your Name", text: $draftName)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(AppTheme.ink)
                            .textFieldStyle(.plain)
                            .submitLabel(.done)
                            .onSubmit {
                                saveName()
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(AppTheme.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(AppTheme.utsGreen, lineWidth: 1.5))
                    } else {
                        Text(store.name)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(AppTheme.ink)
                    }
                    Text(email)
                        .font(.caption)
                        .foregroundStyle(AppTheme.muted)
                }
                Spacer()
                
                Button(isEditingName ? "Done" : "Edit") {
                    if isEditingName {saveName()}
                    else {draftName = store.name; isEditingName = true}
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppTheme.utsGreen)
            }
            
            Text(interesetSubtitle)
                .font(.subheadline)
                .foregroundStyle(AppTheme.muted)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        .onAppear{loadStoredPhoto()}
    }
    
    private var interestsSection : some View {
        VStack(alignment: .leading, spacing: 14){
            VStack(alignment: .leading, spacing: 4){
                Text("Interests")
                    .font(.headline)
                    .foregroundStyle(AppTheme.ink)
                Text("Tap a category to toggle it on or off")
                    .font(.caption)
                    .foregroundStyle(AppTheme.muted)
            }
            WrappingHStack(spacing: 8){
                ForEach(ClubCategory.allCases){ category in
                    InterestChip(category: category, isSelected: store.selectedInterests.contains(category), onTap: {store.toggleInterest(category)}
                    )
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
    
    
    private var statsSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Stats")
                .font(.headline)
                .foregroundStyle(AppTheme.ink)
            StatRow(icon: "bookmark.fill",
                    label: "\(repository.savedClubs.count) saved club\(repository.savedClubs.count == 1 ? "" : "s")")
            StatRow(icon: "building.2.fill",
                    label:"\(repository.clubs.count) clubs in prototype date")
            StatRow(icon: "location.fill", label: "\(geofenceManager.monitoredClubIDs.count) active geofence region\(geofenceManager.monitoredClubIDs.count == 1 ? "" : "s")")
            StatRow(icon: "tag.fill", label: "\(store.selectedInterests.count) interest\(store.selectedInterests.count == 1 ? "" : "s") selected")
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
    
    private var signOutButton: some View{
        Button{showSignOutAlert = true} label: {
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign Out")
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        }
        .buttonStyle(.plain)
        .confirmationDialog("Sign out of UTS Club Finder?", isPresented: $showSignOutAlert, titleVisibility: .visible){
            Button("Sign Out", role: .destructive, action: onSignOut)
            Button("Cancel", role: .cancel){}
        }
    }
    
    private func saveName(){
        let trimmed = draftName.trimmingCharacters(in: .whitespaces)
        store.name = trimmed.isEmpty ? "Student Explorer" : trimmed
        isEditingName = false
    }
    
    private var interesetSubtitle: String {
        let names = ClubCategory.allCases
            .filter{ store.selectedInterests.contains($0)}
            .map(\.rawValue)
        switch names.count{
        case 0:
            return "No interests selected yet."
        case 1:
            return "Interested in \(names[0])."
        case 2:
            return "Interested in \(names[0]) and \(names[1])"
        default: return "Interested in \(names.dropLast().joined(separator: ", ")), and  \(names.last!)"
        }
    }
    
    private func loadPhoto(from item: PhotosPickerItem?){
        guard let item else {return}
        Task{
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data){
                let resized = uiImage.resized(toWidth: 300)
                if let jpeg = resized.jpegData(compressionQuality: 0.7){
                    store.photoDataStr = jpeg.base64EncodedString()
                    profileImage = Image(uiImage: resized)
                }
            }
        }
    }
    
    private func loadStoredPhoto(){
        guard !store.photoDataStr.isEmpty,
              let data = Data(base64Encoded: store.photoDataStr),
              let uiImage = UIImage(data: data) else {return}
        profileImage = Image(uiImage: uiImage)
    }
}

// Mark: Shared subviews

private struct InterestChip: View {
    let category: ClubCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap){
            HStack(spacing: 6){
                Image(systemName: category.icon)
                    .font(.system(size: 12, weight: .semibold))
                Text(category.rawValue)
                    .font(.subheadline.weight(.medium))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? AppTheme.utsGreen : AppTheme.surface)
            .foregroundStyle(isSelected ? Color.white : AppTheme.ink)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(isSelected ? AppTheme.utsGreen : AppTheme.line, lineWidth: 1.5))
            .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

private struct StatRow: View {
    let icon: String
    let label: String
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: icon)
                .foregroundStyle(AppTheme.utsGreen)
                .frame(width: 20)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(AppTheme.ink)
        }
    }
}

private struct WrappingHStack: Layout {
    var spacing: CGFloat = 8
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height  = rows.map { row in
            row.map {subviews[$0].sizeThatFits(.unspecified).height}.max() ?? 0
        }.reduce(0) {$0 + $1 + spacing} - spacing
        return CGSize (width: proposal.width ?? 0 , height: max(height,0))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            let rowHeight = row.map {subviews[$0].sizeThatFits(.unspecified).height}.max() ?? 0
            for index in row {
                let size = subviews[index].sizeThatFits(.unspecified)
                subviews[index].place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
                x += size.width + spacing
            }
            y += rowHeight + spacing
        }
    }
    
    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [[Int]]
    {
        let maxWidth = proposal.width ?? .infinity
        var rows: [[Int]] = []
        var currentRow: [Int] = []
        var rowWidth : CGFloat = 0
        for (i, subview) in subviews.enumerated(){
            let size = subview.sizeThatFits(.unspecified)
            if rowWidth + size.width > maxWidth, !currentRow.isEmpty {
                rows.append(currentRow)
                currentRow = [i]
                rowWidth = size.width + spacing
            } else {
                currentRow.append(i)
                rowWidth += size.width + spacing
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        return rows
    }
}

// Marl : UIImage resizez
private extension UIImage{
    func resized(toWidth width: CGFloat) -> UIImage{
        guard size.width > width else { return self }
        let scale = width / size.width
        let newSize = CGSize(width: width, height: size.height * scale)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
 
