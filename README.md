# Task Management


Task management application is basically use for managing out daily task. User need to add project first before adding task. So this way user can manage their daily routine work.
So it will be easier for user to set priority and set their work.

## Features

  * Sign up
      *  Before you want to use application functionality you need to sign up first with first name, last name, mobile, email , password and user role.
  * Sign In
      *  If you log out your application and you have credentials email and password. So you can sign in with email and password.
  * Forgot password
      *  If you forgot your password then you need to enter email (Only work with radix email). After enter email in you will receive 6 digit code.
  * Reset password
      *  After adding email for reset password you will redirect to reset password screen. Here you have to enter 6 digit code tat you received in your            email id with password. So you can reset your password easily.
  * Home Screen
      *  In this Home Screen we provide list of task that user added. There 2 tab is there today and month. By default today tab is selected, here you can          show your todays task list. If you are select month tab, then there is one cancel list is there you can choose the date for show the                      task list for particular date. Here in app bar one drop down menu is there in that menu provide 3 option. 1). Completed task 2). 						              InCompleted Task 3). All tasks. By default all task menu is selected. You can filter your task according completed and incomplete task list. In            bottom bar provide 4 type of tab. By default home tab is  selected. Another 3 tab is project tab, note tab and profile tab. Here one                      add floating fab button will be there. On taping that button 3 button coming in circular animation. 1). First for add task. 2). Add note 				          3) Add checklist.
  *  Add Project
      *   In this project screen list of project showing that user has added. Also there one add button for adding new project. You can add project with             project name , description and colour(For showing that item colour). In project list there is 3 icon button for edit and delete                           project. If you click on edit button bottom sheet will open for edit that project. On delete button if you click there is show one alert for               taking user confirmation for deleting project.
  * Edit Project
      * If you click on edit project button you can edit that project with title, description and colour also.
  * Delete Project
      * If you click on the delete project there is one alert dialog for taking user confirmation to delete the project.
  * Add Task
      * In this add task screen you can add your task with task name, description, project name (There is one drop down for in which project you want to           add your task.) , comment, start date and estimated end date. After adding task you can see that task in your Home Screen. In Home Screen                 list of task with slidable edit and delete option provide to edit and delete task.
  * Edit Task
      * If you click on edit task you will redirect to edit task screen you can edit that task with title , description, project name, If you completed           that task choose completed else by default it selected incomplete task. That update task you can see in Home Screen.
  * Delete Task
      * If you click on delete task button you can see the dialog for tasking confirmation from user to delete that task.
  * Add Note
      * In Home Screen in centre add button , if you select add note you will redirect to add note screen. Here you can add your note with title and               description. Added notes you can show in note tab bar.
  * Edit Note
      * In note screen you can see list of notes are there here 2 icon button provided for edit and delete note. On click on edit note one bottom sheet           will open for edit title and description for edit that note. Updated  note you will see in note screen.
  * Delete Note
      * If you click on delete button in list of note screen there will be one alert dialog open for getting user confirmation for deleting that                   particular note. After deleting note you can see the updated note list in note screen.
  * Profile screen
      * In Profile screen you can see your information of name, email, profile picture, mobile number as well as with no of task you have created , no of         task you completed, no of noted you have added with user status. Here on update profile option is there so you can update your profile.
  * Update Profile
      * On click on update profile button you will redirect to one screen here you can update your user information with first name, last name, email,             profile picture, mobile number after updating successfully you can see your updated information in profile screen.
  * Log out
      * In Profile screen in top up one log out button is there you will log out after click on that button and you will reach to log in screen.

## Approach
- Used clean architecture with bloc pattern for implementing task management project.

## Naming Conventions


- Folder Name : your_folder_name
- File Name : your_file_name.dart
- Start File in Each Folder: index.dart
- Class Name : YourClassName
- Variable Name : yourVariableName
- Private Variable : \_yourPrivateVariable
- Constant Variable Name : CONSTANT_VARIABLE_NAME
- Function Name : yourFunctionName
- Private Function Name : \_yourPrivateFunctionName



## Commit Format


- :tada: initial commit.

- :rocket: [Add] when implementing a new feature. 

- :hammer: [Fix] when fixing a bug or issue. 

- :art: [Refactor] when refactor/improving code. 

- :construction: [WIP]- when the particular task is still under process.

- :pencil: [Minor] Some small updates.


## Git Branch Naming Conventions


```
- New feature: feature/feat-oct11-jira-ticket-number
- Bug: bug/bug-oct11-jira-ticket-number
- Documentation: doc-oct11-jira-ticket-number
- Code Improvement: refact-oct11-jira-ticket-number
- Any Other: minor-oct11-jira-ticket-number
- Until your feature is completed, you will be working in the same branch. We will get PR's from same branch at EOD,everyday.
- If started with new feature on new branch & has some dependency with last day's branch (If the branch is still not merged yet) then you are free to take pull from your own last day branch (This is only applicable for preceeding day)
```

## How to run a project
Use below command to run project based on your requirement
- Clone project from git.
- Run command in terminal ```flutter pub get ```
- After that run this command ```flutter packages pub run build_runner build --delete-conflicting-outputs``` for generate .g.dart file
- For development debug: ```flutter run -t lib/main.dart```

## How to generate apk/ipa for project
Use below command to generate apk/ipa of project based on your requirement
- For development apk: ```flutter build apk -t lib/main.dart```
- For development ipa: ```flutter build ipa -t lib/main.dart```

## Directory Structure

```s
├── lib
│   ├── core
│   │   ├── api_call
│   │   │   ├── api_constant.dart
│   │   │   ├── base_response.dart
│   │   │   ├── baseClient.dart
│   │   │   ├── baseClient.g.dart
│   │   │   └── custom_dio_client.dart
│   │   ├── base
│   │   │   ├── base_bloc.dart
│   │   │   ├── base_event.dart
│   │   │   └── base_state.dart
│   │   ├── failure
│   │   │   ├── exceptions.dart
│   │   │   └── failure.dart
│   │   ├── Strings
│   │   │   └── strings.dart
│   │   └── usecase.dart
│   ├── custom
│   │   ├── curve_painter.dart
│   │   ├── custom_progress_painter.dart
│   │   └── progress_bar.dart
│   ├── features
│   │   └── login
│   │       ├── data
│   │       │   ├── datasource
│   │       │   ├── model
│   │       │   └── repositories
│   │       ├── domain
│   │       │   ├── entities
│   │       │   ├── repositories
│   │       │   └── usecases
│   │       └── presentation
│   │           ├── bloc
│   │           └── pages
│   ├── onboarding
│   │   └── onboarding.dart
│   ├── ui
│   │   ├── home
│   │   │   ├── fab_menu_option
│   │   │   │   ├── add_note
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   │   ├── add_task
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   ├── pages
│   │   │   │   ├── add_member
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   │   ├── comment
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   │   ├── Profile
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   │   ├── Project
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── pages
│   │   │   │   ├── tag
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       ├── bloc
│   │   │   │   │       └── presentation
│   │   │   │   ├── user_status
│   │   │   │   │   ├── data
│   │   │   │   │   │   ├── datasource
│   │   │   │   │   │   ├── model
│   │   │   │   │   │   └── repositories
│   │   │   │   │   ├── domain
│   │   │   │   │   │   ├── repositories
│   │   │   │   │   │   └── usecases
│   │   │   │   │   └── presentation
│   │   │   │   │       └── bloc
│   │   │   ├── task
│   │   │   ├── home.dart
│   │   └── splash.dart
│   ├── utils
│   │   ├── border.dart
│   │   ├── calendar_tile.dart
│   │   ├── calendar.dart
│   │   ├── color_extension.dart
│   │   ├── colors.dart
│   │   ├── device_file.dart
│   │   ├── simple_gesture_detector.dart
│   │   └── style.dart
│   ├── widget
│   │   ├── appbar.dart
│   │   ├── button.dart
│   │   ├── decoration.dart
│   │   ├── home_appbar.dart
│   │   ├── profile_pi.dart
│   │   ├── rounded_corner_page.dart
│   │   ├── size.dart
│   │   ├── task_list.dart
│   │   └── textfield.dart
│   ├── injection_container.dart
│   └── main.dart
├── test
│   └── widget_test.dart
├── pubspec.lock
├── pubspec.yaml
└── README.md
```






