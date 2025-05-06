import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Aboutuspage extends StatefulWidget {
  const Aboutuspage({super.key});

  @override
  State<Aboutuspage> createState() => _AboutuspageState();
}

class _AboutuspageState extends State<Aboutuspage> {
  List<String> imageList = [
    'lib/assets/Ariya_prof.png',
    'lib/assets/Delbert_prof.png',
    'lib/assets/Felix_prof.png',
    'lib/assets/Adit_prof.png',
  ];

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
            color: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                },
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Text(
                "About us",
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
      body: Column(children: [
        SizedBox(
          child: CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.25, // Tinggi carousel
              autoPlay: true, // auto geser geser
              enlargeCenterPage: true, // efek kl ditengah ngesoom die
              aspectRatio: 16 / 9, // Rasio aspek
              // onPageChanged: (index, reason) {},
            ),
            items: imageList
                .map((item) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 15.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: screenWidth * 1,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.001,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Our Purpose",
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
                  "VISI",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Menjadi platform terpercaya untuk mempererat koneksi antar mahasiswa BINUS sebagai teman, sahabat, atau pasangan hidup.",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "MISI",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "- Menciptakan ruang aman dan nyaman untuk berkenalan.\n"
                  "- Menghubungkan mahasiswa dengan minat dan nilai yang sejalan.\n"
                  "- Membantu membangun relasi yang sehat, tulus, dan penuh makna.",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Why ?",
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
                  "- Khusus Mahasiswa : Semua pengguna diverifikasi dengan email kampus.\n"
                  "- Aman & Serius : Fitur keamanan untuk melindungi identitas dan privasi pengguna.\n"
                  "- Asyik & Mudah: Swipe, match, dan ngobrol tanpa ribet.\n"
                  "- Lebih dari Cari Jodoh: Temukan teman sekelas, partner belajar, hingga komunitas baru!\n",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text(
                  "The Story",
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
                  "Beefriend dimulai dari obrolan santai antara beberapa mahasiswa yang kesulitan memperluas lingkaran pertemanan di kampus. Dari sana, kami bertekad membuat platform yang menghubungkan mahasiswa bukan hanya untuk kencan, tapi juga untuk persahabatan dan kolaborasi masa depan.",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
