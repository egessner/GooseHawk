class SampleAccountData{
  final String account;
  final String accountType;
  final String accountSource;
  final double amount;

  const SampleAccountData({
    required this.account,
    required this.accountType,
    required this.accountSource,
    required this.amount
  });
}

List<SampleAccountData> sampleAccountData = [
  SampleAccountData(
    account: 'Checking',
    accountType: 'Bank',
    accountSource: 'US Bank',
    amount: 1124.36
  ),
  SampleAccountData(
    account: 'Savings',
    accountType: 'Bank',
    accountSource: 'US Bank',
    amount: 8213.45
  ),
  SampleAccountData(
    account: 'Platinum Card',
    accountType: 'Credit',
    accountSource: 'American Express',
    amount: -2037.43
  ),
  SampleAccountData(
    account: 'Platinum Card',
    accountType: 'Credit',
    accountSource: 'American Express',
    amount: -2037.43
  ),
];