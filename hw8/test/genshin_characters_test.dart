import 'package:cs311hw08/genshin_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'genshin_characters_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('returns GenshinCharacters if the http call completes successfully',
      () async {
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get(Uri.parse('https://api.genshin.dev/characters')))
        .thenAnswer((_) async => http.Response(
            '["albedo","aloy","amber","arataki-itto","ayaka","ayato"]', 200));
    expect(await fetchCharacters(client), isA<GenshinCharacters>());
  });

  test('throws an exception if the http call completes with an error', () {
    final client = MockClient();
// Use Mockito to return an unsuccessful response when it calls the
// provided http.Client.
    when(client.get(Uri.parse('https://api.genshin.dev/characters')))
        .thenAnswer((_) async => http.Response('Not Found', 404));
    expect(fetchCharacters(client), throwsException);
  });

  test('returns GenshinCharacterInfo if the http call completes successfully',
      () async {
    final client = MockClient();
// Use Mockito to return an unsuccessful response when it calls the
// provided http.Client.
    when(client.get(Uri.parse('https://api.genshin.dev/characters/albedo')))
        .thenAnswer((_) async => http.Response(
            '{"name":"Albedo","vision":"Geo","weapon":"Sword","nation":"Mondstadt","description":"A genius known as the Kreideprinz, he is the Chief Alchemist and Captain of the Investigation Team of the Knights of Favonius."}',
            200));
    expect(await fetchCharacterInfo(client, 'albedo'), isA<CharacterInfo>());
  });

  test('throws an exception if the http call completes with an error', () {
    final client = MockClient();
// Use Mockito to return an unsuccessful response when it calls the
// provided http.Client.
    when(client.get(Uri.parse('https://api.genshin.dev/characters/albedo')))
        .thenAnswer((_) async => http.Response('Not Found', 404));
    expect(fetchCharacterInfo(client, 'albedo'), throwsException);
  });
}
