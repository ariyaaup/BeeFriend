import "package:beefriend_app/Page/HomePage.dart";
import "package:flutter/material.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/SettingGear.png',
                    color: Colors.white,
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                  ))
            ],
          )),
      body: SingleChildScrollView(
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
                      CircleAvatar(
                        radius: circleRadius * 0.12,
                        backgroundColor: Colors.white,
                        // backgroundImage: icon.Profile),
                        //nanti lu disini tambahin dari Xfile picture upload bert.
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama", //dari databse nanti yak bert
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
                            //yang bisa diedit foto profile, nama terserah dah, password, jarak uda keknya
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
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
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
                    "Kampus",
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:
                        const Icon(Icons.add, size: 40, color: Colors.black54),
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
