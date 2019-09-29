pragma solidity ^0.4.11;
contract rayancoin_ico{
    
    uint public max_rayancoins = 1000000;
    uint public usd_to_rc= 1000;
    uint public total_rc_bought=0;
    mapping(address=>uint) equity_rc;
    mapping(address=>uint) equity_usd;
    modifier can_buy_rc(uint usd_invested){
        require(usd_invested*usd_to_rc+total_rc_bought<=max_rayancoins);
        _;
    }
    function equity_in_rc(address investor) external constant returns(uint){
        return equity_rc[investor];
    }
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    function buy_rc(address investor,uint usd_invested)external
    can_buy_rc(usd_invested){
        uint rc_bought = usd_invested*usd_to_rc;
        equity_rc[investor]+= rc_bought;
        equity_usd[investor]=equity_rc[investor]/usd_to_rc;
        total_rc_bought+=rc_bought;
    }
    function sell_rc(address investor,uint rc_to_sell)external{
        //uint usd_to_pay = rc_to_sell*usd_to_rc;
        equity_rc[investor]-= rc_to_sell;
        equity_usd[investor]=equity_rc[investor]/usd_to_rc;
        total_rc_bought-=rc_to_sell;
    }
}