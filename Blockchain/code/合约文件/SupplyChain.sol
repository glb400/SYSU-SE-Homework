pragma solidity ^0.4.21;

contract SupplyChain {
	// const information
	// creditLevel table
	uint[] public creditTable = [1, 50000, 500000, 2000000, 10000000, 50000000, 200000000];

	// structure part
	// Organization includes Company & Bank
	struct Organization {
		// record variable
		bool isValid;
		// address is specific variable in solidity
		address addr;
		// credit level
		uint creditLevel;
		// money amount
		uint amount;
		// shows Receipts belongs to the Company
		// uint represent debtor to this organization
		mapping (address => Receipt) receipts;
		// store whether have this repre
	}

	// Receipt includes between-Company receipt & Bank-Company receipt
	struct Receipt {
		// record variable
		bool isValid;
		// the one in debt
		address debtee;
		// uint debtee;
		// the one owns debt
		address debtor;
		// uint debtor;
		// money
		uint amount;
    	// credit level for debtor Which makes credit circulate in chain
    	uint creditLevel;
	}

	// variables
	uint public numOfOrganizations;
	mapping (address => Organization) public organizations;
	// special organization - bank
	Organization bank;

	// interface between user and application 
	function setCreditLevel(uint creditLevel) public {
        organizations[msg.sender].creditLevel = creditLevel;
    }
    
    // To add money to one specific account aiming to run test
	function addAmount(uint amount) public {
		organizations[msg.sender].amount += amount;
	}

	// check amount in account
	function getAmount() public returns(uint) {
		return organizations[msg.sender].amount;
	}

	// relate structure Organization with real user 
	// add user(in code we say Organization)
	function addOrganization(uint creditLevel) public {
		Organization memory org = Organization(true, msg.sender, creditLevel, 0);
		organizations[msg.sender] = org;
		numOfOrganizations += 1;
	}

	// function part
	constructor (address bankAddr) {
		// init bank
		// In suppose that money of Bank can be huge quantity and no real User can represent bank
		bank.isValid = true;
		bank.amount = 100000000000000;
		// give bank highest credit ranking
		bank.creditLevel = 10000;
		bank.addr = bankAddr;
		// insert bank into mapping Organizations as normal
		// so when handling with it we can use functions normally
		organizations[bankAddr] = bank;
		numOfOrganizations = 1;
	}

	// produce receipt

	// the 4 functions
	function signature(address debtor, uint amount) public {
		// who need to signature is the one launch signature
		address debtee = msg.sender;
		// make new receipts for debtor
		if (organizations[debtor].receipts[debtee].isValid == false) {
			organizations[debtor].receipts[debtee] = Receipt(true, debtee, debtor, amount, organizations[debtee].creditLevel);
		} else {
			organizations[debtor].receipts[debtee].amount += amount;
		}
	}

	function transfer(address debtorA, address debtorB) public returns(bool) {
		address debtee = msg.sender;
		// find receipt which debtee owe debtorA and debtorA owe debtorB
		// judge : if there's no receipt on each side then there's no need to transfer
		if (organizations[debtorA].receipts[debtee].isValid == false || organizations[debtorB].receipts[debtorA].isValid == false) {
			return false;
		}

		// compare their amount to carry out different operations
		// make new receipts for debtorA and debtorB from debtee from debtor
		// delete origin receipts from debtee to debtorA first
		uint aOWEb = organizations[debtorA].receipts[debtee].amount;
		uint bOWEc = organizations[debtorB].receipts[debtorA].amount;
		if (aOWEb > bOWEc) {
			// receiptA devide into 2 new receipt
			Receipt memory newReceiptToDebtorB = Receipt(true, debtee, debtorB, bOWEc, organizations[debtee].creditLevel);
			if (organizations[debtorB].receipts[debtee].isValid == false) {
				organizations[debtorB].receipts[debtee] = newReceiptToDebtorB;
			} else {
				organizations[debtorB].receipts[debtee].amount += newReceiptToDebtorB.amount;
			}
			// obviously there must be receipt from A to B
			organizations[debtorA].receipts[debtee].amount -= newReceiptToDebtorB.amount;
		} else {
			// make receiptAtoC
			Receipt memory newReceiptAtoC = Receipt(true, debtee, debtorB, aOWEb, organizations[debtee].creditLevel);
			if (organizations[debtorB].receipts[debtee].isValid == false) {
				organizations[debtorB].receipts[debtee] = newReceiptAtoC;
			} else {
				organizations[debtorB].receipts[debtee].amount += newReceiptAtoC.amount;
			}
			// thus make receiptBtoC minus amount of receiptAtoC
			organizations[debtorB].receipts[debtorA].amount -= newReceiptAtoC.amount;
			// obviously there must be receipt from A to B and delete it
			organizations[debtorA].receipts[debtee].isValid = false;
		}
		return true;
	}

	function finance(uint amount) public returns(bool) {
		address debtee = msg.sender;
		// find receipt need to show to bank
		uint credit = organizations[debtee].creditLevel;
		if (amount < creditTable[credit]) {
			// bank gives authority to finance
			Receipt memory receipt = Receipt(true, debtee, bank.addr, amount, credit + 1);
			if (bank.receipts[debtee].isValid == false) {
				bank.receipts[debtee] = receipt;
				return true;
			} else {
				// check accumulated credit amount whether larger than credit limit
				if ((bank.receipts[debtee].amount + amount) < creditTable[credit]) {
					bank.receipts[debtee].amount += amount;
					return true;
				}
				else {
					return false;
				} 

			}
		}
		// bank refuses to finance
		return false;
	}

	function payback(address debtor) public returns(bool){
		address debtee = msg.sender;
		Organization storage from = organizations[debtor];
		Organization storage to = organizations[debtee];
		// find receipt need to be paid
		if (from.receipts[debtee].isValid != false) {
			if (to.amount < from.receipts[debtee].amount) {
				// cannot afford to payback
				return false;
			} else {
				// payback
				to.amount -= from.receipts[debtee].amount;
				from.amount += from.receipts[debtee].amount;
				// delete this receipt
				from.receipts[debtee].isValid = false;
				return true;
			}
		}
		return false;
	}
}