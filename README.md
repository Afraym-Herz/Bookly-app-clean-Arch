# Clean Architecture

## Main Folders is Core folder and Feature folder ( MAIN SECTION ) :


## NOTE : we focus in our project about clean architecture so we don't focus in each screen and don't deal with API that's not real world project


## Core :

- Purpose : The core folder contains code that is shared across the entire app and not specific to any feature. It’s like the toolbox and foundation for the whole project.

- it divided into 3 foldres in our project but can contain different files like constants , Api_services , exceptions , routing , widgets , functions and any component that use in all features not specific to one features 



## Features :

- Purpose : Contains modular, isolated units of functionality — each "feature" of the app (e.g., Home, Auth, Search) is in its own folder, implementing clean architecture inside.

- that is architecutre of our only one feature 
    features/
       └── home/
            ├── data/
            ├── domain/
            └── presentation/ 

- 1 - Data Folder :

* Purpose : Implements the data logic — how and where we get data (API, local DB), and how it is transformed.

* Contain : models , data sources and repository_impl.dart (file)

* Rule: This layer depends on external packages (http, hive), but should not know anything about Flutter or UI.



- 2 - Damain Folder :

* Purpose : Contains the core business logic of the feature. It’s the heart of clean architecture — completely independent of Flutter, HTTP, Hive, etc.

* Contain : entities , repositories and Use Cases 

* Rule: This layer is pure Dart logic — no plugins, no UI, just rules.


- 1 - Presentation Folder :

* Purpose : Builds the UI and handles state management. Talks to domain layer through use cases and shows results to the user.

* Contain : screens , widgets , State management logic (bloc , cubit or provider) 

* Rule: This layer depends on flutter, flutter_bloc, or provider, but never directly calls APIs — it goes through use cases.



## Full Data Flow Example : 

   UI (presentation/home_screen.dart)
   ↓ calls
   Cubit → UseCase (domain/fetch_books_usecase.dart)
   ↓ calls
   Repository (domain/home_repository.dart)
   ↓ implemented by
   HomeRepoImpl (data/home_repository_impl.dart)
   ↓ uses
   HomeRemoteDataSource + HomeLocalDataSource (data/datasource/)
   ↓ use
   ApiServices / Hive (core/)







# Core

##  Utils :

- Purpose:
The utils folder contains general-purpose helper functions, classes, or constants that don’t belong to a specific layer (Presentation, Domain, Data) but are reused across the app.

- 1 - api_services file :

    * using to get request from the internet and dealing with the package which we use to get Data from Api (in our case it is Dio)
    * contain baseUrl (var) has url to use functions of api
    * in our project we use only function get by dio package
    * we accept it in constructor because when the package was changed we can change in all Project
    * get (fun) accepted endPoint (string) and return response.data (map<string , dynamic>)

- 2 - app_router file :

    * its useful is to make route simble in app
    * by using go_router package we add path (we make it to be pointer of screen) and object of screen

- 3 - assets file :

    * its useful is saving paths of images we use in app


- 4 - styles file :

    * its useful is saving styles of fonts in all app

###   Functions folder :

      - Purpose : 
      to save functions which we use in different places in app
      
      ~ errorSnackBar (to send error message to user) 
      ~ getItServicesLocator (to set constructor for api services and HomeRepoImpl ) 
      ~ getParseBooks (to parse book map to list) 
      ~ saveBooksData (to save all books in local data bu send list and key of box)



##  widgets :

- Purpose : 
    to allocate all widgets that we will reuse in app

- 1 - custom_button widget :
    is specific button accepted parameters like border , background color , text , textColor and fontsize we use in application 

##  Use case :

- Purpose : 
   abstract class use in different places in our app will extneded and implement the call function to check if the operation gone successfully will send books list else send faliure 

##  Errors :

- Purpose : 
    collect all files which related with the exceptions

- 1 - faliure file :
    * contain all the exceptions of API and status of response from API 
    * has two sides from Dio error and from response error 
    * each exception has specific message




# Features

##  Home :

- it is the screen of home and all component of it 

###   Data :

   Purpose : see Data Folder in Feature (main section) ↑↑

####    data Sources :

    Purpose : to contain the two main source of data ( reomte and local )

#####     home_remote_data_source file :

      * fetch books from Api to two lists by two functions  
      * by get (fun) in Api_services we send query of endPoints and pageNum ( by deafault is 0 and increase when fet      again ) is to get in each fetch 10 books and parse books by parseBooks (fun) 
      * after parse we save the books in local database by saveBooksData (fun) look in core\utils\functions
      * the difference between functions exists in the query (q parameter)

#####     home_local_data_source file : 

      * we set two int start , end indexes two determine the slide in the local box (hive box)
      * we create box (var) to contain box of books in local storage and if length of indexes is not greater than lenghof  books
      * in box we access values and turn them to list and get sublist from it by start and end indexs          

####    Models :

      ~ its purpose to collect all models from api to save it to be easy to use 
      ~ all models to serve the main model that its name is book_model.dart

####    Repos :

#####     home_repo_impl : 

      * is implementation of home_repo (abstract class) in domain layer (domain/repos/home_repo)
      * has 2 functinos with two options of return
      * to fetch books they check if books exist in local database by home_local_data_source class and fetchBooks (fun) will return them(left option) , else if not exist in local database fetch books by home_remote_data_source classand fetchBooks(fun) from Api(left option) else exist any problems will return exception (right option)
      * the difference between two functions is the place that they will show 

####    Use_cases :

      ~ it have two files with the same method but different in the place that will use 
      ~ in two files give you 2 options get books successfully (left side) and exist exception (right side)



###   Domain :
   
   Purpose : see Domain Folder in Feature (main section) ↑↑

####    Entites folder :
    
    Purpose : The entities folder holds pure Dart classes that represent core business models used across your app — independent of API, database, UI, or libraries.

    ~ entities make auto by Hive package with hive_generator and build_runner with all fields related with entities

####    abstract Repos folder :

     Purpose :   
     1 - The repository folder in the domain layer defines abstract contracts (interfaces) that describe what data operations the app needs without caring where or how the data comes from.
     2 - contian all abstract classes that must implemented in home screen

######     home_repo file : 

      * has two functions fetch[Featured , BestSeller]books that you must be implemented in home screen's lists of books     


####    Use Cases folder :
     
     Purpose : to make two cases for two fetch books functions 
     
     ~ set faliure and successful cases for each function by dartz package 
     ~ if fetch done function will return books else return exception


###   Presentation :
   
   Purpose : see Presenation Folder in Feature (main section) ↑↑


####    Manager :
     
     Purpose : To manage the state, logic, and coordination between the UI and the domain layer (like calling use cases and handling results)

#####     Cubits :
     
     Purpose : 	Keeps UI clean and focused on rendering , Interacts with ( use cases and repositories ) and Handles multiple loading states (one per Cubit) without blocking the whole screen 

     ~ we have two Cubits in our app ( for best_seller list books and featured list books )
     ~ if we want to update or change the lists isolate without rebuild all screen we must deal with the list's cubit
     
      

######      States of Cubit :
        
       - it is the four main states is initial , loading , success and faliure 
       - in each state we make a specific operation  :
       in loading we emit this state to make the loading circule working , in success we return the list of books and in faliure we return custom error

######      Cubit Functions :
      
      Purpose : 
      1 - To handle business or UI-related logic, perform async operations (like fetching data), and emit states that the UI can respond to. 
      2 - have another jops like Manage State Transitions , Handle Asynchronous Logic , Separate Logic from UI , Connect to Domain Layer and Centralize Feature Logic 


      - we have separate cubit for each list (or function) to make the maintain and testing more easible 
      - first we send loading state , then call the function which fetch the books and save it in books (var) if the fetch go well will send books with emit the successful state else we send exception with faliure state
        


####    Views :
     
     Purpose : The views folder holds the screens (pages) that make up the visual interface of your feature — it's what the user sees and interacts with. and save all widgets and screens which used to build the UI

#####     Widgets folder : 
      
      Purpose : 
      1 - save and contian all widgets we use in screen 
      2 - make maintain the screen very easy and connect all widgets with other clearly 


######      custom_app_bar :
       
       * we put the logo of app in start by image.asset , add spacer to make the glass be in the end of screen 
       * be the glass as icon button and its function is go to search view (we use goRouter package) 

######      custom_book_image (widget) in item file :  
       
       * make it in GestureDetector to make it button and if click on it go to detils of book
       * use AspectRatio (widget) to set aspect ratio between width and height (2.6/4) for our image 
       * use ClibRRect to make circule border for image 
       
######      featured_list_view : 
       
       * it is stateful widget because its state can change 
       * first we make object from ScrollController to use its functions in the featured list books
       * we accepted the list of books (books) that will display and init ScrollController (in init function) and nextPage (int will increase and send it each time which we get new books ) 
       * _scroll_listner is method active when the size of scrollable list reach to 0.7 from its maximum , then will call fetchFeaturedBooks (fun) from blocProvider and increase nexpPage by one to next call 
       * dispose ScrollControler after exit from home view

       * we use mediaQuere (widget) to get 0.3 of any screen's height 
       * use listView.builder and add ScrollControler in controller to active it

######       featured_books_list_view_bloc_bulider :

       * it is the cubit of this featured_books_list ( manager for this list ) 
       * we use blocConsumer (that has both listner and builder ) 
       * in listner : success state -> add accepted list to books list (empty list) , faliure state : display showSnackbar
       * in builder : success state -> return FeaturedBooksListView with books (list) , faliure state : return errMessage

######       book_rating : 
       
       * it is just a row contain solid star and test text for rating but in actually we must get it from API 



######      best_seller_list_view_item : 

        * make it in GestureDetector to make it button and if click on it go to detils of book     
        * use AspectRatio (widget) to set aspect ratio between width and height (2.6/4) for our image 
        * this time we use Container to make circule border for image and get BoxDecoration and set image by assets and fit it for all space
        * in right of it the description of books. it is column contain name of book with set maximum two lines if be more than two line it set three point that mean exist more details and use media query to make font responsive
        * and add another details and add BooksRating widget

######      best_seller_list_view : 
        
        * it is listview.builder to build items when we need not all at once 
        * in parameter physics we set NeverScrollableScrollPhysics that prevent the list to have independent scroll behavior we want feature_list_view and best_seller_list_view have same behavior of scroll in home_view_body by CustomScrollView
        
######      home_view_body :
        
        * it is CustomScrollView because we want the feature_list_view and best_seller_list_view scroll as the one list so we make them Slivers
        * in first we put featured_list_view in column and put in it custom_app_bar , featured_books_list_view_blocBulider and text ('Best Seller') is precedes of best_seller_books_list_view 
        * we put best_seller_books_list_view in the end of custom_list_view and set column of feature_list_view and other widgets as SliverToBoxAdaptor because we make it with fixed height ( or percentage of height of mediaQuere ) and set best_seller_list_view as SliverFillRemaining to fill all space that it needs to set all its elements

######      home_view (main widget of home screen) : 

        * it is the entry point of home screen that contain Scaffold 


######      custom_book_details_app_bar : 
        
        * it is simple row has two icons close and shopping_cart_outlined  
        * set close in start and shopping_cart_outlined in the end by spaceBetween 

######      books_action : 

        * it is row contain two custom button with specific styles and borders , their loctions is center
        * first button is price and its functions is to move to screen for buy 
        * second button is free preview to review part of book before buy it 

######      body_details_section : 
        
        * it is column contain  custom_book_item , name of book , books_rating and books_action in the end

######      similar_books_list_view :

        * it is horizontal list that located in screen of book details 
        * we put it in sized box with (0.15 of screen height) and its child is custom_book_item

######      book_details_view_body (main widget of details) :

        * we set this widget as CustomScrollView because we want use sliverFillRemaining to use all available space and dealing with mixed static + scrollable content so CustomScrollView it is perfect solution .
        * inside SliverFillRemaining we set columns contains custom_book_details_app_bar , body_details_section and similar_books_list_view

######      book_details_view (main widget of book_details screen) : 

        * it is the entry point of body screen that contain Scaffold


##  Search

  - it is the screen search view that we search about the books and it shows when we click on magnifiy glass
  - this screen just contain the presentation folder because we didn't foucs about this feature we focus about architecture

###   presentation : 

   - Purpose : see Presentation Folder in Feature (main section) ↑↑

####    views :

    - Purpose : The views folder holds the screens (pages) that make up the visual interface of your feature — it's what the user sees and interacts with. and save all widgets and screens which used to build the UI see the definiation in  Presentation-manager-cubits-Cuibts Functions 

#####     widgets : 

     - Purpose : 
      1 - save and contian all widgets we use in screen 
      2 - make maintain the screen very easy and connect all widgets with other clearly 

######      custom_search_text_field : 
  
      * it is simple TextField with outLinedInputBorder and magnifyingGlass icon in the end 
      * we put InputBorder in external function to be easy to use

######      search_result_list_view :

      * it is vertical list view to show the result of search
      
######      search_view_body (main widget for search screen) :

      * it is column that contain custom_search_text_field , description and search_result_list_view

######      search_view (main widget of search screen) : 

        * it is the entry point of search screen that contain Scaffold 



##  Splash 

###   presentation : 

   - Purpose : see Presentation Folder in Feature (main section) ↑↑

####    views :

    - Purpose : The views folder holds the screens (pages) that make up the visual interface of your feature — it's what the user sees and interacts with. and save all widgets and screens which used to build the UI see the definiation in  Presentation-manager-cubits-Cuibts Functions 

#####     widgets : 

     - Purpose : 
      1 - save and contian all widgets we use in screen 
      2 - make maintain the screen very easy and connect all widgets with other clearly

######     sliding_text :

            * This is a stateless widget that receives an Animation<Offset> called slidingAnimation.
            * Offset is used for position-based animation — perfect for slide transitions.
            * AnimatedBuilder Listens to the animation (slidingAnimation) and rebuilds whenever the animation value changes.
            * Keeps performance optimized by only rebuilding what's necessary.
            * SlideTransition is a built-in Flutter widget that animates its child's position based on an Offset animation ,It applies a translation effect (moving along x or y axis).
            * If Offset(0, 2) → the widget starts 2 units down as it animates to Offset.zero, it slides up into place.
            
######      splash_view_body : 

            * SingleTickerProviderStateMixin is This provides a single "ticker" (basically a clock) for the animation controller , Required when using AnimationController.
            * initState() is first thing that runs
            * initSlidingAnimation() : Tween<Offset> Defines the start and end point of the animation 
            Offset(0, 2) Means the text is 2 "screens" down (vertically) ,
            Offset.zero Final position (no offset) ,
            animate(...) Creates the animated value ,
            forward() Triggers the animation.

######      splash_view (main widget for splash screen) : 

            * it is the scaffold for splash screen 

