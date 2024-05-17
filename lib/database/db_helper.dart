import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class DbHelper {
  static const rpcUrl = 'http://10.252.130.154:7545';
  static const wsUrl = 'ws://10.252.130.154:7545';

  static EthPrivateKey? privateKey;
  static DeployedContract? contract;
  static Credentials? userCredential;
  static Map<String, dynamic>? abi;
  static EthereumAddress? contractAddress;
  static final httpClient = Client();
  static final ethClient = Web3Client(rpcUrl, httpClient);
}