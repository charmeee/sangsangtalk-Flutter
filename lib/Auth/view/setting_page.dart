import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sangsangtalk/Auth/models/user_model.dart';
import 'package:sangsangtalk/Common/widget/appbar.dart';

import '../provider/user_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserInfo? userInfo = ref.watch(userNotifierProvider);
    if (userInfo == null)
      return Scaffold(
        body: Container(
          child: Center(
            child: Text('로그인이 필요합니다.'),
          ),
        ),
      );

    return Scaffold(
      appBar: customAppBar(context, title: '설정'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "계정",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text('이름'),
                      subtitle: Text(userInfo.name),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('아이디'),
                      subtitle: Text(userInfo.username),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('이메일'),
                      subtitle: Text(userInfo.email),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('닉네임'),
                      subtitle: Text(userInfo.nickname),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('계좌 번호'),
                      subtitle: Text(userInfo.accountNumber),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('비밀번호'),
                      subtitle: Text('********'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "알림",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text('알림 설정'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeTrackColor: Colors.indigo[100],
                        activeColor: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('로그아웃'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    try {
                      await ref.read(userNotifierProvider.notifier).logout();
                    } catch (e) {
                      print(e);
                    }
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
//
// class SettingPage extends ConsumerStatefulWidget {
//   const SettingPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ConsumerState createState() => _SettingPageState();
// }
//
// class _SettingPageState extends ConsumerState<SettingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(context, title: '설정'),
//       body: Center(
//         child: Text('설정'),
//       ),
//     );
//   }
// }
