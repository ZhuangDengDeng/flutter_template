// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userName = json['userName'] as String
    ..loved = json['+1'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'userName': instance.userName, '+1': instance.loved};
