import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/AuthService.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:beefriend_app/Page/ChatListPage.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:beefriend_app/Page/viewProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Savedpage extends StatefulWidget {
  const Savedpage({super.key});

  @override
  State<Savedpage> createState() => _SavedpageState();
}

class _SavedpageState extends State<Savedpage> {
  Map<String, dynamic>? userData;
  Key widgetKey = UniqueKey();

  List<savedUser> userList = [];
  String UserEmail = AuthService().getCurrentUserEmail().toString();

  Future<void> fetchProfiles() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final datas = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = datas;
        // print(userData!['GenderID']);
      });
    }

    if (userData!['GenderID'] == 1) {
      var response =
          await showData().getSavedUserDataMale(Email: UserEmail.toString());
      final profiles = (response as List).map((data) {
        return savedUser.fromMap(data);
      }).toList();

      setState(() {
        userList = profiles;
        print(userList);
      });
    } else if (userData!['GenderID'] == 2) {
      print("EMAIL SAVED PAGE ${userData!["Email"]}");
      var response =
          await showData().getSavedUserDataFemale(Email: userData!['Email']);
      final profiles = (response as List).map((data) {
        return savedUser.fromMap(data);
      }).toList();

      setState(() {
        userList = profiles;
        print(userList);
      });
    }

    // print(user.email.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
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
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              var navigator = Navigator.of(context);
              navigator.push(
                MaterialPageRoute(
                  builder: (builder) {
                    return HomePage();
                  },
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "BeeFriend",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.5,
            ),
          ],
        ),
      ),
      body: userList.isEmpty
          ? Center(
              child: Text(
              "No one like you!",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ))
          : GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 9 / 16,
              ),
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                final profile = user.profile;

                return GestureDetector(
                  onTap: () {
                    var navigator = Navigator.of(context);
                    navigator.push(
                      MaterialPageRoute(
                        builder: (builder) {
                          return Viewprofilepage(
                              name: profile!.FullName,
                              age: profile.Age.toString(),
                              birthdate: profile.BirthDate,
                              img: profile.ProfilePicture,
                              email: profile.Gmail);
                        },
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Foto Profil
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              profile?.ProfilePicture ??
                                  'https://via.placeholder.com/150',
                              scale: 1,
                              width: screenWidth,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Nama
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  profile?.FullName ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
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
                //ngpain lah
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
          Navigator.pushNamed(context, '/homePage');
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
