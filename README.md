# NewsApp - Swift - MVVM - Clean Architecture

This project is a simple example of using Swift with MVVM and Clean architecture for news related app.

## Features

- Login using an API key ([News.org](https://newsapi.org/))
- Fetch and display a list of news articles from the API ([News.org](https://newsapi.org/))
- Implement search, date selection, and sort by filters
- Allow switching between grid and list layouts for the article list
- Enable users to swipe to add/remove favorites for articles using core data (Favourite Screen with UITableView and Search Screen with UICollectionView)
- Display a badge on the tab bar indicating the number of favorite articles (Using userdefualts)
- Show a detailed view for each selected article (Open URL and Share Article Functionality)
- Provide an option to change the API key
- Allow users to log out of the app

## Screenshot
![splace](https://github.com/user-attachments/assets/0d89c089-94fd-45ca-adfc-93c9ba6f3217)
![login](https://github.com/user-attachments/assets/518ff848-58e5-4c55-a857-c05e4c6f42e5)
![Search](https://github.com/user-attachments/assets/ea8e9b0c-d0d1-4643-b1df-222bf072af1a)
![Searchwithgrid](https://github.com/user-attachments/assets/29ca823b-1e4c-4b44-91dd-fb9266a175ff)
![favourite](https://github.com/user-attachments/assets/369f99cd-e315-426c-88f1-32f74351bdb2)
![Setting](https://github.com/user-attachments/assets/5ad5db2f-0c1c-4ffa-b7ee-57362d730709)
![Changekey](https://github.com/user-attachments/assets/16078692-7635-4889-afee-7fd57c92c209)

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.0+

## Installation

1. Clone the repository:

   - https://github.com/DixPatel009/NewsApp.git

3. Open the project in Xcode:

   - open News.xcworkspace
  
4. Build and run the project on your preferred simulator or device.
   

## Architecture

The project follows the MVVM & Clean architecture pattern:

  - Model: Holds the data 
  - View: Views that display the data.
  - ViewModel: Manages the data for a view by interacting with the model and preparing the data for presentation in the view.
  - Repository: Responsible for interacting with the data.
  - ViewController: Manages the UIKit view and binds to ViewModel
  - Manager: Manage a functionality based on features
  - Constants: Holds the variables whose values can't be changed
  - Extension: Allow you to extend an existing class, struct, enumeration, or protocol with new functionality

## Project Structure

    News/
    ├── AppDelegate.swift  # Entry point of the app
    ├── Models/
    ├── ViewControllers/
    ├── ViewModels/
    ├── Views/
    ├── Repository/
    ├── Managers/
    ├── Extension/
    ├── Constants/
    ├── Utilities/
    ├── News.xcdatamodeld //Coredata 

## Acknowledgements

  - Swift Documentation
  - MVVM Architecture Patterns
  - Clean Architecture
  - Solid Principal

## Contact

  - For any questions or suggestions, please open an issue or contact akabaridixit009@gmail.com
