var reservation_contract_ABI = [
	{
		"constant": false,
		"inputs": [],
		"name": "cancelReservation",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "myPayment",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "myTotalPrice",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "guest",
				"type": "address"
			}
		],
		"name": "inevitableCancel",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "deleteCheckIn_roomPrice",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "hotelAccount",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getCheckIn_roomPrice_myPayment",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "date",
				"type": "uint256"
			},
			{
				"name": "totalPrice",
				"type": "uint256"
			}
		],
		"name": "setCheckIn_roomPrice",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "myCheckInDate",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getStateValue",
		"outputs": [
			{
				"name": "",
				"type": "address"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "hotel",
				"type": "address"
			},
			{
				"name": "cancelPercentTheday",
				"type": "uint256"
			},
			{
				"name": "cancelPercent1day",
				"type": "uint256"
			},
			{
				"name": "setCancelPercent1",
				"type": "uint256"
			},
			{
				"name": "setCancelPercent2",
				"type": "uint256"
			},
			{
				"name": "setCancelPeriod1",
				"type": "uint256"
			},
			{
				"name": "setCancelPeriod2",
				"type": "uint256"
			}
		],
		"name": "updateStateValue",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "guest",
				"type": "address"
			}
		],
		"name": "withDrawal",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"name": "hotel",
				"type": "address"
			},
			{
				"name": "cancelPercentTheday",
				"type": "uint256"
			},
			{
				"name": "cancelPercent1day",
				"type": "uint256"
			},
			{
				"name": "setCancelPercent1",
				"type": "uint256"
			},
			{
				"name": "setCancelPercent2",
				"type": "uint256"
			},
			{
				"name": "setCancelPeriod1",
				"type": "uint256"
			},
			{
				"name": "setCancelPeriod2",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"payable": true,
		"stateMutability": "payable",
		"type": "fallback"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "account",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "amount",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "isContractHasEther",
				"type": "bool"
			}
		],
		"name": "PaymentCompleteEvent",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "guest",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "cancelFee",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "inevitable",
				"type": "bool"
			}
		],
		"name": "CancelEvent",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "errMsg",
				"type": "string"
			}
		],
		"name": "MinusErrorEvent",
		"type": "event"
	}
]