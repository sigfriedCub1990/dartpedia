// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class CommandRunner {
  Future<void> run(List<String> arguments) async {
    print("Command runner received $arguments");
  }
}
