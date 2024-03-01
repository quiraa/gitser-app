import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gitser/features/gitser/data/models/response/users/user_response.dart';

class AvailableUserContent extends StatelessWidget {
  final List<UserResponseItem> listUsers;
  final void Function(String username)? onUserClicked;

  const AvailableUserContent({
    Key? key,
    required this.listUsers,
    required this.onUserClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      itemCount: listUsers.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8.0,
      ),
      itemBuilder: (context, index) {
        final UserResponseItem user = listUsers[index];
        return UserCardItem(
          user: user,
          onUserClicked: onUserClicked,
        );
      },
    );
  }
}

class UserCardItem extends StatelessWidget {
  final UserResponseItem user;
  final void Function(String username)? onUserClicked;

  const UserCardItem({
    Key? key,
    required this.user,
    required this.onUserClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onUserClicked!(user.login ?? '');
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        user.avatarUrl ?? '',
                      ),
                      child: user.avatarUrl != null
                          ? null
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.login ?? '',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'ID: ${user.id ?? 0}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
