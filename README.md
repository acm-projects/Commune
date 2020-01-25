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
- Household members with a possible admin option
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
- Reminders to notify users of an upcoming deadline

## Dependencies

### React Native
> React Native is preferred over Android Studio for cross-platform compatibility and cleaner design reasons.

Install [React Native](https://facebook.github.io/react-native/docs/getting-started) and follow the EXPO CLI Quickstart Guide
A brief intro to [Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)
*Javascript will primarily be used for the user interface.*

#### Additional Resources for setting up React Native
- Setting up a development environment in [Windows](https://codeburst.io/setting-up-development-environment-using-react-native-on-windows-dd240e69f776?gi=106808b677dc)

### Android Studio *(Option)*
Install by following the guidelines [here](https://developer.android.com/studio)

### Firebase
> Firebase will be used to form user groups based on household, manage personal user accounts through email, and create personal passwords in addition to a household database.

Set up a [project](https://firebase.google.com/docs/guides/)
Follow these guidelines to use the [Firebase CLI](https://firebase.google.com/docs/cli#install-cli-windows)

## Resources
*Below are some resources to help overcome possible roadblocks during the project*

##### Combining front-end (React Native/Android Studio) with back-end (Firebase)
- React Native and Firebase: [Manual Integration](https://rnfirebase.io/docs/v5.x.x/getting-started)
- Android Studio and Firebase: [Integrate](https://www.geeksforgeeks.org/adding-firebase-to-android-app/)

##### Setting up user groups/profiles in Firebase
- Profiles: Basic [Set-up](https://firebase.google.com/docs/auth/web/manage-users)
- User Groups: Secure Data access for [users and groups](https://firebase.google.com/docs/firestore/solutions/role-based-access) and user Groups in [Firebase](https://www.youtube.com/watch?v=vy8jn-9yyt4)

##### Real-time chat within Firebase
- [Link](https://www.raywenderlich.com/5359-firebase-tutorial-real-time-chat) to website
- [Video](https://www.youtube.com/watch?v=wVCz1a3ogqk) Tutorial

##### Setting up a Calendar in React Native
- To learn how to set up the Calendar Component, click [here](https://code.tutsplus.com/tutorials/how-to-create-a-react-native-calendar-component--cms-33664)

##### Push Notification System using [React Native and Firebase](https://medium.com/better-programming/react-native-local-scheduled-push-notification-with-firebase-8c775b71c35c)
