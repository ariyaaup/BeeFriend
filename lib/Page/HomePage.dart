import 'package:beefriend_app/Page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> profiles = ['Profile 1', 'Profile 2', 'Profile 3'];

  int currentIndex = 0; // Manual pagination index

  @override
  Widget build(BuildContext context) {
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
                    'lib/assets/Setting.png',
                    color: Colors.white,
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                  ))
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: screenHeight * 0.001,
            // ),
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                //ini nanti bisa ganti :
//             itemBuilder: (BuildContext context, int index) {
//              return buildProfileCard(profiles[index % profiles.length]);
// },
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.zero, //shadow bawah card nya
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), //shadow rounded kanan kiri card
                        child: Image.asset(
                          "lib/assets/BeeFriend_fix.png",
                          width: screenWidth * 1,
                          height: screenHeight * 1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20), // rounded image nya
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.05, //posisi teks di card
                        bottom: screenHeight * 0.05, //posisi teks di card
                        child: Text(
                          profiles[
                              index % profiles.length], //profile smeentara dl
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
              height: screenHeight * 0.01,
            ),
            // Control Buttons
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Biar spacing bawah bagus
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex - 1) < 0
                            ? profiles.length - 1
                            : currentIndex - 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.black, // Consistent button
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex + 1) % profiles.length;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFFEC7FA9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEC7FA9),
        shape: const CircularNotchedRectangle(), // Biar ada notch untuk FAB
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.black),
              onPressed: () {
                var navigator = Navigator.of(context);
                navigator.push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return ProfilePage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigation_outlined, color: Colors.black),
              onPressed: () {
                //ngpain lah
              },
            ),
            SizedBox(width: screenWidth * 0.1), // scape tengah
            IconButton(
              icon: const Icon(Icons.group_outlined, color: Colors.black),
              onPressed: () {
                // ngpain la ini
              },
            ),
            IconButton(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          // Bisa kasih fungsi khusus disini
        },
        child: Image.asset(
          'lib/assets/BeeFriend_fix.png', // gambar bee png kamu
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
