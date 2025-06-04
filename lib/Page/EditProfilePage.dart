import 'package:beefriend_app/DB/user_DB.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {
  double _distance = 10;

  TextEditingController _bioController = TextEditingController();

  Map<String, dynamic>? userData;
  String? publicUrl;

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
        publicUrl = Supabase.instance.client.storage
            .from('images')
            .getPublicUrl('Upload/profile_pictures${userData!['Email']}.jpg');
        print(publicUrl.toString());
      });
    }
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color(0xFFEC7FA9),
            )),
      ),
    );
  }

  Widget _buildEditableField(String label, String? value) {
    _bioController.text = value ?? '';
    return TextFormField(
      controller: _bioController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      maxLines: 3,
    );
  }

  // Widget _buildDropdownTile(String title, Map<String, IconData> items,
  //     String selectedValue, ValueChanged<String?> onChanged) {
  //   return ListTile(
  //     leading: Icon(items[selectedValue] ?? Icons.help, color: Colors.black54),
  //     title: Text(title, style: const TextStyle(fontFamily: 'Poppins')),
  //     trailing: DropdownButton<String>(
  //       iconSize: 20,
  //       value: selectedValue,
  //       onChanged: onChanged,
  //       items: items.keys.map(
  //         (String item) {
  //           return DropdownMenuItem<String>(
  //             value: item,
  //             child: Row(
  //               children: [
  //                 Icon(items[item], size: 20, color: Colors.black54),
  //                 const SizedBox(width: 8),
  //                 Text(item),
  //               ],
  //             ),
  //           );
  //         },
  //       ).toList(),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double circleRadius = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          MediaQuery.of(context).size.width > 500 ? Colors.white : Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MediaQuery.of(context).size.width > 500
            ? const Color(0xFFEC7FA9)
            : const Color(0xFFEC7FA9),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            Text(
              "Edit Profile",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.2,
            ),
          ],
        ),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MediaQuery.of(context).size.width > 500
                          ? Color(0xFFEC7FA9)
                          : Color(0xFFEC7FA9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: circleRadius * 0.15,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              publicUrl.toString(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, '/InputFoto');
                            },
                            child: Text(
                              "Change Foto Profile",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                        _buildReadOnlyField("Name", "${userData!['Fullname']}"),
                  ),
                  // Text(
                  //   "${userData!['Fullname']}", //dari databse nanti yak bert
                  //   style: const TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _buildEditableField("Bio", userData!['Bio']),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Distance (km)",
                            style: TextStyle(fontFamily: 'Poppins')),
                        Slider(
                          value: _distance,
                          min: 1,
                          max: 100,
                          divisions: 99,
                          label: "${_distance.round()} km",
                          onChanged: (value) {
                            setState(() {
                              _distance = value;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: _buildReadOnlyField(
                            "Agama",
                            userData!['Agama']?['Agama'] ?? 'null',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: _buildReadOnlyField(
                            "Hobi",
                            userData!['Hobi']?['Hobi'] ?? 'null',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: _buildReadOnlyField(
                            "Ras",
                            userData!['Ethnic']?['Ethnic'] ?? 'null',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: _buildReadOnlyField(
                            "Zodiak",
                            userData!['Zodiak']?['Zodiak'] ?? 'null',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
