import "dart:io";
import "package:beefriend_app/DB/user_DB.dart";
import "package:beefriend_app/DB_Helper/AuthService.dart";
import "package:beefriend_app/Page/EditProfilePage.dart";
// import "package:beefriend_app/DB_Helper/LoggedUser.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class InputFoto extends StatefulWidget {
  final String email;
  final String foto;
  InputFoto({super.key, required this.email, required this.foto});

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
    String Email = AuthService().getCurrentUserEmail().toString();
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
      final fileName =
          'Upload/profile_pictures${Email}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // final String fileName = 'Upload/profile_pictures${Email}.jpg';

      // final String fileNames = 'profile_pictures${Email}.jpg';
      final String publicUrl =
          supabase.storage.from('images').getPublicUrl(fileName);
      final path = '$fileName';

      await Supabase.instance.client.storage
          .from('images')
          .upload(path, _imageFile!)
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Image uploaded successfully!",
                  style: TextStyle(
                    color: Color(0xFF98476A),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          );
      userDatabase().UpdateProfilePicture(Email, publicUrl);

      // print("Uploaded Image URL : $imageUrl");// Debugging URL di terminal
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

  Map<String, dynamic>? userData;

  Future<void> deletePP(String path) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(path);
      });
    }

    await Supabase.instance.client.storage
        .from('images')
        .remove(["profile_pictures${widget.email}.jpg"]);
  }

  Future<void> deleteAndUploadImage() async {
    final email = AuthService().getCurrentUserEmail();
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an image first!"),
          backgroundColor: Color(0xFF98476A),
        ),
      );
      return;
    }

    final String fileName = 'profile_pictures$email.jpg';
    final String path = 'Upload/$fileName';
    final String publicUrl =
        Supabase.instance.client.storage.from('images').getPublicUrl(path);

    print("Trying to delete path: $path");
    try {
      await Supabase.instance.client.storage
          .from('images')
          .remove(['Upload/profile_picturesdelbert.setioso@binus.ac.id.jpg']);

      print("Trying to upload to path: $path");
      await Supabase.instance.client.storage
          .from('images')
          .upload(path, _imageFile!);

      await userDatabase().UpdateProfilePicture(email.toString(), publicUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Image uploaded successfully!"),
          backgroundColor: Colors.white,
        ),
      );
    } catch (e) {
      print("Upload error: $e");
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
      body: Center(
          child: Container(
              color: MediaQuery.of(context).size.width > 500
                  ? Color(0xFFEC7FA9)
                  : Color(0xFFEC7FA9),
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
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
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.001,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Let's create your own Profile Picture !\n"
                            "Tap the upload button...",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    // Image Picker Circle
                    GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: circleRadius * 0.2,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? Icon(Icons.upload_sharp,
                                size: 40, color: Colors.grey)
                            : null,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Upload Button
                    ElevatedButton(
                      onPressed: () {
                        // print(widget.email);
                        // deletePP('profile_pictures${widget.email}.jpg');
                        // deleteAndUploadImage();
                        uploadImage();
                      },
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
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var navigator = Navigator.of(context);
                        navigator.push(
                          MaterialPageRoute(
                            builder: (builder) {
                              return Editprofilepage();
                            },
                          ),
                        );
                        // deletePP(widget.foto);
                        Supabase.instance.client.storage
                            .from('images')
                            .remove([widget.foto]);
                      },
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
                        "Finish",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
