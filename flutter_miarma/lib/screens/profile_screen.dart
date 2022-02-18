import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Nombre de usuario',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.add_box_outlined),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.menu),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 15),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.red, width: 2)),
                  child: FloatingActionButton(
                    elevation: 50,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/avatar.jpeg',
                        width: 150,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 5),
                  child: Column(
                    children: const [
                      Text(
                        '0,000',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Post',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 5),
                  child: Column(
                    children: const [
                      Text(
                        '0,000',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 5),
                  child: Column(
                    children: const [
                      Text(
                        '0,000',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Container(
                height: 15,
                margin: const EdgeInsets.only(top: 15, left: 10),
                alignment: Alignment.centerLeft,
                child: const Text('Nombre de usuario',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              )),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 15, left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(fontSize: 12)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Lorem ipsum dolor sit amet.',
                      style: TextStyle(fontSize: 12)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text('Link.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blueAccent,
                          )),
                    )),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  minWidth: 150,
                  child: Text('Editar perfil'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
