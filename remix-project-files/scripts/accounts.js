(async () => {

    console.log("hello js");
    let accounts = await web3.eth.getAccounts(); //fetch accounts present in web3 provider
    
    console.log("Accounts present in web3 provider: " + accounts.length);
    console.log(accounts);

    let balance = await web3.eth.getBalance(accounts[0]);
    console.log("Balance(wei) in account 1: " + balance);

    let balanceInEth = await web3.utils.fromWei(balance.toString(), "ether");
    console.log("Balance(ether) in account 1: " + balanceInEth);

    console.log(web3.utils.unitMap);

}) ();
