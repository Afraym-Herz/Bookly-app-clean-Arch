# Clean Architecture

##  has two main folders is Core folder and Feature folder

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

   Purpose : see line 24

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
   
   Purpose : see line 34

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
   
   Purpose : see line 45


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

######      best_seller_list_view_item : 

       *      

##  Search

  - it is the screen search view that we search about the books and it shows when we click on magnifiy glass
  - this screen just contain the presentation folder because we didn't foucs about this feature we focus about architecture

###   presentation : 

   - Purpose : seel line 45

####    views :

    - Purpose : see line 236

#####     widgets : 

     - Purpose : see line 240

######      custom_search_text_field : 
  
      


### Data

#### data Sources

#### Models

#### Repos



### Domain

#### Entites

#### abstract Repos

#### Use Cases



### Presentation

#### Manager

##### Cubits

###### States of Cubit 

###### Cubit Functions

#### Views




## Splash



### Data

#### data Sources

#### Models

#### Repos



### Domain

#### Entites

#### abstract Repos

#### Use Cases



### Presentation

#### Manager

##### Cubits

###### States of Cubit 

###### Cubit Functions

#### Views

