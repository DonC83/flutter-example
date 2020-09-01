import 'package:cupertino_example/model/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductListTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel> (
      builder: (context, model, child) {
        return const CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            )
          ],
        );
      },
    );
  }
}