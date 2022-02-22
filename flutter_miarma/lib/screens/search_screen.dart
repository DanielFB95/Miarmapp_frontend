import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Card(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.search), hintText: 'Búsqueda'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor introduce algún texto';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 700,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(100, (index) {
                  return Center(child: _photos());
                }),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _photos() {
    return SizedBox(
      width: 125,
      height: 125,
      child: ClipRRect(
        child: Image.asset(
          'assets/images/fondo1.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
