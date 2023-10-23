# virtual CAT app

### Citation
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10027851.svg)](https://doi.org/10.5281/zenodo.10027851)

If you use the materials provided in this repository, please cite the following work:

```bibtex
   @misc{adorni_virtualCAT2_023,
     author = {Adorni, Giorgia and Piatti, Simone and Karpenko, Volodymyr},
     doi = {10.5281/zenodo.10027851},
     month = oct,
     title = {{virtual CAT: An app for algorithmic thinking assessment within Swiss compulsory education}},
     doi = {10.5281/zenodo.10027851},
     note = {Zenodo Software. \url{https://doi.org/10.5281/zenodo.10027851}},
     year = {2023}
   }
```

### Overview
The virtual Cross Array Task (CAT) application serves as a digital platform to assess algorithmic thinking (AT) skills within Swiss compulsory education. 

The Virtual CAT is a digital embodiment of the Cross Array Task (CAT), a unique assessment activity initially conceived as an unplugged task, meticulously explored in our article [**[1]**](https://doi.org/10.1016/j.chbr.2021.100166). The essence of CAT lies in its ability to evaluate algorithmic skills by challenging individuals to develop a sequence of instructions, essentially an algorithm, to replicate intricate colour patterns on a cross array.

The transition from an unplugged activity to a digital platform arose from the necessity to scale the assessment process, making it conducive for larger cohorts and reducing human-induced inconsistencies in data collection. 

#### Features

- **Multifaceted Interaction Modes**: The app offers gesture-based and visual block-based programming interfaces, replicating embodied and symbolic artefacts in the unplugged CAT. These interactive modes cater to a diverse learner base, making the app accessible and adaptable.
- **Multilingual Support**: The app's multilingual support facilitates its usability across diverse linguistic backgrounds. In particular, it is available in four languages: 
  - *Italian*, *French*, and *German* to cater to the diverse linguistic landscape of Switzerland. 
  - *English* to extend the app’s utility to a broader range of educational institutions, ensuring that a wider student demographic can benefit from its learning experience, paving the way for potential adoption beyond Switzerland’s borders.
- **Automated Assessment**: The app automates the assessment process, providing real-time feedback, error notifications, and potential suggestions for rectification, enabling a streamlined evaluation of AT skills.
- **Cross-Platform Availability**: Developed using Flutter, the app maintains a consistent user experience across iOS, Android, and macOS, ensuring wide accessibility.

#### Evaluation and Impact

Both a pilot and a main evaluation of the virtual CAT were orchestrated in Switzerland, showcasing the platform's robustness in appraising AT skills amongst a heterogeneous ensemble of students and at a large scale. The dataset collected during the pilot study is available here [**[2]**](https://doi.org/10.5281/zenodo.10018292).

#### Core Architectural Pillars

The backbone of the virtual CAT app is structured around three fundamental components, each playing a crucial role in the orchestration and functionality of the system. Here's an in-depth look at these pivotal pillars:

1. **CAT programming language**: 
   - The core purpose behind defining the CAT programming language was to standardise the instructions users could use within the application interfaces to craft the required algorithm. This language encodes and formalises all commands and actions derived from the original experimental study with the unplugged CAT.
   - *Cross Representation*: The board's layout is referenced using a coordinate system, simplifying the task of identifying, moving around, and manipulating the cross-board dots.
   - *Moves*: These functions enable traversing the board by jumping directly to a specific coordinate or moving a certain number of dots in one of the eight available directions.
   - *Basic Colouring*: A range of methods is provided to apply colours to the board, allowing both singular and pattern-based colouring.
   - *Repetition-based Colouring*: For more complex operations, methods have been devised to repeat a sequence of commands across specific coordinates or to replicate colours from one set of coordinates to another.
   - *Symmetry-based Colouring*: Methods in this category facilitate the creation of symmetrical colouring patterns either across the entire board or within specified segments.
2. **virtual CAT programming language interpreter** [**[3]**](https://doi.org/10.5281/zenodo.10016535): 
   - This interpreter is integral in converting user interactions via gesture or visual programming blocks into executable, machine-readable instructions.
   - Each command undergoes a validation process to catch semantic errors, with real-time feedback provided to the user throughout.
   - A dedicated Dart package was developed and integrated within the Flutter project to facilitate seamless interaction with the interpreter component.
3. **virtual CAT data infrastructure** [**[4]**](https://doi.org/10.5281/zenodo.10015011): 
   - Considering the frequent unavailability of secure networks in educational settings, a technical framework was devised to ensure participant privacy and responsible data management.
   - The setup requires a local network infrastructure, connecting all devices to a designated data collection point, where a database captures and securely stores the data. 
   - Post-assessment, data can be transferred to a dedicated repository via a private network connection.

##### REFERENCES

**[1]** A. Piatti, G. Adorni, L. El-Hamamsy, L. Negrini, D. Assaf, L. Gambardella & F. Mondada. (2022). The CT-cube: A framework for the design and the assessment of computational thinking activities. Computers in Human Behavior Reports, 5, 100166. https://doi.org/10.1016/j.chbr.2021.100166

**[2]** Adorni, G. (2023). Dataset from the pilot study of the virtual CAT platform for algorithmic thinking skills assessment in Swiss Compulsory Education (1.0.0) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.10018292

**[3]** Adorni, G., & Karpenko, V. (2023). virtual CAT programming language interpreter (1.0.0). Zenodo. https://doi.org/10.5281/zenodo.10016535 
On GitHub: https://github.com/GiorgiaAuroraAdorni/virtual-CAT-programming-language-interpreter/

**[4]** Adorni, G. (2023). virtual CAT data infrastructure (1.0.0). Zenodo. https://doi.org/10.5281/zenodo.10015011
On GitHub: https://github.com/GiorgiaAuroraAdorni/virtual-CAT-data-infrastructure

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter 3.13.8
  You can download it from the official website https://docs.flutter.dev/get-started/install or clone it from GitHub.  
  Make sure to switch to the stable channel by running flutter channel stable.
- Dart 3.1.4
- DevTools 2.25.0
- Android Studio or Visual Studio (only for Windows) 
  [Follow this guide](https://docs.flutter.dev/get-started/editor?tab=androidstudio)
- XCode (only for macOS)

### Installing

1. Clone this repository:

   ```shell
   git clone https://github.com/GiorgiaAuroraAdorni/virtual-CAT-app.git
   cd virtual-CAT-app
   ```

2. Get the dependencies:

   ```shell
   flutter pub get
   ```

### Building 

#### For iOS (IPA)

```shell
flutter build ipa
```

#### For macOS

```shell
flutter build macos
```

#### For Android

```shell
flutter build apk
```

### Running

1.  Connect your device or start your emulator/simulator
2. Run the command `flutter run` in the project directory, select the device if asked, and if there are no errors, it's good to go.
3. Alternatively:
   1.  You can run the app as a release using the command `flutter run --release`.
   2. You can also run from some IDE. Read the section **Run the app** from [here](https://docs.flutter.dev/get-started/test-drive?tab=androidstudio) for android studio.

## Latest Release

In the latest release, the updated versions of the virtual CAT app for iOS, Android, and macOS have been uploaded. You can find the respective files for download in the [Releases](https://github.com/GiorgiaAuroraAdorni/virtual-CAT-app/releases) section of this repository.

- **iOS**: Download the latest `.ipa` file to install the app on your iOS device.
- **Android**: Download the latest `.apk` file to install the app on your Android device.
- **macOS**: Download the latest macOS app to install it on your Mac.

Each release contains improvements, bug fixes, and new features to provide a better user experience and enhance the app's functionality. 

To install the app on your device, follow the standard installation procedure for each platform.  
For iOS, you may need to use iTunes or an alternative method if your device isn't jailbroken.  
For Android, enable installations from unknown sources in your device settings to install the `.apk` file.  
For macOS, drag the downloaded app to your Applications folder.

## Documentation

The documentation of the platform is available here: [virtual CAT Documentation](https://giorgiaauroraadorni.github.io/virtual-CAT-app/)

