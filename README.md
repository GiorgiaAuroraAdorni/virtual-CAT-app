# virtual-CAT-app

## How to install
### System requirements
- Flutter sdk
- Android Studio or Visual Studio (only for windows)
- XCode (only for macOs)

#### Installation and configuration
##### Flutter SDK
- **For MacOs** [Read here](https://docs.flutter.dev/get-started/install/macos)
- **For Windows** [Read here](https://docs.flutter.dev/get-started/install/windows)
- **For Linux** [Read here](https://docs.flutter.dev/get-started/install/linux)

#### Android Studio or Visual Studio
[Follow this guide](https://docs.flutter.dev/get-started/editor?tab=androidstudio)

## How to run
**Requirements** 
For build and run the application is necessary to have another one repo: [CAT-symbolic-programming-language-interpreter](https://github.com/vladimir98vk/CAT-symbolic-programming-language-interpreter)
### Directory tree
The files **must** have the following structures:
``` bash
<basic folder>
|_ CAT-symbolic-programming-language-interpreter
    |_ ... #content of the 'CAT-symbolic-programming-language-interpreter' repository
|_ cross-array-task-app
    |_ ... #content of this repository
```
If they haven't the following structure it's necessary to edit the `pubspec.yaml` as follow:
``` bash
dependencies:
    interpreter:
      path: ... #enter the path to the folder 'CAT-symbolic-programming-language-interpreter'
```

## Run from terminal

### Run for debug
Run the command `flutter run` in the 'cross-array-task-app' directory, select the device if asked, and if there are no error it's good to  go

### Run as release
 Run the command `flutter run --release` in the 'cross-array-task-app' directory, select the device if asked, and if there are no error it's good to  go

## Run from some IDE
Open the project in the selected IDE
Read the section **Run the app** from [here](https://docs.flutter.dev/get-started/test-drive?tab=androidstudio)



## Integration

We've developed a dedicated Dart package to seamlessly integrate the interpreter within the Virtual CAT application. This package is imported into the Flutter project, ensuring that the interpreter functions seamlessly within the application.

[Documentation]([link-to-documentation](https://giorgiaauroraadorni.github.io/virtual-CAT-programming-language-interpreter/)https://giorgiaauroraadorni.github.io/virtual-CAT-programming-language-interpreter/)
