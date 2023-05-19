(async () => {

    console.log("Example to call contract functions through ABI interface");

    const abi_array = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_mystring",
				"type": "string"
			}
		],
		"name": "compareTwoStrings",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_myint",
				"type": "uint256"
			}
		],
		"name": "decrementMyInt",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_myint",
				"type": "uint256"
			}
		],
		"name": "incrementMyInt",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "myInt",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "mystring",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_newString",
				"type": "string"
			}
		],
		"name": "updateString",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    const contract_address = "0x83ea36A764F46963A2BB024C43889A82A926a041";

    // calling.

    let contractInstance = new web3.eth.Contract(abi_array, contract_address);
    console.log("Value read from the contact function mystring: " + await contractInstance.methods.mystring().call());

    let accounts = await web3.eth.getAccounts();
    await contractInstance.methods.updateString("Hello Girik!").send({from: accounts[0]});
    console.log("Updated value read from the contact function mystring: " + await contractInstance.methods.mystring().call());

})();