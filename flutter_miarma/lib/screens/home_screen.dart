import 'package:flutter/material.dart';
import 'package:flutter_miarma/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ))),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _profilePhoto();
                    }),
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _post();
                    }),
              ),
            ],
          ),
        ));
  }

  Widget _profilePhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FloatingActionButton(
            elevation: 100,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15, left: 15),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.red, width: 1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/avatar.jpeg',
                  width: 40,
                ),
              ),
            ),
          ),
          const Text('Nombre de usuario',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _post() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.red, width: 3)),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 15,
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/avatar.jpeg',
                        width: 40,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 14, left: 5),
                  child: Text(
                    'Nombre Usuario',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/fondo1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.favorite_border),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.comment_outlined),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.send_outlined),
                  )
                ],
              )
            ]),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              margin: const EdgeInsets.only(top: 15, left: 10),
              alignment: Alignment.centerLeft,
              child: const Text('Comentarios',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold)),
            )
          ],
        ));
  }
}
