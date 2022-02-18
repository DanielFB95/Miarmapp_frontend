import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                const Center(
                    child: Text('Instagram',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.black54))),
                const Padding(padding: EdgeInsets.only(top: 25)),
                const Center(
                    child: Text('Creación de una',
                        style: TextStyle(fontSize: 20, color: Colors.black54))),
                const Center(
                    child: Text('nueva cuenta.',
                        style: TextStyle(fontSize: 20, color: Colors.black54))),
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
                                return 'Por favor introduzca algún texto';
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
                              return 'Por favor introduzca la contraseña';
                            }
                            return null;
                          },
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
                          decoration: const InputDecoration(
                              hintText: 'Repita la contraseña'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor introduzca de nuevo la contraseña.';
                            }
                            return null;
                          },
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
                          decoration: const InputDecoration(hintText: 'E-mail'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor introduzca un e-mail';
                            }
                            return null;
                          },
                        ),
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
                        child: const Text('Crear cuenta'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Ya eres miembro?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Accede.',
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
