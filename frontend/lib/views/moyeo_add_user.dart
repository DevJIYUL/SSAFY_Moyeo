import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/app_view_model.dart';
import '../view_models/search_bar_view_model.dart';
import '../view_models/user_search_bar_view_model.dart';
import '../views/user_search_bar_view.dart';

class MoyeoAddUser extends StatelessWidget {
  final List<Map<String, dynamic>> members;

  const MoyeoAddUser({required this.members, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyWidth = MediaQuery.of(context).size.width;
    final MyHeight = MediaQuery.of(context).size.height;

    return Consumer<AppViewModel>(builder: (_, appViewModel, __) {
      return ChangeNotifierProvider(
          create: (BuildContext context) => SelectedUsersProvider(context,
              nowMoyeo: appViewModel.userInfo.moyeoTimelineId),
          builder: (context, _) {
            return Consumer<SelectedUsersProvider>(
                builder: (context, selectedUsersProvider, _) {
              final selectedUser = selectedUsersProvider.selectedUsers;

              return Stack(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * (0.1),
                          left: MediaQuery.of(context).size.width * (0.1)),
                      padding: EdgeInsets.all(MyWidth * (0.05)),
                      width: MediaQuery.of(context).size.width * (0.8),
                      height: MediaQuery.of(context).size.height * (0.55),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(2, 2),
                            )
                          ]),
                      child: selectedUser.isNotEmpty
                          ? ListView.builder(
                              itemCount: selectedUser.length,
                              itemBuilder: (BuildContext context, int index) {
                                final user = selectedUser[index];
                                return ListTile(
                                  leading: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: ExtendedImage.network(
                                        user.profileImageUrl,
                                        fit: BoxFit.cover,
                                        cache: true,
                                      ),
                                    ),
                                  ),
                                  title: Text(user.nickname),
                                  trailing: IconButton(
                                    onPressed: () {
                                      selectedUsersProvider.removeUser(user);
                                    },
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.redAccent),
                                  ),
                                );
                              },
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(
                                "동행멤버를 추가해주세요",
                                style: TextStyle(
                                  fontSize: MyHeight * (0.03),
                                ),
                              )),
                    ),
                  ),
                  selectedUser.isNotEmpty
                      ? Positioned(
                          top: MediaQuery.of(context).size.height * (0.68),
                          left: MediaQuery.of(context).size.width * (0.32),
                          right: MediaQuery.of(context).size.width * (0.32),
                          bottom: MediaQuery.of(context).size.height * (0.07),
                          child: InkWell(
                            onTap: () {
                              final addUserProvider = selectedUsersProvider;
                              addUserProvider.addMoyeoUser(
                                  context,
                                  appViewModel.userInfo.moyeoTimelineId,
                                  this.members);
                              Navigator.pop(context);
                            },
                            child: Container(
                                width: MyWidth * (0.4),
                                margin:
                                    EdgeInsets.only(left: MyWidth * (0.001)),
                                padding: EdgeInsets.only(
                                    left: MyWidth * (0.03),
                                    right: MyWidth * (0.03),
                                    top: MyHeight * (0.006),
                                    bottom: MyHeight * (0.006)),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        offset: const Offset(2, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: <Color>[
                                      Colors.redAccent,
                                      Colors.orangeAccent,
                                    ])),
                                child: Row(children: [
                                  const Icon(
                                    Icons.group_add,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "  모여 초대 보내기",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MyHeight * (0.017)),
                                  ),
                                ])),
                          ))
                      : Container(),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ChangeNotifierProvider<SearchBarViewModel>(
                        create: (_) => SearchBarViewModel(isMyFeed: false),
                        child: UserSearchBar(members: members),
                      ),
                    ),
                  )
                ],
              );
            });
          });
    });
  }
}
