# UnsplashApp

UnsplashApp is a photo browsing and liking application leveraging the Unsplash API for photo-related functionalities. The app follows the [Model-View-ViewModel (MVVM) ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")architecture and coordination between different sections of the app is handled with the help of Coordinators.

1. **Authentication Module**: This module handles user registration and login. It includes screens for initial authentication (Welcome screen), login, account creation, and password recovery. Each screen has a Model, View, and ViewModel in compliance with the [MVVM](https://www.youtube.com/watch?v=sLHVxnRS75w "‌") pattern.
2. **Browse Module**: The Browse module provides the main functionality of the app: browsing photos, liking photos, viewing liked photos, and changing settings. It includes screens for the root tab bar view controller, browse screen, picture details, likes screen, settings, and password change screen. This module too adheres to the [MVVM ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")pattern.

The application is built using Swift and leverages Apple's UIKit for the user interface. For data persistence, it uses Keychain for user credentials and Core Data for storing liked photos. The app communicates with the Unsplash API to fetch and search photos. For the layout, it uses native UI components, including UITableView and UICollectionView, and uses SFSymbols for icons. For network communications, it uses URLSession APIs, and for JSON decoding it uses Swift's Codable protocol.

![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 45](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/bae774b4-964c-456f-8efe-6d8748233c29)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 27 26](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/80e02da7-f1b9-4b34-9aa0-6f1cf157f635)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 11](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/c63098cc-5e6f-4b3f-911e-08208eb159e8)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 23](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/aae672d9-bd96-4a4b-b514-78a4f4add717)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 31](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/1808d1ee-2c35-4188-9c4e-de72e8dbaa73)
