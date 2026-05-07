import 'dart:io';
import 'package:cli/cli.dart' as cli;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
    return;
  }

  if (arguments.first == "version") {
    print("Dartpedia CLI version $version");
    return;
  }

  if (arguments.first == "search") {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
    return;
  }

  printUsage();
}

void printUsage() {
    print(
        "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
    );
}

void searchWikipedia(List<String>? arguments) {
    final String articleTitle;

    if (arguments == null || arguments.isEmpty) {
        print("Please provide an article title.");
        articleTitle = stdin.readLineSync() ?? '';
    } else {
        articleTitle = arguments.join(' ');
    }

    print("Current  article title: $articleTitle");
}
