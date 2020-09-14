import 'package:equatable/equatable.dart';
import 'package:game_ui/model/tournament.dart';
import 'package:game_ui/model/tournament_element.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeFailure extends HomeState {}

class HomeSuccess extends HomeState {
  final Tournament tournament;
  final List<TournamentElement> tournaments;
  final bool hasReachedMax;

  const HomeSuccess({
    this.tournament,
    this.hasReachedMax,
    this.tournaments,
  });

  HomeSuccess copyWith({
    Tournament tournament,
    bool hasReachedMax,
    List<TournamentElement> tournaments,
  }) {
    return HomeSuccess(
      tournament: tournaments ?? this.tournament,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      tournaments: tournaments ?? this.tournaments,
    );
  }

  @override
  List<Object> get props => [tournament, hasReachedMax];

  @override
  String toString() =>
      'HomeSuccess { Tournaments: ${tournament.data.tournamentCount}, hasReachedMax: $hasReachedMax  }';
}
