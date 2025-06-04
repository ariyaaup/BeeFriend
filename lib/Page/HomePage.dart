import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/AuthService.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:beefriend_app/Page/ChatListPage.dart';
import 'package:beefriend_app/Page/TopLikesPage.dart';
import 'package:beefriend_app/Page/savedPage.dart';
// import 'package:beefriend_app/Page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? userDatas;
  Map<String, dynamic>? userDatass;
  String? emails;

  Widget buildTextBackgroundRow(List<String> texts,
      {Color backgroundColor = Colors.white24,
      double borderRadius = 10.0,
      EdgeInsetsGeometry padding = const EdgeInsets.all(8)}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: texts
          .map((text) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 10,
                ), //spacing antar text rownya
                padding: padding,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget buildProfileCard(UsersDB user) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String? Email = AuthService().getCurrentUserEmail();
    print(Email);
    return Container(
      color: const Color(0xFFEC7FA9),
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 10, //shadow nya
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: user.ProfilePicture.isNotEmpty
                        ? Image.network(
                            user.ProfilePicture,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover, //bair fit sama card setiap foto
                          )
                        : Image.asset(
                            "lib/assets/BeeFriend_fix.png",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.FullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "${user.Age} Tahun",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        buildTextBackgroundRow(
                          [
                            '${user.HobiName}',
                            '${user.EthnicName}',
                          ], //list nya nih desc dalam card bert
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 1,
            ), // Biar spacing bawah bagus
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    backgroundColor: Colors.pink,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: screenWidth * 0.1,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // var datas = await showData().AlreadyLiked(Email!);
                    userDatabase().LikeLogic(
                        savedUser(Email1: user.Gmail, Email2: Email!),
                        user.GenderID);
                    userDatabase().ChatInsert(
                        savedUser(Email1: Email, Email2: user.Gmail),
                        user.GenderID);
                    // print("CEK EMAIL MASUK ${user.Gmail}}");
                    // print("CEK EMAIL MASUK ${Email}}");
                    emails = user.Gmail;
                    print("DataaaaEUY: ${emails!}");

                    await fetchProfiles();
                    userDatabase()
                        .topLikeds(topLiked(email: user.Gmail, likes: 0));
                    likesLogic(user.Gmail, user.GenderID);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    backgroundColor: Colors.greenAccent,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: screenWidth * 0.1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Key widgetKey = UniqueKey();
  List<Map<String, dynamic>> userList = [];

  List<UsersDB> profiles = [];
  String UserEmail = AuthService().getCurrentUserEmail().toString();

  int? agamaID;
  int? hobiID;
  int? angkatanID;
  int? ethnicID;
  int? zodiakID;

  Future updateLikes(String Email) async {
    print("masuk update likes");
    final data = await showData().getTopLiked(Email);
    setState(() {
      userData = data;
      print(userData);
    });

    await Supabase.instance.client
        .from('TopLiked')
        .update({'likes': userData!['likes'] + 1}).eq("email", Email);
  }

  Future updateLikesStatusFemaletoMale(String Email1, String Email2) async {
    await Supabase.instance.client
        .from('FemaletoMale')
        .update({'Check': 1})
        .eq("Email_1", Email1)
        .eq("Email_2", Email2);
  }

  Future updateLikesStatusMaletoFemale(String Email1, String Email2) async {
    await Supabase.instance.client
        .from('MaletoFemale')
        .update({'Check': 1})
        .eq("Email_1", Email1)
        .eq("Email_2", Email2);
  }

  Future likesLogic(String Email, int gender) async {
    if (userData!["GenderID"] == 2) {
      final data = await showData().getLikedEmailFemale(UserEmail, Email);
      setState(() {
        userDatass = data;
        print("CEK EMAIL MASUK${UserEmail} COWO");
        print("CEK EMAIL MASUK${Email}");
      });
    } else if (userData!["GenderID"] == 1) {
      final data = await showData().getLikedEmailMale(UserEmail, Email);
      setState(() {
        userDatass = data;
        // print("CEK EMAIL MASUK${UserEmail} CEWE");
        // print("CEK EMAIL MASUK${Email}");
        // print("CEK EMAIL MASUK${userData!["Email_1"]}");
        // print("CEK EMAIL MASUK${userData!["Email_2"]}");
      });
    }
    if (userDatass!["Email_1"] == Email &&
        userDatass!["Email_2"] == UserEmail &&
        userDatass!["Check"] == 1) {
      print("CEK EMAIL MASUK");
      print("CEK EMAIL MASUK${userDatass!["Email_2"]}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You Already Liked This User",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    } else {
      // userDatabase()
      //     .LikeLogic(savedUser(Email1: Email, Email2: UserEmail), gender);
      updateLikes(Email);
      if (gender == 2) {
        print("MASUK SINI");
        updateLikesStatusFemaletoMale(Email, UserEmail);
      } else if (gender == 1) {
        print("MASUK SINI2");
        updateLikesStatusMaletoFemale(Email, UserEmail);
      }
    }
  }

  Future<void> fetchProfiles() async {
    final user = Supabase.instance.client.auth.currentUser;

    // print(users);
    if (user != null) {
      final datas = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = datas;
        // print(userData!['GenderID']);
      });
    }
    if (selectedAgama == "Buddha") {
      agamaID = 1;
    } else if (selectedAgama == "Hindu") {
      agamaID = 2;
    } else if (selectedAgama == "Protestan") {
      agamaID = 3;
    } else if (selectedAgama == "Katolik") {
      agamaID = 4;
    } else if (selectedAgama == "Konghucu") {
      agamaID = 5;
    } else if (selectedAgama == "Islam") {
      agamaID = 6;
    } else if (selectedAgama == "ANY") {
      agamaID = null;
    }
    if (selectedHobi == "Seni") {
      hobiID = 1;
    } else if (selectedHobi == "Gaming") {
      hobiID = 2;
    } else if (selectedHobi == "Olahraga") {
      hobiID = 3;
    } else if (selectedHobi == "Travel") {
      hobiID = 4;
    } else if (selectedHobi == "Belajar") {
      hobiID = 5;
    } else if (selectedHobi == "ANY") {
      hobiID = null;
    }
    if (selectedAngkatan == "B28") {
      angkatanID = 1;
    } else if (selectedAngkatan == "B27") {
      angkatanID = 2;
    } else if (selectedAngkatan == "B26") {
      angkatanID = 3;
    } else if (selectedAngkatan == "B25") {
      angkatanID = 4;
    } else if (selectedAngkatan == "B24") {
      angkatanID = 5;
    } else if (selectedAngkatan == "B23") {
      angkatanID = 6;
    } else if (selectedAngkatan == "B22") {
      angkatanID = 7;
    } else if (selectedAngkatan == "B21") {
      angkatanID = 8;
    } else if (selectedAngkatan == "B20") {
      angkatanID = 9;
    } else if (selectedAngkatan == "Older") {
      angkatanID = 10;
    } else if (selectedAngkatan == "ANY") {
      angkatanID = null;
    }
    if (selectedRas == "Chinese") {
      ethnicID = 1;
    } else if (selectedRas == "Batak") {
      ethnicID = 2;
    } else if (selectedRas == "Jawa") {
      ethnicID = 3;
    } else if (selectedRas == "Sunda") {
      ethnicID = 4;
    } else if (selectedRas == "Minang") {
      ethnicID = 5;
    } else if (selectedRas == "Dayak") {
      ethnicID = 6;
    } else if (selectedRas == "Madura") {
      ethnicID = 7;
    } else if (selectedRas == "Timur") {
      ethnicID = 8;
    } else if (selectedRas == "ANY") {
      ethnicID = null;
    }
    if (selectedZodiak == "Aries") {
      zodiakID = 1;
    } else if (selectedZodiak == "Taurus") {
      zodiakID = 2;
    } else if (selectedZodiak == "Gemini") {
      zodiakID = 3;
    } else if (selectedZodiak == "Cancer") {
      zodiakID = 4;
    } else if (selectedZodiak == "Leo") {
      zodiakID = 5;
    } else if (selectedZodiak == "Virgo") {
      zodiakID = 6;
    } else if (selectedZodiak == "Libra") {
      zodiakID = 7;
    } else if (selectedZodiak == "Scorpio") {
      zodiakID = 8;
    } else if (selectedZodiak == "Sagitarius") {
      zodiakID = 9;
    } else if (selectedZodiak == "Capricorn") {
      zodiakID = 10;
    } else if (selectedZodiak == "Aquarius") {
      zodiakID = 11;
    } else if (selectedZodiak == "Pisces") {
      zodiakID = 12;
    } else if (selectedZodiak == "ANY") {
      zodiakID = null;
    }
    if (userData!["GenderID"].toString() == "1") {
      var response = await showData().getUserDataByFiltered(
        genderId: 2,
        agama: agamaID,
        angkatan: angkatanID,
        ethnic: ethnicID,
        hobi: hobiID,
        zodiak: zodiakID,
        email: emails,
      );
      print("INI agama ${selectedAgama}");
      print("INI angkatan ${selectedAngkatan}");
      print("INI ethnic ${selectedRas}");

      profiles =
          (response as List).map((data) => UsersDB.fromMap(data)).toList();
      setState(() {
        userList = response;
      });
    } else if (userData!["GenderID"].toString() == "2") {
      var responses = await showData().getUserDataByFiltered(
        genderId: 1,
        agama: agamaID,
        angkatan: angkatanID,
        ethnic: ethnicID,
        hobi: hobiID,
        zodiak: zodiakID,
        email: emails,
      );

      setState(() {
        userList = responses;
      });
      profiles =
          (responses as List).map((data) => UsersDB.fromMap(data)).toList();
      setState(() {});
      // print('TestBrooo : ${responses.toString()}');
    }
    // }
  }

  Future<void> fetchProfilesfiltered() async {
    final user = Supabase.instance.client.auth.currentUser;

    // print(users);
    if (user != null) {
      final datas = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = datas;
        // print(userData!['GenderID']);
      });
    }

    if (userData!["GenderID"].toString() == "1") {
      var response = await showData().getUserDataByAutoFiltered(
        genderId: 2,
        agama: userData!["AgamaID"],
        angkatan: userData!["AngkatanID"],
        ethnic: userData!["EthnicID"],
        hobi: userData!["HobiID"],
        zodiak: userData!["ZodiakID"],
        email: userData!["Email"],
        campusLocation: userData!["RegionID"],
        relation: userData!["LookingForID"],
      );

      setState(() {
        userList = response;
      });
      profiles =
          (response as List).map((data) => UsersDB.fromMap(data)).toList();
      setState(() {
        userList = response;
        // print("Region : ${userData!["RegionID"]}");
        // print(userData!["LookingForID"]);
      });
    } else if (userData!["GenderID"].toString() == "2") {
      var responses = await showData().getUserDataByAutoFiltered(
        genderId: 1,
        agama: userData!["AgamaID"],
        angkatan: userData!["AngkatanID"],
        ethnic: userData!["EthnicID"],
        hobi: userData!["HobiID"],
        zodiak: userData!["ZodiakID"],
        email: userData!["Email"],
        campusLocation: userData!["RegionID"],
        relation: userData!["LookingForID"],
      );
      setState(() {
        userList = responses;
        // print("Region : ${userData!["RegionID"]}");
        // print(userData!["LookingForID"]);
      });
      profiles =
          (responses as List).map((data) => UsersDB.fromMap(data)).toList();
      setState(() {});
      // print('TestBrooo : ${responses.toString()}');
    }
    // }
  }

  int currentIndex = 0;

// Dropdown
  String selectedAgama = "ANY";
  String selectedHobi = "ANY";
  String selectedAngkatan = "ANY";
  String selectedRas = "ANY";
  String selectedZodiak = "ANY";

  final Map<String, IconData> agamaIcons = {
    "Buddha": Icons.temple_buddhist,
    "Hindu": Icons.temple_hindu,
    "Protestan": Icons.church,
    "Katolik": Icons.church,
    "Konghucu": Icons.account_balance,
    "Islam": Icons.mosque,
    "ANY": Icons.question_mark_sharp,
  };

  final Map<String, IconData> hobiIcons = {
    "Seni": Icons.brush,
    "Gaming": Icons.sports_esports,
    "Olahraga": Icons.fitness_center,
    "Travel": Icons.flight,
    "Belajar": Icons.book,
    "ANY": Icons.question_mark_sharp,
  };

  final Map<String, IconData> angkatanIcons = {
    "B28": Icons.school,
    "B27": Icons.school,
    "B26": Icons.school,
    "B25": Icons.school,
    "B24": Icons.school,
    "B23": Icons.school,
    "B22": Icons.school,
    "B21": Icons.school,
    "B20": Icons.school,
    "Older": Icons.history,
    "ANY": Icons.question_mark_sharp,
  };

  final Map<String, IconData> rasIcons = {
    "Chinese": Icons.people,
    "Batak": Icons.people,
    "Jawa": Icons.people,
    "Sunda": Icons.people,
    "Minang": Icons.people,
    "Dayak": Icons.people,
    "Madura": Icons.people,
    "Timur": Icons.people,
    "ANY": Icons.question_mark_sharp,
  };

  final Map<String, IconData> zodiakIcons = {
    "Aries": Icons.stars,
    "Taurus": Icons.bolt,
    "Gemini": Icons.auto_awesome,
    "Cancer": Icons.crisis_alert,
    "Leo": Icons.wb_sunny,
    "Virgo": Icons.spa,
    "Libra": Icons.balance,
    "Scorpio": Icons.science,
    "Sagitarius": Icons.architecture,
    "Capricorn": Icons.terrain,
    "Aquarius": Icons.water,
    "Pisces": Icons.waves,
    "ANY": Icons.question_mark_sharp,
  };
  Widget _buildDropdownTile(String title, Map<String, IconData> items,
      String selectedValue, ValueChanged<String?> onChanged) {
    return ListTile(
      leading: Icon(items[selectedValue] ?? Icons.help, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontFamily: 'Poppins')),
      trailing: DropdownButton<String>(
        iconSize: 20,
        value: selectedValue,
        onChanged: onChanged,
        items: items.keys.map(
          (String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(items[item], size: 20, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(item),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    // fetchProfiles();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MediaQuery.of(context).size.width > 500
          ? const Color(0xFFEC7FA9)
          : const Color(0xFFEC7FA9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MediaQuery.of(context).size.width > 500
            ? const Color(0xFFEC7FA9)
            : const Color(0xFFEC7FA9),
        iconTheme: const IconThemeData(
          color: Colors.white, // Ganti warna ikon drawer menjadi putih
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "BeeFriend",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: screenHeight * 0.15,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFEC7FA9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Filter Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Image.asset(
                      'lib/assets/Setting.png',
                      width: 24, // Sesuaikan ukuran ikon
                      height: 24,
                      color:
                          Colors.white, // Opsional: mengubah warna jika perlu
                    ),
                  ],
                ),
              ),
            ),
            _buildDropdownTile("Agama", agamaIcons, selectedAgama, (value) {
              setState(() {
                selectedAgama = value!;
              });
            }),
            _buildDropdownTile("Hobi", hobiIcons, selectedHobi, (value) {
              setState(() {
                selectedHobi = value!;
              });
            }),
            _buildDropdownTile("Angkatan", angkatanIcons, selectedAngkatan,
                (value) {
              setState(() => selectedAngkatan = value!);
            }),
            _buildDropdownTile("Ethnic", rasIcons, selectedRas, (value) {
              setState(() => selectedRas = value!);
            }),
            _buildDropdownTile("Zodiak", zodiakIcons, selectedZodiak, (value) {
              setState(() => selectedZodiak = value!);
            }),
            SizedBox(
              height: screenHeight * 0.3, //jarak filter sama button confirm
            ),
            Container(
              padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
              ),
              child: ElevatedButton(
                onPressed: () {
                  fetchProfilesfiltered();
                  setState(() {});
                },
                child: const Text(
                  "Auto Filter",
                  style: TextStyle(
                    fontFamily: "Poppin",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  foregroundColor: Color(0xFFEC7FA9),
                  backgroundColor: Color(0xFFFFFFFF),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.001, //gap filter button nih
            ),
            Container(
              padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
              ),
              child: ElevatedButton(
                onPressed: () {
                  // refreshWidget();
                  fetchProfiles();
                  setState(() {});
                },
                child: const Text(
                  "Confirm Filter",
                  style: TextStyle(
                    fontFamily: "Poppin",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  foregroundColor: Color(0xFFFFFFFF),
                  backgroundColor: Color(0xFFEC7FA9),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profiles.isEmpty
                ? const Center(
                    child: Text("No User Found"),
                  )
                : Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return buildProfileCard(profiles[index]);
                    },
                    itemCount: profiles.length,
                    layout: SwiperLayout.TINDER,
                    itemWidth: screenWidth,
                    itemHeight: screenHeight,
                    onIndexChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
            SizedBox(
              height: screenHeight * 0.01, //size swiper atau gap bawahnya
            ),

            // Control Buttons
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFFFFFF),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              //button navbar profile
              icon: const Icon(Icons.person_outline, color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, '/ProfilePage');
              },
            ),
            IconButton(
              //button navbar lokasi
              icon: const Icon(Icons.star_border_outlined, color: Colors.black),
              onPressed: () {
                var navigator = Navigator.of(context);
                navigator.push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return Toplikespage();
                    },
                  ),
                );
              },
            ),
            SizedBox(width: screenWidth * 0.1), // jarak tengah floating button
            IconButton(
              //button pertemanan
              icon: const Icon(Icons.group_outlined, color: Colors.black),
              onPressed: () {
                var navigator = Navigator.of(context);
                navigator.push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return Savedpage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              //button chat halo chat
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {
                var navigator = Navigator.of(context);
                navigator.push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return Chatlistpage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //BeeFriend match couple nih button
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Navigator.popAndPushNamed(context, '/homePage');
          print(UserEmail);
        },
        child: Image.asset(
          'lib/assets/BeeFriend_fix.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
