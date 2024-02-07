# UnsplashApp

UnsplashApp is a photo browsing and liking application leveraging the Unsplash API for photo-related functionalities. The app follows the [Model-View-ViewModel (MVVM) ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")architecture and coordination between different sections of the app is handled with the help of Coordinators.

1. **Authentication Module**: This module handles user registration and login. It includes screens for initial authentication (Welcome screen), login, account creation, and password recovery. Each screen has a Model, View, and ViewModel in compliance with the [MVVM](https://www.youtube.com/watch?v=sLHVxnRS75w "‌") pattern.
2. **Browse Module**: The Browse module provides the main functionality of the app: browsing photos, liking photos, viewing liked photos, and changing settings. It includes screens for the root tab bar view controller, browse screen, picture details, likes screen, settings, and password change screen. This module too adheres to the [MVVM ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")pattern.

The application is built using Swift and leverages Apple's UIKit for the user interface. For data persistence, it uses Keychain for user credentials and Core Data for storing liked photos. The app communicates with the Unsplash API to fetch and search photos. For the layout, it uses native UI components, including UITableView and UICollectionView, and uses SFSymbols for icons. For network communications, it uses URLSession APIs, and for JSON decoding it uses Swift's Codable protocol.

![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 45](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/331f7ff9-c521-403e-8607-e9585a451d0c)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 27 26](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/8696b6f1-cf89-4a43-aedf-b8d8da8415ed)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 11](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/1a31e35c-c94f-44d8-9bea-b19bfe209aa7)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 23](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/c272b18d-aacd-46a7-ad8e-88f06d284aad)
![Simulator Screenshot - iPhone 15 Pro - 2024-02-07 at 14 28 31](https://github.com/PatriciaCostin/UnsplashApp/assets/124291922/e448da1d-a22f-4799-85f6-1d10c0512ffb)
