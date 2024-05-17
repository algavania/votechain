import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:votechain/database/db_helper.dart';
import 'package:votechain/features/contract/data/repository/contact_repository.dart';
import 'package:votechain/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class ContractRepositoryImpl extends ContractRepository {
  @override
  Future<void> initializeContract() async {
    await getAbi();
    logger.d('abi ${DbHelper.abi}');
    DbHelper.contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(DbHelper.abi!['abi']), 'Election'),
        DbHelper.contractAddress!);
    logger.d('contract ${DbHelper.contract}');
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/artifacts/Election.json");
    DbHelper.abi = jsonDecode(abiStringFile);
    logger.d('db helper abi true');
    DbHelper.contractAddress =
        EthereumAddress.fromHex(DbHelper.abi!["networks"]["5777"]["address"]);
    logger.d('contract address ${DbHelper.contractAddress}');
  }

  Future<void> getDeployedContract() async {
    DbHelper.contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(DbHelper.abi), 'Election'),
        DbHelper.contractAddress!);
    logger.d('contract ${DbHelper.contract}');
  }

  @override
  Future<void> vote(
      {required int candidateId,
      required int provinsiId,
      required int kotaId,
      required int kecamatanId,
      required int kelurahanId}) {
    // TODO: implement vote
    throw UnimplementedError();
  }

  @override
  Future<void> addCandidate() async {
    final function = DbHelper.contract!.function('addCandidate');

    final transaction = Transaction.callContract(
        contract: DbHelper.contract!,
        function: function,
        parameters: [
          'John Doe',
          'Jane Doe',
          'Lorem',
          'Ipsum',
        ]);
    final privateKey = EthPrivateKey.fromHex(
        '0x7f1f792d7323f7c538483d5249fe7dac5251439dca028386affa243eec556882');
    final res = await DbHelper.ethClient.sendTransaction(
        privateKey, transaction,
        chainId: 1337, fetchChainIdFromNetworkId: false);
    logger.d('res $res');
  }

  @override
  Future<void> getCandidates() async {
    final privateKey = EthPrivateKey.fromHex(
        '0x7f1f792d7323f7c538483d5249fe7dac5251439dca028386affa243eec556882');
    var address = privateKey.address;
    EtherAmount balance = await DbHelper.ethClient.getBalance(address);
    logger.d(balance.getValueInUnit(EtherUnit.ether));

    final function = DbHelper.contract!.function('getTesting');
    logger
        .d('Test ${function.parameters} ${function.name} ${function.outputs}');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [],
    );
    logger.d('res $res');
  }
}
