// ignore_for_file: unused_field, unused_element, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:flutter_miarma/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_miarma/models/create_post_dto.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository_impl.dart';
import 'package:flutter_miarma/screens/home_screen.dart';
import 'package:flutter_miarma/widgets/error_page.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mensajeController = TextEditingController();
  late PostRepository postRepository;
  late ImagePickBloc _imagePickBloc;
  late PostBloc _postBloc;

  late CreatePostDto createPostDto;
  var postImage;
  late ImageSource source;

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
    _imagePickBloc = ImagePickBloc();
    _postBloc = PostBloc(postRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _imagePickBloc),
          BlocProvider(create: (context) => _postBloc)
        ],
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              _postBloc;
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
        BlocBuilder<ImagePickBloc, ImagePickBlocState>(
            bloc: _imagePickBloc,
            builder: (context, state) {
              if (state is ImagePickBlocInitial) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ImagePickBloc>(context)
                            .add(const SelectImageEvent(ImageSource.gallery));
                      },
                      child: const Text('Select Image')),
                ));
              } else if (state is ImageSelectedErrorState) {
                return ErrorPage(
                    message: state.message,
                    retry: () {
                      context
                          .watch<ImagePickBloc>()
                          .add(SelectImageEvent(source));
                    });
              } else if (state is ImageSelectedSuccessState) {
                postImage = state.pickedFile.path;
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
                        ]),
                  ),
                );
              } else {
                return const Text('Not support');
              }
            }),
        BlocBuilder(
            bloc: _postBloc,
            builder: (context, state) {
              if (state is PostInitial) {
                return Column(children: [
                  formPost(),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          final createPostDto =
                              CreatePostDto(message: mensajeController.text);
                          BlocProvider.of<PostBloc>(context)
                              .add(NewPost(createPostDto, postImage));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text('Upload Image')),
                  )
                ]);
              } else if (state is PostFetchError) {
                return ErrorPage(
                    message: state.message,
                    retry: () {
                      context
                          .watch<PostBloc>()
                          .add(NewPost(createPostDto, postImage));
                    });
              } else if (state is NewPostState) {
                return Column(children: [
                  formPost(),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          final createPostDto =
                              CreatePostDto(message: mensajeController.text);
                          BlocProvider.of<PostBloc>(context)
                              .add(NewPost(createPostDto, postImage));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text('Upload Image')),
                  )
                ]);
              } else {
                return const Text('Not support');
              }
            }),
      ],
    );
  }

  Widget formPost() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
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
    );
  }
}

/*

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
    Column(
      children: [
        BlocConsumer<ImagePickBloc, ImagePickBlocState>(
          bloc: _imagePickBloc,
          listenWhen: (context, state) {
            return state is ImageSelectedSuccessState ||
                state is ImageSelectedErrorState;
          },
          listener: (context, state) {
            if (state is ImageSelectedSuccessState) {
              postImage = state.pickedFile.path;
            } else if (state is ImageSelectedErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is ImagePickBlocInitial;
          },
          builder: (context, state) {
            if (state is ImagePickBlocInitial) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ImagePickBloc>(context)
                          .add(const SelectImageEvent(ImageSource.gallery));
                    },
                    child: const Text('Select Image')),
              ));
            } else if (state is ImageSelectedSuccessState) {
              postImage = state.pickedFile.path;
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
                      ]),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        BlocConsumer<PostBloc, PostEvent>(
          bloc: _postBloc,
          listenWhen: (context, state) {
            return state is NewPostState || state is NewPostErrorState;
          },
          listener: (context, state) {
            if (state is NewPostState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else if (state is NewPostErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is PostInitial;
          },
          builder: (context, state) {
            if (state is PostInitial) {
              return Container();
            }
          },
        )
      ],
    );
    
    Column(
      children: [
        BlocBuilder<ImagePickBloc, ImagePickBlocState>(
            bloc: _imagePickBloc,
            builder: (context, state) {
              if (state is ImagePickBlocInitial) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ImagePickBloc>(context)
                            .add(const SelectImageEvent(ImageSource.gallery));
                      },
                      child: const Text('Select Image')),
                ));
              } else if (state is ImageSelectedErrorState) {
                return ErrorPage(
                    message: state.message,
                    retry: () {
                      context
                          .watch<ImagePickBloc>()
                          .add(SelectImageEvent(source));
                    });
              } else if (state is ImageSelectedSuccessState) {
                postImage = state.pickedFile.path;
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
                        ]),
                  ),
                );
              } else {
                return const Text('Not support');
              }
            }),
        BlocBuilder(
            bloc: _postBloc,
            builder: (context, state) {
              if (state is PostInitial) {
                return Column(children: [
                  formPost(),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          final createPostDto =
                              CreatePostDto(message: mensajeController.text);
                          BlocProvider.of<PostBloc>(context)
                              .add(NewPost(createPostDto, postImage));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text('Upload Image')),
                  )
                ]);
              } else if (state is PostFetchError) {
                return ErrorPage(
                    message: state.message,
                    retry: () {
                      context
                          .watch<PostBloc>()
                          .add(NewPost(createPostDto, postImage));
                    });
              } else if (state is NewPostState) {
                return Column(children: [
                  formPost(),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          final createPostDto =
                              CreatePostDto(message: mensajeController.text);
                          BlocProvider.of<PostBloc>(context)
                              .add(NewPost(createPostDto, postImage));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text('Upload Image')),
                  )
                ]);
              } else {
                return const Text('Not support');
              }
            }),
      ],
    );*/

/*
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
                                  final createPostDto = CreatePostDto(
                                      message: mensajeController.text);
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
  */
