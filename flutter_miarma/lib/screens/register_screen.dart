// ignore_for_file: unused_field, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:flutter_miarma/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_miarma/models/sign_up_dto.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_miarma/widgets/error_page.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  final _formKeyImage = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController biographyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  late SignUpBloc _signInBloc;
  late ImagePickBloc _imagePickBloc;

  late SignUpDto signInDto;
  late ImageSource source;

  List<XFile>? _imageFileList;
  var avatarPath;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    _signInBloc = SignUpBloc(authRepository);
    _imagePickBloc = ImagePickBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _signInBloc),
          BlocProvider(create: (context) => _imagePickBloc)
        ],
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              _signInBloc;
              _imagePickBloc;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: _createBody(context),
            ),
          ),
        ));
  }

  _createBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SignUpBloc, SignUpState>(
          bloc: _signInBloc,
          builder: (context, state) {
            if (state is SignUpInitialState) {
              return form(context);
            } else if (state is SignUpErrorState) {
              return ErrorPage(
                  message: state.message,
                  retry: () {
                    context.watch<SignUpBloc>().add(DoSignUpEvent(signInDto));
                  });
            } else if (state is SignUpSuccessState) {
              //vincular los campos del formulario a una nueva variable SignUpDto
              return form(context);
            } else {
              return const Text('Not Support');
            }
          },
        ),
        BlocBuilder<ImagePickBloc, ImagePickBlocState>(
          bloc: _imagePickBloc,
          builder: (context, state) {
            if (state is ImagePickBlocInitial) {
              return formImage(context);
            } else if (state is ImageSelectedErrorState) {
              return ErrorPage(
                message: state.message,
                retry: () {
                  context.watch<ImagePickBloc>().add(SelectImageEvent(source));
                },
              );
            } else if (state is ImageSelectedSuccessState) {
              avatarPath = state.pickedFile.path;
              return Column(
                children: [
                  Image.file(
                    File(state.pickedFile.path),
                    height: 100,
                  ),
                  formImage(context)
                ],
              );
            } else {
              return const Text('Not support');
            }
          },
        ),
      ],
    );
  }

  Widget formImage(BuildContext context) {
    return Form(
        key: _formKeyImage,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ImagePickBloc>(context)
                          .add(const SelectImageEvent(ImageSource.gallery));
                    },
                    child: const Text('Select Image')))
          ],
        )));
  }

  Widget form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                        controller: usernameController,
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
                      controller: fullnameController,
                      decoration:
                          const InputDecoration(hintText: 'Nombre completo'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduzca su nombre.';
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
                      controller: emailController,
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
            Center(
              child: Card(
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      controller: biographyController,
                      decoration: const InputDecoration(hintText: 'Biografía'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduzca algo de biografía.';
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
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Contraseña'),
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
                      controller: password2Controller,
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
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Center(
                child: SizedBox(
                    width: 300,
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final signInDto = SignUpDto(
                              username: usernameController.text,
                              fullname: fullnameController.text,
                              email: emailController.text,
                              biography: biographyController.text,
                              password: passwordController.text,
                              password2: password2Controller.text);
                          BlocProvider.of<SignUpBloc>(context)
                              .add(DoSignUpEvent(signInDto));
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              top: 30, left: 30, right: 30),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'Sign In'.toUpperCase(),
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
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
                      Navigator.pushNamed(context, '/login');
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
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignInBloc(authRepository);
      },
      child: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SignInBloc, SignInState>(
          listenWhen: (context, state) {
            return state is SignInSuccessState || state is SignInErrorState;
          },
          listener: (context, state) {
            if (state is SignInSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else if (state is SignInErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is SignInInitialState || state is SignInLoadingState;
          },
          builder: (context, state) {
            if (state is SignInInitialState) {
              return form(context);
            } else if (state is SignInLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return form(context);
            }
          },
        ),
      ),
    );
  }
  */
