import 'package:example_architecture/common/models/test_model.dart';
import 'package:example_architecture/core/constants/endPoint/end_point_constants.dart';
import 'package:example_architecture/core/services/locator/locator_service.dart';
import 'package:example_architecture/core/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.go('/test1/detail');
          },
          child: const Text('Test 1'),
        ),
      ),
    );
  }
}

class Test1Detail extends StatelessWidget {
  const Test1Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Test 1 Detail'),
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text('Test 2'),
          onTap: (){
            setState(() {

            });
          },
        ),
      ),
    );
  }
}

class Test3 extends StatelessWidget {
  const Test3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            var res = await getIt<NetworkService>().get<Welcome, Welcome>(
              EndPointConstants.test,
              parseModel: Welcome(),
            );
            print(res?.title);
          },
          child: const Text('Test 3'),
        ),
      ),
    );
  }
}
