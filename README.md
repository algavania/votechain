# votechain

Blockchain-based vote application.

## How to run the project
- Clone the project.
- Run `flutter pub get`.
- Run `dart run build_runner build`.
- Run a workspace in Ganache.
- Change the IP in `db_helper.dart` and `truffle-config.js` to your configuration based on Ganache.
- Run `truffle compile` and `truffle migrate`
- Then run the project :)