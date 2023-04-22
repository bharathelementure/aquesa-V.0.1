 /*const Icon(
                            Icons.account_circle_rounded,
                            size: 72,
                            color: Color(0xFFFFFFFF),
                          ),*/
                          // List of user can be find
                          /*StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading..');
                                }
                                return ListView(
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return ListTile(title: Text(data['name'],style: const TextStyle(
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF)),),
                                    subtitle: Text(data['phone']),);
                                  }
                                ).toList().cast());
                              })*/
                              // userdata by index[0]
                          /*StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              print(snapshot.requireData.docs
                                  .asMap()[0]!['phone']
                                  .toString());
                              print(snapshot.requireData.docs);
                              print('hello');
                              print(curr);
                              print(snapshot.data!.docs.asMap()[0]!['phone']);
                              return Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // snapshot
                                      //     .inState(ConnectionState.active)
                                      //     .data!
                                      //     .docs[1]
                                      //     .get('name'),
                                      snapshot.data!.docs[1]['name'],
                                      style: const TextStyle(
                                          fontFamily: 'dmsans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      snapshot.data!.docs[1]['phone']
                                          .toString(),
                                      // snapshot.requireData.docs
                                      //     .asMap()[0]!['phone']
                                      //     .toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'dmsans',
                                          color: Color(0xFFABABAB)),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),*/
                          /*Text(
                            curr.displayName!,
                            // 'Nagathihalli Bharath',
                            style: const TextStyle(
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color(0xFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            curr.phoneNumber!,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'dmsans',
                                color: Color(0xFFABABAB)),
                          ),*/
// Radio list style
 /*Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [RadioListTile(title: Text('Owner'),value: "Owner",
              groupValue: appliences, onChanged: (value){}),
            RadioListTile(title: Text('Tenant',style: TextStyle(fontFamily: 'raleway',
            fontWeight: FontWeight.w700,fontSize: 12,color: Color(0xFF181D27)),),
                value: "Tenant", groupValue: appliences, onChanged: (value){})],)*/