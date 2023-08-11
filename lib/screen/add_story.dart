import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/add_story_provider.dart';
import 'package:story_app/provider/upload_provider.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final storyController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Story"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ClipRRect(
              child: context.watch<AddStoryProvider>().imagePath == null
                  ? const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        size: 100,
                      ),
                    )
                  : showImage(),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onGaleryView(),
                child: const Text("Gallery"),
              ),
              ElevatedButton(
                onPressed: () => onCameraView(),
                child: const Text("Camera"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: storyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Story tidak boleh kosong.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Masukkan Developer story",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: context.watch<UploadProvider>().isUploading
                ? const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form!.validate()) {
                        onUploadButtonTapped();
                      }
                    },
                    child: const Text("Upload Story"),
                  ),
          ),
        ],
      ),
    );
  }

  onUploadButtonTapped() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final uploadProvider = context.read<UploadProvider>();

    final addStoryProvider = context.read<AddStoryProvider>();
    final imagePath = addStoryProvider.imagePath;
    final imageFile = addStoryProvider.imageFile;
    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final compressedImage = await uploadProvider.compressImage(bytes);

    await uploadProvider.upload(
        compressedImage, fileName, storyController.text);

    scaffoldMessengerState
        .showSnackBar(SnackBar(content: Text(uploadProvider.message)))
        .closed
        .then((value) => {
              if (uploadProvider.uploadResponse != null && context.mounted)
                {context.pop(true)}
            });
  }

  onGaleryView() async {
    final provider = context.read<AddStoryProvider>();
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  onCameraView() async {
    final provider = context.read<AddStoryProvider>();
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  showImage() {
    final imagePath = context.read<AddStoryProvider>().imagePath;
    return Image.file(
      File(imagePath.toString()),
      fit: BoxFit.contain,
    );
  }
}
