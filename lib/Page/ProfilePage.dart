import "package:flutter/material.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    'lib/assets/Setting1.png',
                    color: Colors.white,
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                  ))
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/profile_pic.png'),
            ),
            SizedBox(height: 10),
            Text(
              "Ariya, 19",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:
                  Text("Edit Profile", style: TextStyle(fontFamily: 'Poppins')),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bio", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("kalo bisa banyak kenapa harus satu"),
                  SizedBox(height: 10),
                  Text("Campus", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Kemanggisan, B27"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Photo Gallery",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              // itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: index == 0
                        ? null
                        : DecorationImage(
                            image: AssetImage('lib/assets/sample_image.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: index == 0
                      ? Icon(Icons.add, size: 40, color: Colors.grey)
                      : null,
                );
              },
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
                // ngpain lah
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
