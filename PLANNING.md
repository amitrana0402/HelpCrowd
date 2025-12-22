# Main Navigation Page - Planning Document

## Overview
Implement a main navigation page with 5 items in bottom navigation bar. Each item has a separate page/module. The center item (Profile) uses Icon 4 (Icons.person), while other items use PNG assets from AppImages.

## Navigation Structure

### Bottom Navigation Items (Left to Right)

1. **Home** (Index 0)
   - Icons: `nav_home.png` (unselected) / `nav_home_selected.png` (selected)
   - Route: `Routes.HOME`
   - Module: `modules/home/` (already exists)

2. **Transactions** (Index 1)
   - Icons: `nav_transaction.png` (unselected) / `nav_transaction_selected.png` (selected)
   - Route: `Routes.TRANSACTIONS` (new)
   - Module: `modules/transactions/` (to be created)

3. **Profile** (Index 2 - Center)
   - Icon: `Icons.person` (Material Icon, size: 24)
   - Route: `Routes.PROFILE` (new)
   - Module: `modules/profile/` (to be created)
   - Note: Uses icon 4 (Icons.person) as specified

4. **Notifications** (Index 3)
   - Icons: `nav_notification.png` (unselected) / `nav_notification_selected.png` (selected)
   - Route: `Routes.NOTIFICATIONS` (new)
   - Module: `modules/notifications/` (to be created)

5. **Settings** (Index 4)
   - Icons: `nav_setting.png` (unselected) / `nav_setting_selected.png` (selected)
   - Route: `Routes.SETTINGS` (new)
   - Module: `modules/settings/` (to be created)

## Implementation Plan

### Phase 1: Update Constants
- ✅ Update `AppImages` class with navigation icons (already done)

### Phase 2: Create Main Navigation Module
- Create `modules/main_navigation/` directory structure:
  - `controllers/main_navigation_controller.dart`
  - `views/main_navigation_view.dart`
  - `bindings/main_navigation_binding.dart`

**Main Navigation Controller Responsibilities:**
- Manage current selected tab index (RxInt)
- Handle tab switching logic
- Keep track of navigation state

**Main Navigation View Structure:**
- Scaffold with IndexedStack or PageView for tab content
- Custom bottom navigation bar widget
- Each tab shows its corresponding page

### Phase 3: Create Missing Modules
Create placeholder modules for:
1. **Transactions Module** (`modules/transactions/`)
   - Controller, View, Binding
   - Placeholder content for now

2. **Profile Module** (`modules/profile/`)
   - Controller, View, Binding
   - Placeholder content for now

3. **Notifications Module** (`modules/notifications/`)
   - Controller, View, Binding
   - Placeholder content for now

4. **Settings Module** (`modules/settings/`)
   - Controller, View, Binding
   - Placeholder content for now

### Phase 4: Update Routes
- Add new route constants to `app_routes.dart`:
  - `MAIN_NAVIGATION`
  - `TRANSACTIONS`
  - `PROFILE`
  - `NOTIFICATIONS`
  - `SETTINGS`

- Add route definitions to `app_pages.dart`:
  - Main navigation as wrapper
  - Individual tab routes (optional, can use IndexedStack)

### Phase 5: Create Custom Bottom Navigation Bar Widget
- Create reusable widget: `widgets/bottom_nav_bar.dart`
- Features:
  - 5 items with custom icons
  - Selected/unselected states
  - Icon indicators for notifications (if needed)
  - Proper spacing and styling using AppColors

## Design Specifications

### Bottom Navigation Bar
- Height: ~60-70px
- Background: White
- Selected item: Use selected icon variant
- Unselected item: Use default icon variant
- Active indicator: Color from AppColors.primaryBlue
- Center item (Profile): Circular icon with Icons.person

### Icon Specifications
- Home: Image asset (nav_home.png / nav_home_selected.png)
- Transactions: Image asset (nav_transaction.png / nav_transaction_selected.png)
- Profile: Icons.person (center, circular)
- Notifications: Image asset (nav_notification.png / nav_notification_selected.png)
- Settings: Image asset (nav_setting.png / nav_setting_selected.png)

## File Structure

```
lib/app/modules/
├── main_navigation/           # Main navigation wrapper
│   ├── controllers/
│   │   └── main_navigation_controller.dart
│   ├── views/
│   │   └── main_navigation_view.dart
│   └── bindings/
│       └── main_navigation_binding.dart
├── home/                      # Already exists
├── transactions/              # To be created
│   ├── controllers/
│   │   └── transactions_controller.dart
│   ├── views/
│   │   └── transactions_view.dart
│   └── bindings/
│       └── transactions_binding.dart
├── profile/                   # To be created
│   ├── controllers/
│   │   └── profile_controller.dart
│   ├── views/
│   │   └── profile_view.dart
│   └── bindings/
│       └── profile_binding.dart
├── notifications/             # To be created
│   ├── controllers/
│   │   └── notifications_controller.dart
│   ├── views/
│   │   └── notifications_view.dart
│   └── bindings/
│       └── notifications_binding.dart
└── settings/                  # To be created
    ├── controllers/
    │   └── settings_controller.dart
    ├── views/
    │   └── settings_view.dart
    └── bindings/
        └── settings_binding.dart

lib/app/widgets/
└── bottom_nav_bar.dart        # Custom bottom navigation widget
```

## Technical Decisions

1. **State Management**: Use GetX reactive variables (RxInt for current index)
2. **Page Management**: Use IndexedStack to maintain state of all tabs
3. **Icon Handling**: 
   - PNG assets for 4 items (Home, Transactions, Notifications, Settings)
   - Material Icon for Profile (center item)
4. **Navigation**: Main navigation page wraps all tab pages
5. **Styling**: Follow existing patterns using AppColors and AppTextStyle

## Next Steps After Implementation

1. Implement actual content for each tab module
2. Add notification badges/indicators if needed
3. Handle deep linking to specific tabs
4. Add transition animations between tabs
5. Implement tab state persistence

