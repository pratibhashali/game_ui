import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:game_ui/blocs/homepage/homepage_event.dart';
import 'package:game_ui/blocs/homepage/homepage_state.dart';
import 'package:game_ui/model/tournament.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final http.Client httpClient;
  Connectivity connectivity = Connectivity();
  HomeBloc({@required this.httpClient}) : super(HomeInitial());

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
    Stream<HomeEvent> events,
    TransitionFunction<HomeEvent, HomeState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final currentState = state;
    if (event is HomeFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is HomeInitial) {
          //Initial call
          final tournament = await _fetchHomes(10, "");
          yield HomeSuccess(
              tournament: tournament,
              hasReachedMax: false,
              tournaments: tournament.data.tournaments);
          return;
        }
        if (currentState is HomeSuccess) {
          final tournament =
              await _fetchHomes(10, currentState.tournament.data.cursor);
          yield tournament.data.tournaments.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : HomeSuccess(
                  tournament: tournament,
                  tournaments:
                      currentState.tournaments + tournament.data.tournaments,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield HomeFailure();
      }
    }
  }

  bool _hasReachedMax(HomeState state) =>
      state is HomeSuccess && state.hasReachedMax;

  Future<Tournament> _fetchHomes(int limit, String cursor) async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final response = await httpClient.get(
          'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=$limit&status=all&cursor=$cursor');
      if (response.statusCode == 200) {
        final tournament = tournamentFromJson(response.body);
        return tournament;
      } else {
        throw Exception('Error fetching tournaments.');
      }
    } else {
      throw Exception('Error fetching tournaments.');
    }
  }
}
