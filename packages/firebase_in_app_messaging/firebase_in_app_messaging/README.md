# firebase_in_app_messaging plugin

A Flutter plugin to use the [Firebase In-App Messaging API](https://firebase.google.com/products/in-app-messaging).

For Flutter plugins for other Firebase products, see [README.md](https://github.com/FirebaseExtended/flutterfire/blob/master/README.md).

## Usage

### Import the firebase_in_app_messaging plugin
To use the firebase_in_app_messaging plugin, follow the [plugin installation instructions](https://pub.dev/packages/firebase_in_app_messaging#pub-pkg-tab-installing).

### Android integration

There are a few extra steps required for the Android integration. Enable the Google services by configuring the Gradle scripts as such.

1. Add the classpath to the `[project]/android/build.gradle` file.
```gradle
dependencies {
  // Example existing classpath
  classpath 'com.android.tools.build:gradle:3.5.4'
  // Add the google services classpath
  classpath 'com.google.gms:google-services:4.3.4'
}
```

2. Add the apply plugin to the `[project]/android/app/build.gradle` file.
```gradle
// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

*Note:* If this section is not completed you will get an error like this:
```
java.lang.IllegalStateException:
Default FirebaseApp is not initialized in this process [package name].
Make sure to call FirebaseApp.initializeApp(Context) first.
```

*Note:* When you are debugging on Android, use a device or AVD with Google Play services.
Otherwise you will not be able to use Firebase In-App Messaging.

### Use the plugin

To show In-App Messages in your app, no extra setup is required - just import the plugin and you
are good to go. However, to modify message behavior (as documented [here](https://firebase.google.com/docs/in-app-messaging/modify-message-behavior)), the plugin provides the following methods -

First off, add the following imports to your Dart code:
```dart
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
```

#### Programmatic Triggers ([docs](https://firebase.google.com/docs/in-app-messaging/modify-message-behavior?platform=android#trigger_in-app_messages_programmatically))

To trigger in-app messages programmatically

```dart
FirebaseInAppMessaging.instance.triggerEvent('eventName');
```

#### Temporarily disable in-app messages ([docs](https://firebase.google.com/docs/in-app-messaging/modify-message-behavior?platform=android#temporarily_disable_in-app_messages))

If you'd like to suppress message displays for any reason, for example to avoid interrupting a sequence of payment processing screens, you can do that the following

```dart
FirebaseInAppMessaging.instance.setMessagesSuppressed(true);


// To re-enable
FirebaseInAppMessaging.instance.setMessagesSuppressed(false);
```

#### Enable opt-out message delivery ([docs](https://firebase.google.com/docs/in-app-messaging/modify-message-behavior?platform=android#enable_opt-out_message_delivery))

First, follow the step outlined [here](https://firebase.google.com/docs/in-app-messaging/modify-message-behavior#enable_opt-out_message_delivery) for both iOS and Android. Then add the following code in your app:

```dart
FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(false);
```

## Example

See the [example application](https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_in_app_messaging/example) source
for a complete sample app using the Firebase In-App Messaging.

## Issues and feedback

Please file FlutterFire specific issues, bugs, or feature requests in our [issue tracker](https://github.com/FirebaseExtended/flutterfire/issues/new).

Plugin issues that are not specific to Flutterfire can be filed in the [Flutter issue tracker](https://github.com/flutter/flutter/issues/new).

To contribute a change to this plugin,
please review our [contribution guide](https://github.com/FirebaseExtended/flutterfire/blob/master/CONTRIBUTING.md)
and open a [pull request](https://github.com/FirebaseExtended/flutterfire/pulls).
