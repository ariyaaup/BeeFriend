import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/Page/InputFoto.dart';
import 'package:beefriend_app/Page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {
  double? _distance;

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
        _bioController.text = userData!["Bio"];
        selectedReligion = userData!['Agama']?['Agama'];
        _distance = userData!["Distance"].toDouble();
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

  int? agamaID;
  int? hobiID;
  int? angkatanID;
  int? ethnicID;
  int? zodiakID;

  Future<void> updateBio() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
      });
    }
    showData().updateValueString(
        _bioController.text.toString(), "Bio", userData!["Email"]);
  }

  Future<void> updateDistance() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
      });
    }

    showData().updateValueDouble(_distance!, "Distance", userData!["Email"]);
  }

  Future<void> updateReligion() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
      });
    }
    if (selectedReligion == "Buddha") {
      agamaID = 1;
    } else if (selectedReligion == "Hindu") {
      agamaID = 2;
    } else if (selectedReligion == "Protestan") {
      agamaID = 3;
    } else if (selectedReligion == "Katolik") {
      agamaID = 4;
    } else if (selectedReligion == "Konghucu") {
      agamaID = 5;
    } else if (selectedReligion == "Islam") {
      agamaID = 6;
    } else if (selectedReligion == "ANY") {
      agamaID = null;
    }

    showData().updateValueInt(agamaID!, "AgamaID", userData!["Email"]);
  }

  Future<void> updateHobi() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
        print(userData);
      });
    }

    if (selectedHobby == "Seni") {
      hobiID = 1;
    } else if (selectedHobby == "Gaming") {
      hobiID = 2;
    } else if (selectedHobby == "Olahraga") {
      hobiID = 3;
    } else if (selectedHobby == "Travel") {
      hobiID = 4;
    } else if (selectedHobby == "Belajar") {
      hobiID = 5;
    } else if (selectedHobby == "ANY") {
      hobiID = null;
    }

    print(" HOBI ${hobiID}");
    print(" HOBI ${selectedHobby}");

    showData().updateValueInt(hobiID!, "HobiID", userData!["Email"]);
  }

  Future<void> updateRas() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
      });
    }
    if (selectedEthnic == "Chinese") {
      ethnicID = 1;
    } else if (selectedEthnic == "Batak") {
      ethnicID = 2;
    } else if (selectedEthnic == "Jawa") {
      ethnicID = 3;
    } else if (selectedEthnic == "Sunda") {
      ethnicID = 4;
    } else if (selectedEthnic == "Minang") {
      ethnicID = 5;
    } else if (selectedEthnic == "Dayak") {
      ethnicID = 6;
    } else if (selectedEthnic == "Madura") {
      ethnicID = 7;
    } else if (selectedEthnic == "Timur") {
      ethnicID = 8;
    } else if (selectedEthnic == "ANY") {
      ethnicID = null;
    }
    showData().updateValueInt(ethnicID!, "EthnicID", userData!["Email"]);
  }

  Future<void> updateZodiak() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = data;
      });
    }

    if (selectedZodiac == "Aries") {
      zodiakID = 1;
    } else if (selectedZodiac == "Taurus") {
      zodiakID = 2;
    } else if (selectedZodiac == "Gemini") {
      zodiakID = 3;
    } else if (selectedZodiac == "Cancer") {
      zodiakID = 4;
    } else if (selectedZodiac == "Leo") {
      zodiakID = 5;
    } else if (selectedZodiac == "Virgo") {
      zodiakID = 6;
    } else if (selectedZodiac == "Libra") {
      zodiakID = 7;
    } else if (selectedZodiac == "Scorpio") {
      zodiakID = 8;
    } else if (selectedZodiac == "Sagitarius") {
      zodiakID = 9;
    } else if (selectedZodiac == "Capricorn") {
      zodiakID = 10;
    } else if (selectedZodiac == "Aquarius") {
      zodiakID = 11;
    } else if (selectedZodiac == "Pisces") {
      zodiakID = 12;
    } else if (selectedZodiac == "ANY") {
      zodiakID = null;
    }
    showData().updateValueInt(zodiakID!, "ZodiakID", userData!["Email"]);
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
                var navigator = Navigator.of(context);
                navigator.push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return ProfilePage();
                    },
                  ),
                );
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
                              userData!["ProfilePicture"],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              var navigator = Navigator.of(context);
                              navigator.push(
                                MaterialPageRoute(
                                  builder: (builder) {
                                    return InputFoto(
                                      email: userData!["Email"],
                                      foto: userData!['ProfilePicture'],
                                    );
                                  },
                                ),
                              );
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
                    child: _buildEditableField(
                        "Bio", _bioController.text.toString()),
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
                          value: _distance!,
                          min: 1,
                          max: 100,
                          divisions: 99,
                          label: "${_distance!.round()} km",
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
                        // update(value, section)
                        updateBio();
                        updateDistance();
                        updateHobi();
                        updateReligion();
                        updateRas();
                        updateZodiak();
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

// if (selectedAgama == "Buddha") {
//       agamaID = 1;
//     } else if (selectedAgama == "Hindu") {
//       agamaID = 2;
//     } else if (selectedAgama == "Protestan") {
//       agamaID = 3;
//     } else if (selectedAgama == "Katolik") {
//       agamaID = 4;
//     } else if (selectedAgama == "Konghucu") {
//       agamaID = 5;
//     } else if (selectedAgama == "Islam") {
//       agamaID = 6;
//     } else if (selectedAgama == "ANY") {
//       agamaID = null;
//     }
//     if (selectedHobi == "Seni") {
//       agamaID = 1;
//     } else if (selectedAgama == "Gaming") {
//       agamaID = 2;
//     } else if (selectedAgama == "Olahraga") {
//       agamaID = 3;
//     } else if (selectedAgama == "Travel") {
//       agamaID = 4;
//     } else if (selectedAgama == "Belajar") {
//       agamaID = 5;
//     } else if (selectedAgama == "ANY") {
//       agamaID = null;
//     }
// if (selectedRas == "Chinese") {
//       ethnicID = 1;
//     } else if (selectedRas == "Batak") {
//       ethnicID = 2;
//     } else if (selectedRas == "Jawa") {
//       ethnicID = 3;
//     } else if (selectedRas == "Sunda") {
//       ethnicID = 4;
//     } else if (selectedRas == "Minang") {
//       ethnicID = 5;
//     } else if (selectedRas == "Dayak") {
//       ethnicID = 6;
//     } else if (selectedRas == "Madura") {
//       ethnicID = 7;
//     } else if (selectedRas == "Timur") {
//       ethnicID = 8;
//     } else if (selectedRas == "ANY") {
//       ethnicID = null;
//     }
//     if (selectedZodiak == "Aries") {
//       zodiakID = 1;
//     } else if (selectedZodiak == "Taurus") {
//       zodiakID = 2;
//     } else if (selectedZodiak == "Gemini") {
//       zodiakID = 3;
//     } else if (selectedZodiak == "Cancer") {
//       zodiakID = 4;
//     } else if (selectedZodiak == "Leo") {
//       zodiakID = 5;
//     } else if (selectedZodiak == "Virgo") {
//       zodiakID = 6;
//     } else if (selectedZodiak == "Libra") {
//       zodiakID = 7;
//     } else if (selectedZodiak == "Scorpio") {
//       zodiakID = 8;
//     } else if (selectedZodiak == "Sagitarius") {
//       zodiakID = 9;
//     } else if (selectedZodiak == "Capricorn") {
//       zodiakID = 10;
//     } else if (selectedZodiak == "Aquarius") {
//       zodiakID = 11;
//     } else if (selectedZodiak == "Pisces") {
//       zodiakID = 12;
//     } else if (selectedZodiak == "ANY") {
//       zodiakID = null;
//     }
