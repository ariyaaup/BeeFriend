import "package:beefriend_app/DB/user_DB.dart";
import "package:beefriend_app/DB_Helper/AuthService.dart";
// import "package:beefriend_app/DB_Helper/LoggedUser.dart";
import "package:beefriend_app/Page/ChatListPage.dart";
// import "package:beefriend_app/Page/HomePage.dart";
import "package:beefriend_app/Page/LoginPage.dart";
import "package:beefriend_app/Page/savedPage.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // String email = AuthService().getCurrentUserEmail.toString();
    // publicUrl = Supabase.instance.client.storage
    //     .from('images')
    //     .getPublicUrl('Upload/profile_pictures$email.jpg');
    // print(publicUrl.toString());
    // print(email.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double circleRadius = MediaQuery.of(context).size.width;

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
          title: Row(
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
              SizedBox(
                width: screenWidth * 0.5,
              ),
            ],
          )),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/EditProfile");
                              },
                              child: CircleAvatar(
                                radius: circleRadius * 0.12,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  publicUrl.toString(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userData!['Fullname']}", //dari databse nanti yak bert
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.001,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigasi ke Edit Profile
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    textStyle: const TextStyle(fontSize: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF98476A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        // Text(
                        //   userData!['Region']?['RegionName'] ?? 'null',
                        //   style:
                        //       const TextStyle(color: Colors.blue, fontSize: 16),
                        // ),
                        // NANTI INI GANTI BIO DARI EDIT PROFILE PAGE
                        SizedBox(height: screenHeight * 0.05),
                        const Text(
                          "Campus",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          userData!['Region']?['RegionName'] ?? 'null',
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                      ],
                    ),
                  ),

                  // Ini buat More and Info support,
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More Info and support",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.16,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.help_outline,
                                ),
                                title: Text(
                                  'Help',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                onTap: () {
                                  //masukin halaman tanpa bikin baru, males nnti kebanyakan page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          resizeToAvoidBottomInset: false,
                                          backgroundColor:
                                              MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      500
                                                  ? const Color(0xFFEC7FA9)
                                                  : const Color(0xFFEC7FA9),
                                          appBar: AppBar(
                                              scrolledUnderElevation: 0,
                                              automaticallyImplyLeading: false,
                                              iconTheme: IconThemeData(
                                                color: Colors.white,
                                              ),
                                              backgroundColor:
                                                  MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          500
                                                      ? const Color(0xFFEC7FA9)
                                                      : const Color(0xFFEC7FA9),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop(); // Kembali ke halaman sebelumnya
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back_ios,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          screenWidth * 0.05),
                                                  Text(
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
                                              )),
                                          body: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.05,
                                              vertical: screenHeight * 0.01,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: screenHeight * 0.05,
                                                ),
                                                Text(
                                                  "What is it ?",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.01,
                                                ),
                                                Text(
                                                  "Beefriend di buat untuk membantu mahasiswa menemukan teman baru, membangun hubungan bermakna, dan mungkin... menemukan cinta sejati! Kami percaya bahwa dunia perkuliahan adalah salah satu masa terbaik untuk bertemu orang-orang luar biasa dan Beefriend hadir untuk membuatnya lebih mudah dan seru.",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.05),
                                                Text(
                                                  "Contact us",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.01,
                                                ),
                                                Text(
                                                  "Email :",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Text(
                                                  "3perintismahasiswa27@gmail.com",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 38, 255)),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.00001,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.help_outline,
                                ),
                                title: Text(
                                  'About us',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/AboutUs');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AuthService().signOut();
                          print(AuthService().getCurrentUserEmail().toString());
                          var navigator = Navigator.of(context);
                          navigator.push(
                            MaterialPageRoute(
                              builder: (builder) {
                                return LoginPage();
                              },
                            ),
                          );
                        },
                        child: Text("Sign Out"),
                      )
                    ],
                  ),
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
              icon: const Icon(Icons.navigation_outlined, color: Colors.black),
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
          // print(UserEmail);
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
