import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:votechain/data/models/candidate_model.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/db_helper.dart';
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
    await rootBundle.loadString('src/artifacts/Election.json');
    DbHelper.abi = jsonDecode(abiStringFile);
    logger.d('db helper abi true');
    DbHelper.contractAddress =
        EthereumAddress.fromHex(DbHelper.abi!['networks']['5777']['address']);
    logger.d('contract address ${DbHelper.contractAddress}');
  }

  Future<void> getDeployedContract() async {
    DbHelper.contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(DbHelper.abi), 'Election'),
        DbHelper.contractAddress!);
    logger.d('contract ${DbHelper.contract}');
  }

  @override
  Future<void> vote({
    required int candidateId,
    required int tpsId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> addCandidate(CandidateModel candidate) async {
    final privateKey = DbHelper.privateKey;
    final function = DbHelper.contract!.function('addCandidate');

    final transaction = Transaction.callContract(
        contract: DbHelper.contract!,
        function: function,
        parameters: [
          candidate.leadName,
          candidate.viceName,
          candidate.imageUrl,
          candidate.vision,
          candidate.mission,
        ]);
    logger.d('private key ${privateKey.toString()}');
    final res = await DbHelper.ethClient.sendTransaction(
      privateKey!,
      transaction,
      chainId: 1337,
    );
    logger.d('res $res');
  }

  @override
  Future<List<CandidateModel>> getCandidates() async {
    final list = <CandidateModel>[];
    final privateKey = DbHelper.privateKey;
    var address = privateKey!.address;
    logger.d('address $address, private key $privateKey');
    EtherAmount balance = await DbHelper.ethClient.getBalance(address);
    logger.d(balance.getValueInUnit(EtherUnit.ether));

    final function = DbHelper.contract!.function('getCandidates');
    logger
        .d('Test ${function.parameters} ${function.name} ${function.outputs}');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [],
    );
    for (final data in res[0]) {
      BigInt id = data[0];
      final candidate = CandidateModel(
          id: id.toInt(),
          leadName: data[1],
          viceName: data[2],
          imageUrl: data[3],
          vision: data[4],
          mission: data[5]);
      list.add(candidate);
    }
    logger.d('candidates $list');
    return list;
  }
}
