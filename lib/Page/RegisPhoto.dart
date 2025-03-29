import "dart:io";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class InputFoto extends StatefulWidget {
  const InputFoto({super.key});

  @override
  State<InputFoto> createState() => _InputFotoState();
}

class _InputFotoState extends State<InputFoto> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final supabase = Supabase.instance.client;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an image first!"),
          backgroundColor: Color(0xFF98476A),
        ),
      );
      return;
    }

    try {
      final String fileName =
          "profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final response = await supabase.storage.from('profile_images').upload(
            fileName,
            _imageFile!,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String imageUrl =
          supabase.storage.from('profile_images').getPublicUrl(fileName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image uploaded successfully!",
            style: TextStyle(
              color: Color(0xFF98476A),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      );

      print("Uploaded Image URL: $imageUrl"); // Debugging URL di terminal
    } catch (error) {
      print("Upload error: $error"); // Debugging error di terminal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to upload image!"),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double circleRadius = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MediaQuery.of(context).size.width > 500
            ? Color(0xFFEC7FA9)
            : Color(0xFFEC7FA9),
      ),
      body: Container(
        color: MediaQuery.of(context).size.width > 500
            ? Color(0xFFEC7FA9)
            : Color(0xFFEC7FA9),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello, Bee👋",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let's create your own Profile Picture",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Image Picker Circle
            GestureDetector(
              onTap: getImage,
              child: CircleAvatar(
                radius: screenWidth * 0.2,
                backgroundColor: Colors.white,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? Icon(Icons.upload_sharp, size: 40, color: Colors.grey)
                    : null,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Upload Button
            ElevatedButton(
              onPressed: uploadImage,
              style: ElevatedButton.styleFrom(
                foregroundColor: MediaQuery.of(context).size.width > 500
                    ? Color(0xFFEC7FA9)
                    : Color(0xFFEC7FA9),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              // nextOnPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFEC7FA9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white,
                    )),
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
