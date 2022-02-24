import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma/blocs/person_bloc/person_bloc.dart';
import 'package:flutter_miarma/models/person_response.dart';
import 'package:flutter_miarma/repositories/person_repository/person_repository.dart';
import 'package:flutter_miarma/repositories/person_repository/person_repository_impl.dart';
import 'package:flutter_miarma/widgets/error_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late PersonRepository personRepository;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    personRepository = PersonRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PersonBloc(personRepository)..add(const FetchPerson());
      },
      child: Scaffold(body: _createPerson(context)),
    );
  }

  _createPerson(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        if (state is PersonInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PersonFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PersonBloc>().add(const FetchPerson());
            },
          );
        } else if (state is PersonFetched) {
          return _createPersonView(context, state.person);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPersonView(BuildContext context, Person person) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 500,
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/");
                          },
                          child: const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  '<',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                        ),
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                person.fullName,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 3,
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
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 15, left: 15),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.red, width: 2)),
                        child: FloatingActionButton(
                          heroTag: null,
                          elevation: 100,
                          backgroundColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pushNamed(context, "/profile");
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                imageUrl: person.avatar
                                    .replaceAll('localhost', '10.0.2.2'),
                                fit: BoxFit.cover,
                                height: double.infinity,
                              )),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 5),
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 5),
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 5),
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
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Container(
                      height: 15,
                      margin: const EdgeInsets.only(top: 15, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(person.fullName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 15, left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(person.biography,
                            style: const TextStyle(fontSize: 12)),
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
                        minWidth: 50,
                        child: const Text('Editar perfil'),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 70,
              child: TabBar(
                indicatorColor: Colors.red,
                controller: tabController,
                tabs: const [
                  Tab(
                      icon: Icon(
                    Icons.directions_car,
                    color: Colors.grey,
                  )),
                  Tab(
                      icon: Icon(
                    Icons.directions_transit,
                    color: Colors.grey,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: TabBarView(
                controller: tabController,
                children: [
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(100, (index) {
                      return Center(child: _photos());
                    }),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(100, (index) {
                      return Center(child: _photos());
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photos() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
        width: 125,
        height: 125,
        child: ClipRRect(
          child: Image.asset(
            'assets/images/fondo1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
