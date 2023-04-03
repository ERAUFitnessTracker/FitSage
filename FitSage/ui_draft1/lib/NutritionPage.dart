import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:async';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  late String result = "";

  File? _image;
  InputImage? inputImage;
  final picker = ImagePicker();

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

  Future imageToText(inputImage) async {
    result = '';

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognisedText = await textRecognizer.processImage(inputImage);

    setState(() {
      for (TextBlock block in recognisedText.blocks) {
        //each block of text/section of text
        // print("block of text: $text");

        for (TextLine line in block.lines) {
          //each line within a text block         for (TextElement element in line.elements) {
          //each word within a line
          result += "${line.text} ";
        }
      }
    });
    result += "\n\n";
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Expanded(
            child: Center(
              child: _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
            ),
          ),
          const SizedBox(height: 16),
          Row(
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
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                result,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
