import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Viewprofilepage extends StatefulWidget {
  final String name;
  final String age;
  final String img;
  final String birthdate;
  final String email;
  const Viewprofilepage(
      {super.key,
      required this.name,
      required this.age,
      required this.img,
      required this.birthdate,
      required this.email});
  //tambahin semuanya pokoknya

  @override
  State<Viewprofilepage> createState() => _ViewprofilepageState();
}

Widget buildTextBackgroundRow1(List<String> texts,
    {Color backgroundColor = const Color(0xFFFFFFFF),
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
                  color: Color(0xFFEC7FA9),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ))
        .toList(),
  );
}

Widget buildTextBackgroundRow2(List<String> texts,
    {Color backgroundColor = const Color(0xFFFFFFFF),
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
                  color: Color(0xFFEC7FA9),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ))
        .toList(),
  );
}

class _ViewprofilepageState extends State<Viewprofilepage> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? userDatas;
  String? emails;

  final user = Supabase.instance.client.auth.currentUser;

  Future updateLikes(String Email) async {
    final data = await showData().getTopLiked(Email);
    setState(() {
      userData = data;
      print("HALO ${userData}");
    });

    await Supabase.instance.client
        .from('TopLiked')
        .update({'likes': userData!['likes'] + 1}).eq("email", Email);
  }

  Future likesLogics(String Email, int gender) async {
    if (gender == 2) {
      final data = await showData().getLikedEmailFemale(Email, widget.email);
      setState(() {
        userData = data;
        print(userData);
        print("CEK EMAIL MASUK${widget.email} COWO");
        print("CEK EMAIL MASUK${Email}");
      });
    } else if (gender == 1) {
      final data = await showData().getLikedEmailMale(Email, widget.email);
      setState(() {
        userData = data;
        // print(userData);
      });
    }

    if (userData!["Email_1"] == widget.email &&
        userData!["Email_2"] == Email &&
        userData!["Check"] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
      updateLikes(widget.email);
      if (gender == 1) {
        print("MASUK SINI");
        updateLikesStatusFemaletoMale(widget.email, Email);
      } else if (gender == 2) {
        print("MASUK SINI2");
        updateLikesStatusMaletoFemale(widget.email, Email);
      }
    }
  }

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await showData().getUserDataByEmail(widget.email);
      final datas = await showData().getUserDataByEmail(user.email.toString());
      setState(() {
        userData = data;
        userDatas = datas;
        // print(userData);
      });
    }
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

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    super.initState();
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            const Text(
              "View Profile",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEC7FA9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: Image.network(
                          userData!["ProfilePicture"],
                          fit: BoxFit.cover,
                          height: screenHeight * 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextBackgroundRow1(
                            [
                              '${userData!["Fullname"]}',
                              '${userData!["Age"]}',
                              '${userData!['Hobi']?['Hobi'] ?? 'null'}',
                              '${userData!['Angkatan']?['Angkatan'] ?? 'null'}',
                              '${userData!['Zodiak']?['Zodiak'] ?? 'null'}',

                              // '${widget.}',
                            ], //nanti biar list disini banyak
                          ),
                          buildTextBackgroundRow2(
                            [
                              '${userData!['Ethnic']?['Ethnic'] ?? 'null'}',
                              '${userData!['Looking_For']?['LookingFor'] ?? 'null'}',
                              // '${widget.}',
                            ], //nanti biar list disini banyak
                          ),
                          SizedBox(height: screenWidth * 0.05),
                          Row(
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
                                  userDatabase().LikeLogic(
                                      savedUser(
                                          Email1: widget.email,
                                          Email2: user!.email.toString()),
                                      userData!["GenderID"]);
                                  userDatabase().ChatInsert(
                                      savedUser(
                                          Email1: user!.email.toString(),
                                          Email2: widget.email),
                                      userData!["GenderID"]);
                                  // var datas = await showData().AlreadyLiked(Email!);

                                  emails = widget.email;
                                  // print("DataaaaEUY: ${emails!}");
                                  await fetchUserData();
                                  userDatabase().topLikeds(
                                      topLiked(email: widget.email, likes: 1));
                                  likesLogics(userDatas!["Email"],
                                      userDatas!["GenderID"]);
                                  print("GENDER ${userDatas!["GenderID"]}");
                                  print("GENDER ${userData!["GenderID"]}");

                                  Navigator.of(context).pop();
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
                        ],
                      ),
                    ),

                    // Text(widget.name),
                    // Text(widget.age),
                    // Text(widget.birthdate),
                    SizedBox(
                      height: screenHeight * 0.5, //lebar kebawah
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
