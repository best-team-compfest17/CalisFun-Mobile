import 'package:calisfun/src/constants/constants.dart';
import 'package:calisfun/src/network/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:calisfun/src/core/core.dart'
    show Child, Difficulty, User, UserRepository, UserService;

import 'package:calisfun/src/network/network.dart'
    show ApiResponse, NetworkExceptions, Result, UserRepository;

import 'package:calisfun/src/shared/shared.dart' show UserPreference;

extension ResultTestX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => this is Success<T> ? (this as Success<T>).data : null;

  NetworkExceptions? get errorOrNull =>
      this is Failure<T> ? (this as Failure<T>).error : null;
}


class MockUserRepository extends Mock implements UserRepository {}
class MockUserPreference extends Mock implements UserPreference {}

Result<T> ok<T>(T value) => Result.success(value);
Result<T> err<T>(Object e) =>
    Result.failure(NetworkExceptions.getDioException(e), StackTrace.current);

void main() {
  late MockUserRepository repo;
  late MockUserPreference pref;
  late UserService service;

  setUpAll(() {
    registerFallbackValue(StackTrace.current);
  });

  setUp(() {
    repo = MockUserRepository();
    pref = MockUserPreference();
    service = UserService(userRepository: repo, userPreference: pref);
  });

  group('UserService.loginData', () {
    test('berhasil: simpan token lalu panggil meData dan return User', () async {
      const token = 'tok_abcdef123456';
      final apiLogin = ApiResponse.fromJson({'token': token});
      when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => ok(apiLogin));

      final apiMe = ApiResponse.fromJson({
        'id': 'u1',
        'username': 'zaki',
        'email': 'zaki@mail.com',
      });
      when(() => repo.me(any())).thenAnswer((_) async => ok(apiMe));
      when(() => pref.saveToken(token)).thenAnswer((_) async {});

      final result = await service.loginData(email: 'zaki@mail.com', password: 'secret');

      expect(result.isSuccess, true);
      verify(() => pref.saveToken(token)).called(1);
      verify(() => repo.me(token)).called(1);
    });

    test('gagal: response tidak punya token -> failure(badRequest)', () async {
      final apiLogin = ApiResponse.fromJson({'message': 'ok_tanpa_token'});
      when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => ok(apiLogin));

      final res = await service.loginData(email: 'a@a.com', password: 'x');

      expect(res.isFailure, true);
      verifyNever(() => pref.saveToken(any()));
      verifyNever(() => repo.me(any()));
    });
  });

  group('UserService.registerData', () {
    test('berhasil: ada token -> disimpan & user di-parse', () async {
      const token = 'tok_1234567890';
      final api = ApiResponse.fromJson({
        'data': {
          'token': token,
          'user': {'id': 'u1', 'username': 'zaki', 'email': 'z@mail.com'},
        }
      });

      when(() => repo.register(
        username: any(named: 'username'),
        email: any(named: 'email'),
        phoneNumber: any(named: 'phoneNumber'),
        password: any(named: 'password'),
        role: any(named: 'role'),
      )).thenAnswer((_) async => ok(api));
      when(() => pref.saveToken(token)).thenAnswer((_) async {});

      final res = await service.registerData(
        username: 'zaki',
        email: 'z@mail.com',
        phoneNumber: '0812',
        password: 'secret',
      );

      expect(res.isSuccess, true);
      verify(() => pref.saveToken(token)).called(1);
    });

    test('gagal: tidak ada user map -> failure(badRequest)', () async {
      final api = ApiResponse.fromJson({'data': {'token': 'tok_only'}});
      when(() => repo.register(
        username: any(named: 'username'),
        email: any(named: 'email'),
        phoneNumber: any(named: 'phoneNumber'),
        password: any(named: 'password'),
        role: any(named: 'role'),
      )).thenAnswer((_) async => ok(api));
      when(() => pref.saveToken(any())).thenAnswer((_) async {});

      final res = await service.registerData(
        username: 'zaki',
        email: 'z@mail.com',
        phoneNumber: '0812',
        password: 'secret',
      );

      expect(res.isFailure, true);
    });
  });

  group('UserService.meData', () {
    test('berhasil: parse map user valid', () async {
      final api = ApiResponse.fromJson({
        'id': 'u1',
        'username': 'zaki',
        'email': 'z@mail.com',
      });
      when(() => repo.me(any())).thenAnswer((_) async => ok(api));

      final res = await service.meData('tok');
      expect(res.isSuccess, true);
    });

    test('gagal: payload tidak valid -> failure', () async {
      final api = ApiResponse.fromJson({'data': 'string_tidak_valid'});
      when(() => repo.me(any())).thenAnswer((_) async => ok(api));

      final res = await service.meData('tok');
      expect(res.isFailure, true);
    });
  });

  group('UserService.promoteCountingDifficultyIfEligible', () {
    test('promote dari easy->medium ketika correct>=7 dan total>0', () async {
      when(() => pref.getToken()).thenAnswer((_) async => 'tok123');

      when(() => repo.updateCountingDifficulty(
        childId: any(named: 'childId'),
        token: any(named: 'token'),
        difficulty: 'medium',
      )).thenAnswer((_) async => ok(ApiResponse.fromJson({'ok': true})));

      final res = await service.promoteCountingDifficultyIfEligible(
        childId: 'c1',
        currentDifficulty: Difficulty.easy,
        correct: 7,
        total: 10,
      );

      expect(res.isSuccess, true);
      expect(res.valueOrNull, true);
      verify(() => repo.updateCountingDifficulty(
        childId: 'c1',
        token: 'tok123',
        difficulty: 'medium',
      )).called(1);
    });

    test('tidak promote jika sudah hard', () async {
      final res = await service.promoteCountingDifficultyIfEligible(
        childId: 'c1',
        currentDifficulty: Difficulty.hard,
        correct: 10,
        total: 10,
      );
      expect(res.isSuccess, true);
      expect(res.valueOrNull, false);
      verifyNever(() => repo.updateCountingDifficulty(
        childId: any(named: 'childId'),
        token: any(named: 'token'),
        difficulty: any(named: 'difficulty'),
      ));
    });

    test('tidak promote jika correct < 7 atau total <= 0', () async {
      final r1 = await service.promoteCountingDifficultyIfEligible(
        childId: 'c1',
        currentDifficulty: Difficulty.easy,
        correct: 6,
        total: 10,
      );
      final r2 = await service.promoteCountingDifficultyIfEligible(
        childId: 'c1',
        currentDifficulty: Difficulty.easy,
        correct: 7,
        total: 0,
      );
      expect(r1.valueOrNull, false);
      expect(r2.valueOrNull, false);
      verifyNever(() => repo.updateCountingDifficulty(
        childId: any(named: 'childId'),
        token: any(named: 'token'),
        difficulty: any(named: 'difficulty'),
      ));
    });
  });

  group('UserService.create/delete/fetch child + token checks', () {
    test('createChildProfile: gagal ketika token null/empty', () async {
      when(() => pref.getToken()).thenAnswer((_) async => null);

      final res = await service.createChildProfile(name: 'Kid');
      expect(res.isFailure, true);
      verifyNever(() => repo.createChildProfile(
        name: any(named: 'name'),
        token: any(named: 'token'),
        avatarFile: any(named: 'avatarFile'),
      ));
    });

    test('deleteChildProfile: sukses propagate true', () async {
      when(() => pref.getToken()).thenAnswer((_) async => 'tok');
      when(() => repo.deleteChildProfile(childId: any(named: 'childId'), token: any(named: 'token')))
          .thenAnswer((_) async => ok(ApiResponse.fromJson({'ok': true})));

      final res = await service.deleteChildProfile(childId: 'c1');
      expect(res.isSuccess, true);
      expect(res.valueOrNull, true);
    });

    test('fetchChildById: gagal saat token kosong', () async {
      when(() => pref.getToken()).thenAnswer((_) async => '');
      final res = await service.fetchChildById('c1');
      expect(res.isFailure, true);
    });
  });

  group('UserService.updateCountingDifficulty', () {
    test('meneruskan nilai easy|medium|hard sebagai string ke repo', () async {
      when(() => pref.getToken()).thenAnswer((_) async => 'tok');
      when(() => repo.updateCountingDifficulty(
        childId: any(named: 'childId'),
        token: any(named: 'token'),
        difficulty: 'hard',
      )).thenAnswer((_) async => ok(ApiResponse.fromJson({'ok': true})));

      final res = await service.updateCountingDifficulty(
        childId: 'c1',
        difficulty: Difficulty.hard,
      );

      expect(res.isSuccess, true);
      verify(() => repo.updateCountingDifficulty(
        childId: 'c1',
        token: 'tok',
        difficulty: 'hard',
      )).called(1);
    });
  });

  group('UserService.logout', () {
    test('berhasil: panggil repo.logout dan clearAllAuth', () async {
      when(() => pref.getToken()).thenAnswer((_) async => 'tok');
      when(() => repo.logout('tok'))
          .thenAnswer((_) async => ok(ApiResponse.fromJson({'ok': true})));
      when(() => pref.clearAllAuth()).thenAnswer((_) async {});

      final res = await service.logout();
      expect(res.isSuccess, true);
      expect(res.valueOrNull, true);
      verify(() => pref.clearAllAuth()).called(1);
    });

    test('gagal ketika token kosong', () async {
      when(() => pref.getToken()).thenAnswer((_) async => '');
      final res = await service.logout();
      expect(res.isFailure, true);
      verifyNever(() => repo.logout(any()));
    });
  });
}
