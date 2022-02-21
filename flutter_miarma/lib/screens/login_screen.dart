import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(245, 245, 245, 245),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 75)),
                Center(
                  child: SizedBox(
                    width: 125,
                    child: Image.asset(
                      'assets/images/logo_miarmapp.png',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 25)),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: Card(
                      child: SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Nombre de usuario'),
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
                Center(
                  child: Card(
                    child: SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'Contraseña'),
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
                const SizedBox(
                  width: 350,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Recuperar contraseña',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Procesando datos')),
                            );
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                const SizedBox(
                    width: 400,
                    child: Text(
                      '----- O continua con -----',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: Card(
                          child: Icon(
                            Icons.email,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: Card(
                          child: Icon(
                            Icons.facebook,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No eres miembro?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Regístrate',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.blueAccent,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
