# 📝 Reminder Clone App

A beautifully designed **iOS Reminder Clone App** built with **SwiftUI** and **Core Data**, replicating the core functionality of Apple’s Reminders app.  
It demonstrates modern **MVVM architecture**, data persistence, dynamic lists, and local notifications — all implemented in pure SwiftUI.

---

## 🚀 Features

### ✅ Core Functionality
- Create, edit, and delete **reminders**.
- Organize reminders into **custom lists** with colors.
- Mark reminders as **completed or pending**.
- Schedule **date and time-based reminders** with **local notifications**.
- Dynamic **search** and **filtering** of reminders.

### 💾 Persistence (Core Data)
- Uses **Core Data** for offline storage.
- Fully supports **CRUD operations** (Create, Read, Update, Delete).
- Relational mapping between **MyList** and **Reminder** entities.

### 🧠 MVVM Architecture
The app is structured for scalability using **Model–View–ViewModel (MVVM)**:
- **Models** → Core Data entities (`MyList`, `Reminder`)
- **ViewModels** → Manage app logic and data flow for each screen
  - `HomeViewModel`
  - `MyListViewModel`
  - `MyListDetailViewModel`
  - `ReminderListViewModel`
  - `ReminderDetailViewModel`
  - `AddNewListViewModel`
- **Views** → Declarative SwiftUI components using `@StateObject`, `@Binding`, and `@FetchRequest`.

### 🔔 Notifications
- Integrates with **UNUserNotificationCenter** for scheduling and managing local reminders.
- Each reminder can trigger a system notification at its set time.

### 🎨 UI Highlights
- Adaptive dark/light mode with custom colors.
- Large navigation titles and modern SwiftUI layout.
- Custom components:
  - `ReminderCellView`
  - `ReminderStatView`
  - `ColorPickerView`
  - `MyListCellView`
- Uses SF Symbols for icons and system typography for a native iOS feel.

---

## 🧩 Project Structure
ReminderClone/
├── CoreData/
│   ├── CoreDataProvider.swift
│   ├── MyList+CoreDataClass.swift
│   └── Reminder+CoreDataClass.swift
│
├── Models/
│   ├── ReminderStatsValues.swift
│   ├── ReminderEditConfig.swift
│   ├── Userdata.swift
│
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── MyListViewModel.swift
│   ├── MyListDetailViewModel.swift
│   ├── ReminderListViewModel.swift
│   ├── ReminderDetailViewModel.swift
│   └── AddNewListViewModel.swift
│
├── Views/
│   ├── HomeView.swift
│   ├── MyListView.swift
│   ├── MyListDetailView.swift
│   ├── ReminderListView.swift
│   ├── ReminderDetailView.swift
│   └── AddNewListView.swift
│
├── Services/
│   ├── ReminderService.swift
│   └── NotificationManager.swift
│
└── Resources/
└── Assets.xcassets

---

## ⚙️ Requirements

- **Xcode 15+**
- **iOS 17+**
- **Swift 5.9+**
- **Core Data Framework**
- **UserNotifications Framework**

---
