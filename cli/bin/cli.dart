import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;
import "package:command_runner/command_runner.dart";

const version = '0.0.1';
const wikipediaDomain = "en.wikipedia.org";

void main(List<String> arguments) async {
  var runner = CommandRunner();
  await runner.run(arguments);
}

void printUsage() {
    print(
        "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
    );
}

void searchWikipedia(List<String>? arguments) async {
    final String articleTitle;

    if (arguments == null || arguments.isEmpty) {
        print("Please provide an article title.");
        final inputFromStdin = stdin.readLineSync();
        if (inputFromStdin == null || inputFromStdin.isEmpty) {
            print('No article title provided. Exiting.');
            return;
        }
        articleTitle = inputFromStdin;
    } else {
        articleTitle = arguments.join(' ');
    }

    print("Looking up articles about '$articleTitle'. Please wait.");

    var articleContent = await getWikipediaArticle(articleTitle);
    print(
        JsonDecoder().convert(articleContent)['extract']
    );
}

Future<String> getWikipediaArticle(String articleTitle) async {
    final url = Uri.https(
        wikipediaDomain,
        "/api/rest_v1/page/summary/$articleTitle",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
        return response.body;
    }

    return "Error: Failed to fetch '$articleTitle'. Status code: ${response.statusCode}";
}
