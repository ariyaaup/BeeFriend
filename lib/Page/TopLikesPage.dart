import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
// import 'package:beefriend_app/Page/ChatPage.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Toplikespage extends StatefulWidget {
  const Toplikespage({super.key});

  @override
  State<Toplikespage> createState() => _ToplikespageState();
}

class _ToplikespageState extends State<Toplikespage> {
  Map<String, dynamic>? userData;
  List<topLiked> userList = [];

  Future<void> fetchProfiles() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final datas = await showData().getUserDataByEmail(user.email!);
      setState(() {
        userData = datas;
        // print(userData!['GenderID']);
      });
    }
    var response = await showData().showTopLikes();
    final profiles = (response as List).map((data) {
      return topLiked.fromMap(data);
    }).toList();

    setState(() {
      userList = profiles;
    });

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
              "TOP LIKED",
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
                final rank = index + 1;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: Text('$rank'),
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            profile?.ProfilePicture ??
                                'https://via.placeholder.com/150',
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.025,
                        ),
                        Text(
                          profile?.FullName ?? 'No Name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      user.likes.toString(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
