**This project is structured using the MVVM (Model-View-ViewModel) design pattern.**

Project Structure
**Model**: Contains the data models, including Dessert and DessertDetail.

**ViewModel**: Houses the DessertViewModel, which manages the app's data logic and business rules. This layer serves as the bridge between the models and views, preparing data for display and handling user input. The app pulls data asynchronously from an API, populating an array of desserts. Dessert details are fetched and populated as needed, and to enhance performance, these details are cached in a dictionary for quick access if the user revisits the same dessert.

**View**: Comprises the UI components, specifically DessertView and DessertDetailView. These views present the data to the user and reflect any updates made by the ViewModel.

**Utilities**: Includes the networking class and Enum file.
