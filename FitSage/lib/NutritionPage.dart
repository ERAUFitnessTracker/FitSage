import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:async';
import 'DatabaseHelper.dart';
import 'calendar.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late String result = "";

  bool imageRetakeNeeded = false;
  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();

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
        children: [_image == null ? chooseImage() : displayResult()],
      ),
    );
  }

//setup to display chooseImageButtons
  Widget chooseImage() {
    return Column(
      children: [
        const SizedBox(height: 75),
        const Center(child: Text('No image selected.')),
        const SizedBox(height: 10),
        chooseImageButtons(),
      ],
    );
  }

//displays "Gallery" and "Camera" buttons
  Widget chooseImageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: pickImageFromGallery,
          child: const Text('Gallery'),
        ),
        ElevatedButton(
          onPressed: captureImageFromCamera,
          child: const Text('Camera'),
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
        //displays chooseImageButtons if a retake is needed
        imageRetakeNeeded
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: chooseImageButtons(),
              )
            : saveCaloriesButton()
      ],
    );
  }

//displays save button (i wrote this on my phone hehe)
  Widget saveCaloriesButton() {
    return Center(
      child: ElevatedButton(
        onPressed: addCaloriesToDatabase,
        child: const Text('Save Calories'),
      ),
    );
  }

  void addCaloriesToDatabase() async {
    await DatabaseHelper.instance.incrementCaloriesForDay(DateTime.now().day,
        DateTime.now().month, DateTime.now().year, int.parse(result));
  }
}
