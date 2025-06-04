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
  String? selectedReligion;
  String? selectedHobby;
  String? selectedEthnic;
  String? selectedZodiac;
  bool isEditable = true;

  Map<String, dynamic>? userData;
  String? publicUrl;

  List<String> religions = [
    'NONE',
    'Buddha',
    'Hindu',
    'Protestan',
    'Katolic',
    'Konghucu',
    'Islam'
  ];
  List<String> hobbies = [
    'NONE',
    'Seni',
    'Gaming',
    'Olahraga',
    'Travel',
    'Belajar'
  ];
  List<String> ethnicities = [
    'NONE',
    'Chinese',
    'Batak',
    'Jawa',
    'Sunda',
    'Minang',
    'Dayak',
    'Madura',
    'Timur'
  ];
  List<String> zodiacs = [
    'NONE',
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagitarius',
    'Capricorn',
    'Aquarius',
    'Pisces'
  ];

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
        selectedReligion = userData!['Agama']?['Agama'];
        selectedHobby = userData!['Hobi']?['Hobi'];
        selectedEthnic = userData!['Ethnic']?['Ethnic'];
        selectedZodiac = userData!['Zodiak']?['Zodiak'];
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

  // Method to save data to the database
  Future<void> saveProfileData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      await Supabase.instance.client
          .from('users')
          .upsert({
            'Email': user.email,
            'Fullname': userData!['Fullname'],
            'Bio': _bioController.text,
            'Agama': selectedReligion,
            'Hobi': selectedHobby,
            'Ethnic': selectedEthnic,
            'Zodiak': selectedZodiac,
          })
          .select()
          .single();
    }
  }

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
                    child:
                        _buildEditableField("Bio", _bioController.toString()),
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
                        const Text(
                          "Please make sure to fill this data !",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF98476A),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildDropdownField(
                            "Agama", religions, selectedReligion),
                        _buildDropdownField("Hobi", hobbies, selectedHobby),
                        _buildDropdownField("Ras", ethnicities, selectedEthnic),
                        _buildDropdownField("Zodiak", zodiacs, selectedZodiac),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.popAndPushNamed(context, "/EditProfile");
                        //nanti ini kl bisa di onPress saved gas dh data
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
                        "Save",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
    );
  }

  Widget _buildDropdownField(
      String label, List<String> items, String? selectedValue) {
    if (selectedValue != null && !items.contains(selectedValue)) {
      selectedValue = items.first;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: isEditable
            ? (value) {
                setState(() {
                  if (label == "Agama") selectedReligion = value;
                  if (label == "Hobi") selectedHobby = value;
                  if (label == "Ras") selectedEthnic = value;
                  if (label == "Zodiak") selectedZodiac = value;
                });
              }
            : null, // Disable the dropdown if isEditable is false
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
