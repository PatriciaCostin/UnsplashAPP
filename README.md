# Unsplash-API

UnsplashApp is a photo browsing and liking application leveraging the Unsplash API for photo-related functionalities. The app follows the [Model-View-ViewModel (MVVM) ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")architecture and coordination between different sections of the app is handled with the help of Coordinators.

1. **Authentication Module**: This module handles user registration and login. It includes screens for initial authentication (Welcome screen), login, account creation, and password recovery. Each screen has a Model, View, and ViewModel in compliance with the [MVVM](https://www.youtube.com/watch?v=sLHVxnRS75w "‌") pattern.
2. **Browse Module**: The Browse module provides the main functionality of the app: browsing photos, liking photos, viewing liked photos, and changing settings. It includes screens for the root tab bar view controller, browse screen, picture details, likes screen, settings, and password change screen. This module too adheres to the [MVVM ](https://www.youtube.com/watch?v=sLHVxnRS75w "‌")pattern.

The application is built using Swift and leverages Apple's UIKit for the user interface. For data persistence, it uses Keychain for user credentials and Core Data for storing liked photos. The app communicates with the Unsplash API to fetch and search photos. For the layout, it uses native UI components, including UITableView and UICollectionView, and uses SFSymbols for icons. For network communications, it uses URLSession APIs, and for JSON decoding it uses Swift's Codable protocol.

## Architecture

The architecture is a modified MVVM (Model-View-ViewModel) that includes Coordinators. The core components of the architecture are as follows:

- **Model**: Represents data and business logic.
- **View**: Displays the visual elements and controls on screen. In the context of this architecture, this corresponds to the UIViewControllers.
- **ViewModel**: Acts as a bridge between the Model and the View. It's responsible for transforming the data from the Model to values that can be displayed on a View.
- **Coordinator**: Handles navigation within the app. It decides when and where to navigate based on the events it receives from the view controllers.

## Directory Structure

- **Models**: All your data structures and entities.
- **Views**: Contains all your UIViewControllers and their corresponding views.
- **ViewModels**: Contains all the logic for preparing data to be displayed in a View.
- **Coordinators**: Responsible for handling navigation logic within the app.
- **Factories**: Used for dependency injection and creating instances of view controllers and view models.
- **Protocols**: All your protocol definitions.

## Initialization and Usage

### Coordinators

Each flow within the app should have its own Coordinator. A Coordinator takes a UINavigationController upon initialization and this UINavigationController is used to control the navigation flow.

Coordinators have a `delegate` property, which is notified when a significant event occurs, such as when the user successfully authenticates.

When creating a new Coordinator:

1. Define a protocol for the Coordinator's delegate to adopt.
2. Initialize the Coordinator with a UINavigationController.
3. Define methods for each navigation action that can occur.

### ViewControllers

Each ViewController should correspond to a View protocol and should communicate with its Coordinator via a delegate property. It should also have a ViewModel to handle any necessary data transformations.

When creating a new ViewController:

1. Define a protocol for the ViewController's delegate (the Coordinator) to adopt.
2. Define a protocol for the ViewModel the ViewController will use.
3. Initialize the ViewController with a ViewModel.

### ViewModels

ViewModels handle data transformation for ViewControllers. They should not have any knowledge of the UIViewControllers.

When creating a new ViewModel:

1. Define a protocol for the ViewModel.
2. Implement the ViewModel.

### Factories

Factories handle the creation and injection of dependencies for your ViewControllers and ViewModels. For every ViewController and ViewModel pair, there should be a corresponding Factory.

When creating a new Factory:

1. Define a static create function.
2. Initialize your ViewModel.
3. Initialize your ViewController with the ViewModel.
4. Return the ViewController.

## SwiftLint

The project uses [SwiftLint](https://github.com/realm/SwiftLint) to ensure that the code adheres to the agreed style and standards. You can see the detailed rules in the [SwiftLint Rule Directory](https://realm.github.io/SwiftLint/rule-directory.html). If any issues are found, you will need to resolve them before resubmitting your PR.

## Guidelines for Pull Request

1. **Branch Name**: The branch name should follow this format: `UNSPLASH-XXX-Task-title`, where `XXX` is the number of the ticket you're working on. If the branch name doesn't follow this format, you'll need to change it and resubmit your PR.

2. **PR Title**: The PR title should follow this format: `[UNSPLASH-XXX] Task title`, where `XXX` is the ticket number. If the PR title doesn't follow this format, you'll need to change it and resubmit your PR.

3. **PR Description**: The PR description should provide a summary of what changes your PR includes. If the description doesn't contain a summary, you'll need to add one and resubmit your PR.

#### Target Branch

The target branch for PRs should be `develop`.

#### Deployment Target

The required deployment target should be set to iOS 15.0

#### Default Implementation 

Check for unused default implementation code in your PR and remove it before submitting.

#### Magic Numbers

Avoid using magic numbers (explicit numerical values without any contextual explanation) in your code. If you use them, it's recommended to declare these values as constants within a dedicated `Constants` class. If your code contains magic numbers, you should move these numbers to a `Constants.swift` file.

#### Non-final Classes

It's recommended to mark classes with the `final` keyword in Swift to prevent unintended subclassing and improve code safety. If any non-final class is found, consider marking it as 'final'. For more about using the `final` keyword in Swift, refer to [this article](https://stevenpcurtis.medium.com/your-swift-classes-should-be-final-78cb41b79da0).

These are the general guidelines for creating a PR for this project. PRs that don't adhere to these rules will not be approved until they are rectified.

