pragma solidity ^0.5.1;

contract Reservation {
    address payable public hotelAccount; //수익자 
    mapping(address => uint) public myTotalPrice; // 해당 계좌가 지불할 총 금액을 담아두는 곳. // 여러 계좌가 이걸 이용해서..
    mapping(address => uint) public myCheckInDate; // 해당 계좌의 체크인 날짜를 담아두는 곳
    mapping(address => uint) public myPayment; // 해당 계좌가 보낸 금액 숫자를 담아두는 곳
	mapping(uint => uint) cancelPercent; // 남은 날을 넣으면 => 해당 날전 취소에 적용되는 % 반환
    uint[] setCancelPeriod;

    event PaymentCompleteEvent(address account, uint amount, bool isContractHasEther); // 이더 전송이 잘 됐을 경우 이벤트(수령 계좌, 이더량, 이더 전송이 예약금 인출목적인지)
    event CancelEvent(address guest, uint cancelFee, bool inevitable);
    event MinusErrorEvent(string errMsg);

    constructor( 
            address payable hotel, 
            uint cancelPercentTheday, uint cancelPercent1day, 
            uint setCancelPercent1, uint setCancelPercent2,
            uint setCancelPeriod1, uint setCancelPeriod2
        ) public {
        hotelAccount = hotel; // 호텔 계좌 올려놓기
        cancelPercent[0] = cancelPercentTheday;
        cancelPercent[1] = cancelPercent1day;
        setCancelPeriod.push(setCancelPeriod1);  // ~일전 취소인지 대해 호텔이 설정
        setCancelPeriod.push(setCancelPeriod2);
        cancelPercent[setCancelPeriod1] = setCancelPercent1; // ~일전 취소에는 몇 %의 수수료를 내야하는지 호텔이 설정
        cancelPercent[setCancelPeriod2] = setCancelPercent2;
    }

    function () payable external {
		if(msg.value >= 0 && (msg.value > myTotalPrice[msg.sender] || msg.value < myTotalPrice[msg.sender])){ //스마트컨트랙트로 직접 돈을 보낼 경우
			msg.sender.transfer(msg.value);
		}
		else if(msg.value == myTotalPrice[msg.sender]){ // 예약자에게 책정된 금액과 받은 돈이 일치할 경우
			myPayment[msg.sender] = msg.value;
			emit PaymentCompleteEvent(msg.sender, msg.value, true);
		}
    }
    
    function updateStateValue( 
            address payable hotel, 
            uint cancelPercentTheday, uint cancelPercent1day, 
            uint setCancelPercent1, uint setCancelPercent2,
            uint setCancelPeriod1, uint setCancelPeriod2
        ) public {
        hotelAccount = hotel;
        delete cancelPercent[0];
        delete cancelPercent[1];
        delete cancelPercent[setCancelPeriod[0]];
        delete cancelPercent[setCancelPeriod[1]];
        
        cancelPercent[0] = cancelPercentTheday;
        cancelPercent[1] = cancelPercent1day;
        cancelPercent[setCancelPeriod[0]] = setCancelPercent1; // ~일전 취소에는 몇 %의 수수료를 내야하는지 호텔이 설정
        cancelPercent[setCancelPeriod[1]] = setCancelPercent2;
        setCancelPeriod[0] = setCancelPeriod1;
        setCancelPeriod[1] = setCancelPeriod2;
    }
    
    function getStateValue() public view returns (address, uint, uint, uint, uint, uint, uint){
        return (hotelAccount, cancelPercent[0], cancelPercent[1], cancelPercent[setCancelPeriod[0]],
               cancelPercent[setCancelPeriod[1]], setCancelPeriod[0], setCancelPeriod[1]);
    }
    
    function setCheckIn_roomPrice(uint date, uint totalPrice) public{
        myCheckInDate[msg.sender] = date; // 체크인 날짜는 해당 날 0시 0분 0초의 unixtime을 넣음
        myTotalPrice[msg.sender] = totalPrice; // 서버에서 정산한 총 금액을 넣음
    }
    
    function getCheckIn_roomPrice_myPayment() public view returns (uint, uint, uint, uint){
        return (myCheckInDate[msg.sender], now, myTotalPrice[msg.sender], myPayment[msg.sender]);
    }
    
    function cancelReservation() public{
        uint cancelFee = calculateCancelFee();
        emit CancelEvent(msg.sender, cancelFee, false);
        delete myCheckInDate[msg.sender];
        delete myTotalPrice[msg.sender];
        delete myPayment[msg.sender];
    }
    
    // 호텔만 접근할 수 있게
    modifier onlyHotel() { require(msg.sender == hotelAccount); _;}
    
    function inevitableCancel(address payable guest) public onlyHotel {
        guest.transfer(myPayment[guest]);
        emit CancelEvent(guest, 0, true);
        delete myPayment[guest];
        delete myCheckInDate[guest];
        delete myTotalPrice[guest];
    }
    
	// 체크인 다음날 0시 0분 0초 이후로 징수가능하게 설정.
    modifier reachWithdrawDate(address guest) { if(now >= myCheckInDate[guest]) _; }
    
    function withDrawal(address guest) public onlyHotel reachWithdrawDate(guest){
        hotelAccount.transfer(myPayment[guest]);
        emit PaymentCompleteEvent(msg.sender, myPayment[guest], false);
        delete myPayment[guest];
        delete myCheckInDate[guest];
        delete myTotalPrice[guest];
    }
    
    function calculateCancelFee() private returns (uint){
        int remainingPeriod = int(myCheckInDate[msg.sender]) - int(now);
        if(remainingPeriod <= 0){ // 당일날 취소할 경우
            return cancelTransfer(0);
        }
        else if(remainingPeriod <= 1 days){ // 1일 전날 취소할 경우
            return cancelTransfer(1);
        }
        else if(setCancelPeriod[0] == 0){ // 2일 이상의 취소기간 설정이 없는 경우
            msg.sender.transfer(myPayment[msg.sender]);
            return 0;
        }
        else if(remainingPeriod <= int(setCancelPeriod[0]) * 1 days) { // (취소기간 설정1)일 전날 안에 취소할 경우
            return cancelTransfer(setCancelPeriod[0]);
        }
        else if(setCancelPeriod[1] == 0){ // 취소기간 설정2가 없는 경우
            msg.sender.transfer(myPayment[msg.sender]);
            return 0;
        }
        else if(remainingPeriod <= int(setCancelPeriod[1]) * 1 days){ // (취소기간 설정2)일 전날 안에 취소할 경우
            return cancelTransfer(setCancelPeriod[1]);
        }
        else{
            msg.sender.transfer(myPayment[msg.sender]);
            return 0;
        }
    }
    
    function cancelTransfer(uint cP) private returns (uint){ // cP is cancelPeriod
        if(cancelPercent[cP] == 100) { 
            hotelAccount.transfer(myPayment[msg.sender]); 
            return myPayment[msg.sender];
        }
        else if((100-cancelPercent[cP]) >= 0) {
                    msg.sender.transfer( (myPayment[msg.sender] * (100-cancelPercent[cP]))/100); // 설정의 %만큼 호텔에서 가져감.
                    hotelAccount.transfer((myPayment[msg.sender] * cancelPercent[cP])/100);
                    return (myPayment[msg.sender] * cancelPercent[cP])/100;
        } else { emit MinusErrorEvent("minus error"); return 0; }
    }

}
