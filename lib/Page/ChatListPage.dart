import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/AuthService.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:beefriend_app/Page/ChatPage.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Chatlistpage extends StatefulWidget {
  const Chatlistpage({super.key});

  @override
  State<Chatlistpage> createState() => _ChatlistpageState();
}

class _ChatlistpageState extends State<Chatlistpage> {
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

    if (userData!['GenderID'] == 2) {
      var response = await showData()
          .getSavedUserDataFemale(Email: user!.email.toString());
      final profiles = (response as List).map((data) {
        return savedUser.fromMap(data);
      }).toList();

      setState(() {
        userList = profiles;
      });
    } else if (userData!['GenderID'] == 1) {
      var response =
          await showData().getSavedUserDataMale(Email: user!.email.toString());
      final profiles = (response as List).map((data) {
        return savedUser.fromMap(data);
      }).toList();

      setState(() {
        userList = profiles;
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
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                final profile = user.profile;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        profile?.ProfilePicture ??
                            'https://via.placeholder.com/150',
                      ),
                    ),
                    title: Text(
                      profile?.FullName ?? 'No Name',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {
                      var navigator = Navigator.of(context);
                      navigator.push(
                        MaterialPageRoute(
                          builder: (builder) {
                            return Chatpage(
                              Image: profile!.ProfilePicture,
                              Name: profile.FullName,
                              Email: profile.Gmail,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
