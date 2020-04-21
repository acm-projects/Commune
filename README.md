# Commune
Mobile app that simplifies the shared living experience between roommates through chore tracking and bill expense tracking. 

## Key Features

> Each user will have access to comment on, view, create, and manage the household duties after the approval of all users/admin.
> Users will have deadlines to complete each task and will mark the completion of a task. 
> The application will also maintain a history of completed tasks for future reference.
> The app may also automatically delegate tasks based off of past assignment patterns.

### MVP (Minimum Viable Product)
- Completed tasks will be displayed as a list and added to a history of tasks
- Individual profile
- Household members with a possible admin option (members also have the ability to leave a household)
- Household profile
- Active and completed tasks
- Manually assign tasks to different users
- *Tasks:* Type (chore, bill, misc.), date assigned, deadline, delegate, state of completion

### Additional Features - Stretch Goals
- Commenting feature on assigned tasks
- Budget for a household
- Calculation for household spending based off of bills
- Manually create tasks based off of a pattern such as assigning a weekly task to a user
- Automatic task generation based off of user patterns
- Calendar view with tasks, completion status, and due dates
- Reminders to notify users of an upcoming deadline (push notification system)
- Roommate Ratings to rate other household members
- Leaderboard to motivate users to complete household tasks

## Dependencies

### Flutter
> Flutter may be used over Android Studio for cross-platform compatibility and cleaner design.

Install [Flutter](https://flutter.dev/docs/get-started/install)

#### Additional Resources for setting up Flutter for Android Dev
- Setting up [Flutter for Android development](https://flutter.dev/docs/get-started/flutter-for/android-devs)

### Android Studio *(Option)*
> Android Studio may be used over Flutter for more beginner-friendly implementation of Firebase.

Install by following the guidelines [here](https://developer.android.com/studio)

### Firebase
> Firebase will be used to form user groups based on household, manage personal user accounts through email, and create personal passwords in addition to a household database.

Set up a [project](https://firebase.google.com/docs/guides/)
Follow these guidelines to use the [Firebase CLI](https://firebase.google.com/docs/cli#install-cli-windows)

## Resources
*Below are some resources to help overcome possible roadblocks during the project*

##### Combining front-end (Flutter/Android Studio) with back-end (Firebase)
- Flutter and Firebase: [Youtube playlist by Net Ninja](https://www.youtube.com/watch?v=sfA3NWDBPZ4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC)
- Android Studio and Firebase: [Integrate](https://www.geeksforgeeks.org/adding-firebase-to-android-app/)
	- [Connect to Firebase](https://developer.android.com/studio/write/firebase)
	- [Installation and Set-up](https://firebase.google.com/docs/database/android/start)

##### Setting up user groups/profiles in Firebase
- Profiles: Basic [Set-up](https://firebase.google.com/docs/auth/web/manage-users)
- User Groups: Secure Data access for [users and groups](https://firebase.google.com/docs/firestore/solutions/role-based-access) and user Groups in [Firebase](https://www.youtube.com/watch?v=vy8jn-9yyt4)

##### Real-time chat within Firebase
- [Link](https://www.raywenderlich.com/5359-firebase-tutorial-real-time-chat) to website
- [Video](https://www.youtube.com/watch?v=wVCz1a3ogqk) Tutorial

##### Firebase Authentication using Android Studio and Firebase Basics for User Authentication
- [Authentication](https://firebase.google.com/docs/auth/)
- [Password-based Accounts](https://firebase.google.com/docs/auth/android/password-auth)
- [Basics for User Authentication in Firebase](https://www.youtube.com/watch?v=aN1LnNq4z54&list=PL4cUxeGkcC9jUPIes_B8vRjn1_GaplOPQ)
