import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:async';
import '../DatabaseHelper.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late String result = "";

  bool imageRetakeNeeded = true;
  bool databaseUpdated = false;

  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();
  final TextEditingController _calorieController = TextEditingController();

//open gallery and choose an image
  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        inputImage = InputImage.fromFilePath(pickedFile.path);
        imageToText(inputImage);
      } else {
        // print('No image selected.');
      }
    });
  }

//open camera and take an image
  Future captureImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        inputImage = InputImage.fromFilePath(pickedFile.path);
        imageToText(inputImage);
      } else {
        // print('No image selected.');
      }
    });
  }

//scan the image for text
  Future imageToText(inputImage) async {
    result = '';

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognisedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    setState(() {
      bool isNutritionFactsLabel = false;
      for (TextBlock block in recognisedText.blocks) {
        // print("block of text: ${block.text}");
        //check if it's a nutrition facts label
        if (block.text.contains('Nutrition') ||
            block.text.contains('nutrition')) {
          isNutritionFactsLabel = true;
        }
        //check if the block only contains numbers with no % sign or letters
        if (!(block.text.contains(RegExp(r'[A-Za-z%]+'))) &&
            isNutritionFactsLabel) {
          //regex w common
          result = block.text;
          imageRetakeNeeded = false;
          return;
        }
      }
      if (!isNutritionFactsLabel) {
        result = 'Please scan a Nutrition Facts label.';
      } else {
        result = 'Please take a clearer picture of the Nutrition Facts label.';
      }
      imageRetakeNeeded = true;
      // _image = null;
    });
    result += "\n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //if there's an image to scan, display it with the result
        //otherwise, let the user pick an image
        children: [
          _image == null || databaseUpdated ? chooseImage() : displayResult()
        ],
      ),
    );
  }

//setup to display chooseImageButtons
  Widget chooseImage() {
    return Column(
      children: [
        const SizedBox(height: 75),
        databaseUpdated
            ? const Center(
                child: Text('Calories added to database.',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))
            : const Center(
                child: Text('No image selected.',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        const SizedBox(height: 20),
        chooseImageButtons(),
      ],
    );
  }

//displays "Gallery" and "Camera" buttons
  Widget chooseImageButtons() {
    databaseUpdated = false;
    return Column(
      children: [
        imageRetakeNeeded
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonTemplate(
                      () {
                        pickImageFromGallery();
                      },
                      'Gallery',
                    ),
                    buttonTemplate(
                      () {
                        captureImageFromCamera();
                      },
                      'Camera',
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonTemplate(() {
                    addCaloriesToDatabase(result);
                    // print('save calories button pressed');
                    setState(() {
                      databaseUpdated = true;
                      imageRetakeNeeded = true;
                    });
                    showSnackBar();
                  }, 'Save Calories'),
                  buttonTemplate(() {
                    // print('choose another image pressed');
                    setState(() {
                      imageRetakeNeeded = true;
                    });
                  }, 'Choose Another Image'),
                ],
              ),
        //text input here
        SizedBox(
          width: 337.1,
          child: 
        Material(
          elevation: 10,
          shadowColor: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFFe9e6df),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _calorieController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Calories Here",
              hintStyle: TextStyle(color: Color.fromARGB(255, 131, 129, 125)),
              labelText: 'Manually Enter Calories',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.center,
            ),
            validator: (value) {
              if (value == null) {
                return null;
              }
              if (int.tryParse(value) is! int) {
                return 'Please enter your calories.';
              }
              return null;
            },
            onFieldSubmitted: (result) {
              if (_calorieController.text.isNotEmpty) {
                addCaloriesToDatabase(_calorieController.value.text);
                showSnackBar();
                _calorieController.clear();
              }
            },
          ),
        ),
        ),
      ],
    );
  }

//displays the image and the scanned text
  Widget displayResult() {
    String outputText = '';
    imageRetakeNeeded ? outputText = result : outputText = 'Calories: $result';

    return Column(
      children: [
        SizedBox(
          height: 540,
          child: Center(
            child: Image.file(_image!),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          child: Text(
            outputText,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        chooseImageButtons(),
      ],
    );
  }

  void showSnackBar() async {
    final messenger = ScaffoldMessenger.of(context);
    // ignore: unused_local_variable
    int calories = 0;
    String textForSnackBar;
    if (await DatabaseHelper.instance.getCaloriesForDay(
            DateTime.now().day, DateTime.now().month, DateTime.now().year) >=
        0) {
      calories = await DatabaseHelper.instance.getCaloriesForDay(
          DateTime.now().day, DateTime.now().month, DateTime.now().year);
      textForSnackBar = 'Calorie Intake Updated!';
    } else {
      // print("this shouldn't happen uh oh");
      textForSnackBar = "this shouldn't happen";
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(textForSnackBar),
      ),
    );
  }

  Widget buttonTemplate(VoidCallback onPressed, String text) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 153, 169, 140),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addCaloriesToDatabase(String calories) async {
    print("result: $calories");
    await DatabaseHelper.instance.incrementCaloriesForDay(DateTime.now().day,
        DateTime.now().month, DateTime.now().year, int.parse(calories));
  }
}
