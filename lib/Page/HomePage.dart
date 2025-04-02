import 'package:beefriend_app/DB_Helper/AuthService.dart';
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

  String UserEmail = AuthService().getCurrentUserEmail().toString();

  int currentIndex = 0;

// Dropdown
  String selectedAgama = 'Islam';
  String selectedHobi = 'Seni';
  String selectedAngkatan = 'B28';
  String selectedRas = 'Chinese';
  String selectedZodiak = 'Aries';

  final Map<String, IconData> agamaIcons = {
    "Buddha": Icons.temple_buddhist,
    "Hindu": Icons.temple_hindu,
    "Kristen": Icons.church,
    "Katolik": Icons.church,
    "Konghucu": Icons.account_balance,
    "Islam": Icons.mosque,
  };

  final Map<String, IconData> hobiIcons = {
    "Seni": Icons.brush,
    "Gaming": Icons.sports_esports,
    "Olahraga": Icons.fitness_center,
    "Travel": Icons.flight,
    "Belajar": Icons.book,
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
    "Older": Icons.history,
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
  };
  Widget _buildDropdownTile(String title, Map<String, IconData> items,
      String selectedValue, ValueChanged<String?> onChanged) {
    return ListTile(
      leading: Icon(items[selectedValue] ?? Icons.help, color: Colors.black54),
      title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
      trailing: DropdownButton<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: items.keys.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              children: [
                Icon(items[item], size: 20, color: Colors.black54),
                SizedBox(width: 8),
                Text(item),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

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
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti warna ikon drawer menjadi putih
        ),
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
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: screenHeight * 0.15,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFEC7FA9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
              setState(() => selectedAgama = value!);
            }),
            _buildDropdownTile("Hobi", hobiIcons, selectedHobi, (value) {
              setState(() => selectedHobi = value!);
            }),
            _buildDropdownTile("Angkatan", angkatanIcons, selectedAngkatan,
                (value) {
              setState(() => selectedAngkatan = value!);
            }),
            _buildDropdownTile("Ras", rasIcons, selectedRas, (value) {
              setState(() => selectedRas = value!);
            }),
            _buildDropdownTile("Zodiak", zodiakIcons, selectedZodiak, (value) {
              setState(() => selectedZodiak = value!);
            }),
          ],
        ),
      ),
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
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
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
          print(UserEmail);
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
