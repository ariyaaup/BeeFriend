import "package:beefriend_app/DB_Helper/AuthService.dart";
import "package:beefriend_app/DB_Helper/LoggedUser.dart";
import "package:beefriend_app/Page/HomePage.dart";
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
  // final supabase = Supabase.instance.client; // dari gpt

  // // Future untuk mengambil data user
  // Future<Map<String, dynamic>?> getUserData() async {
  //   final userId = supabase.auth.currentUser?.id; // Ambil ID pengguna yang sedang login
  //   if (userId == null) return null;

  //   final response = await supabase
  //       .from('users')
  //       .select()
  //       .eq('id', userId)
  //       .single();

  //   return response;
  // }

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await AuthService().getUserDataByEmail(user.email!);
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
                      borderRadius: BorderRadius.only(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/InputFoto");
                              },
                              child: CircleAvatar(
                                radius: circleRadius * 0.12,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(publicUrl.toString()),
                                //nanti lu disini tambahin dari Xfile picture upload bert.
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
                                  //yang ada dalem edit profile nanti isinya dari databse,
                                  //yang bisa diedit foto profile, password, jarak uda keknya
                                  //Gender, lookingfor, email, kampus, angkatan umur, tanggal lahir gabisa
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
                        GestureDetector(
                          onTap: () {
                            //bio
                          },
                          child: Text(
                            "Bio",
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        SizedBox(height: 20),
                      ],
                    ),
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
                        Text(
                          "Photo Gallery",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.add,
                              size: 40, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEC7FA9),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              //button navbar profile
              icon: const Icon(Icons.person_outline, color: Colors.black),
              onPressed: () {
                // ngpain lah
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
                // ngpain la ini
              },
            ),
            IconButton(
              //button chat halo chat
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {
                //ntr ngapain lah ini
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
        },
        child: Image.asset(
          'lib/assets/BeeFriend_fix.png',
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
