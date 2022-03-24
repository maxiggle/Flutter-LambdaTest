part of 'authors_bloc.dart';

abstract class AuthorsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostFetched extends AuthorsEvent {}
