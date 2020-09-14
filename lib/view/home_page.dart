import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_ui/app_localization/app_localization.dart';
import 'package:game_ui/blocs/homepage/bloc.dart';
import 'package:game_ui/blocs/language/bloc.dart';
import 'package:game_ui/common/utility.dart';
import 'package:game_ui/helper/shared_preference_manager.dart';
import 'package:game_ui/model/user_stats.dart';
import 'package:game_ui/view/language_selector_page.dart';
import 'package:game_ui/view/login.dart';
import 'package:game_ui/view/widgets/bottom_loader.dart';
import 'package:game_ui/view/widgets/error_page.dart';
import 'package:game_ui/view/widgets/recommended_list_item.dart';
import 'package:game_ui/view/widgets/user_image.dart';
import 'package:game_ui/view/widgets/user_info.dart';
import 'package:game_ui/view/widgets/user_stats_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();

    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
              child: Icon(
                Icons.short_text,
                size: 24.0,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Text(
                'Flyingwolf',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.translate,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectLanguage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () async {
              final sharedPrefManager = await SharedPreferencesManager.instance;
              sharedPrefManager.setLoginStatus('LoggedOut');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (r) => false,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeFailure) {
            return Center(
              child: ErrorComponent(
                buttonText:
                    AppLocalizations.of(context).translate('retry_text'),
                function: () {
                  _homeBloc.add(HomeFetched());
                },
                message: AppLocalizations.of(context)
                    .translate('loading_data_error_message'),
                textColor: Colors.black,
              ),
            );
          }
          if (state is HomeSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                  _homeBloc.add(HomeFetched());
                }
                return true;
              },
              child: SafeArea(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: UserImage(
                                      radius: 50,
                                    ),
                                  ),
                                  UserInfo(
                                    username: 'Simon Baker',
                                    eloRating: 2210,
                                  )
                                ],
                              ),

                              //Section User Stats
                              Container(
                                width: double.maxFinite,
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runAlignment: WrapAlignment.center,
                                  alignment: WrapAlignment.center,
                                  spacing: 0,
                                  children: [
                                    UserStatsWidget(
                                      title: AppLocalizations.of(context)
                                          .translate('tournament_played_text'),
                                      score: '34',
                                      gradientColors: [
                                        HexColor("#E57E00"),
                                        HexColor("#EBA000"),
                                        //HexColor("#24243e"),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    UserStatsWidget(
                                      title: AppLocalizations.of(context)
                                          .translate('tournament_played_won'),
                                      score: '09',
                                      gradientColors: [
                                        //HexColor("#155799"),
                                        HexColor("#713AA9"),
                                        HexColor("#9C51BA"),
                                        //HexColor("#155799"),
                                      ],
                                    ),
                                    UserStatsWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                              'tournament_wining_percentage'),
                                      score: '26 %',
                                      gradientColors: [
                                        HexColor("#EC5845"),
                                        HexColor("#EF7D4F"),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('recommended_for_you_text'),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Make the initial height of the SliverAppBar larger than normal.
                      expandedHeight: 250,
                    ),
                    SliverList(
                      //Use a delegate to build items as they're scrolled on screen.
                      delegate: SliverChildBuilderDelegate(
                        //(context, index) => ListTile(title: Text('Item #$index')),
                        (context, index) {
                          if (state.tournaments.isEmpty) {
                            return Center(
                              child: ErrorComponent(
                                buttonText: AppLocalizations.of(context)
                                    .translate('retry_text'),
                                function: () {
                                  _homeBloc.add(HomeFetched());
                                },
                                message: AppLocalizations.of(context).translate(
                                    'loading_tournament_error_message'),
                                textColor: Colors.black,
                              ),
                            );
                          }
                          return index >= state.tournaments.length
                              ? BottomLoader()
                              : RecommendedListItem(
                                  coverUrl: state.tournaments[index].coverUrl,
                                  gameName: state.tournaments[index].gameName,
                                  name: state.tournaments[index].name,
                                );
                        },

                        childCount: state.hasReachedMax
                            ? state.tournaments.length
                            : state.tournaments.length + 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
