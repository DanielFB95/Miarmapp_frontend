// ignore_for_file: unused_field, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mensajeController = TextEditingController();

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return ImagePickBloc();
        },
        child: BlocConsumer<ImagePickBloc, ImagePickBlocState>(
            listenWhen: (context, state) {
              return state is ImageSelectedSuccessState;
            },
            listener: (context, state) {},
            buildWhen: (context, state) {
              return state is ImagePickBlocInitial ||
                  state is ImageSelectedSuccessState;
            },
            builder: (context, state) {
              if (state is ImageSelectedSuccessState) {
                //print('PATH ${state.pickedFile.path}');
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.file(
                            File(state.pickedFile.path),
                          ),
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              width: 300,
                              child: TextFormField(
                                controller: mensajeController,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.text_fields),
                                    suffixIconColor: Colors.white,
                                    hintText: 'Mensaje'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor introduce algún texto';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  //BlocProvider.of<ImagePickBloc>(context).add();

                                  // el evento que debeis crear en el BLoC para
                                  // poder subir la imagen que tenemos guardada en
                                  // state.pickedFile.path
                                },
                                child: const Text('Upload Image')),
                          )
                        ]),
                  ),
                );
              }
              return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ImagePickBloc>(context)
                            .add(const SelectImageEvent(ImageSource.gallery));
                      },
                      child: const Text('Select Image')));
            }),
      ),
    );
  }
}
