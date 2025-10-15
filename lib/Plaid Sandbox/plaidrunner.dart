// so i think 3ish functions in here. One to create public token and subsequently access token
// one to read apikeys.json to retrieve data from there
// one to use transactionssync.dart

// 4 import things here
// has_more tells us if we need to update DBs
// next curser points us at our latest transaction so we only pull new ones
// Accounts gives us all of our account data for an account
// added gives us transactions

// for the sake of testing we will start slow
// when the user pushes a button on the dev page we will pull clint id and secret from page and save it
// then we will make our first two api calls, createItem and accessToken