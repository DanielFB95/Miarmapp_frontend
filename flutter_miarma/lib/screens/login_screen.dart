import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_miarma/screens/menu_screen.dart';
import 'package:flutter_miarma/utils/preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthRepository authRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    PreferenceUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(authRepository);
      },
      child: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          listenWhen: (context, state) {
            return state is LoginSuccessState || state is LoginErrorState;
          },
          listener: (context, state) {
            if (state is LoginSuccessState) {
              PreferenceUtils.setString("token", state.loginResponse.token);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            } else if (state is LoginErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is LoginInitialState || state is LoginLoadingState;
          },
          builder: (context, state) {
            if (state is LoginInitialState) {
              return form(context);
            } else if (state is LoginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return form(context);
            }
          },
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget form(BuildContext context) {
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
                            controller: emailController,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.email),
                                suffixIconColor: Colors.white,
                                hintText: 'Email'),
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
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.vpn_key),
                              suffixIconColor: Colors.white,
                              hintText: 'Contraseña'),
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
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final loginDto = LoginDto(
                                  email: emailController.text,
                                  password: passwordController.text);
                              BlocProvider.of<LoginBloc>(context)
                                  .add(DoLoginEvent(loginDto));
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Login'.toUpperCase(),
                                style: const TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              )),
                        )),
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
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
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
