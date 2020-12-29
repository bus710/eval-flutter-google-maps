/* In this page, it renders pages depend on the state of the rootModel. */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Backend
import 'rootModel.dart';
// Utils
import 'utils/enums.dart';
// Pages
import 'pages/mainPage.dart';
import 'pages/mapPage.dart';
// Viewmodels
import 'viewModels/mainVM.dart';
import 'viewModels/mapVM.dart';

class RootPage extends StatelessWidget {
  RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _rootModel = Provider.of<RootModel>(context);

    var _mainViewModel = MainViewModel(context);
    var _mapViewModel = MapViewModel(context);

    // Routing
    switch (_rootModel.getAppStatus()) {
      case AppStatus.map:
        return _getScaffold(context, MapPage(viewModel: _mapViewModel));
      default:
        return _getScaffold(context, MainPage(viewModel: _mainViewModel));
    }
  }

  // If the screen size is big enough,
  //  collect components as scaffold.
  Widget _getScaffold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: _getAppBar(context, body),
      body: _getBody(context, body),
    );
  }

  // This decorates the app bar - the title and menu button
  Widget _getAppBar(BuildContext context, Widget body) {
    // var _rootModel = Provider.of<RootModel>(context);
    return PreferredSize(
      // place the preferred height size
      // preferredSize: Size.fromHeight(75.0),
      preferredSize: Size.fromHeight(20),
      child: AppBar(),
    );
  }

  // This combines the sidebar and pages as the body
  Widget _getBody(BuildContext context, Widget body) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(child: body),
        ),
      ],
    );
  }
}
