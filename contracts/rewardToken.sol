pragma solidity 0.5.7;

import "./external/openzeppelin-solidity/token/ERC20/ERC20.sol";
import "./external/openzeppelin-solidity/math/SafeMath.sol";

contract RewardToken is ERC20 {
    using SafeMath for uint256;

    string public name = "RTOKEN";
    string public symbol = "RT";
    uint8 public decimals = 18;
    address public operator;

    modifier onlyOperator() {
        require(msg.sender == operator, "Not operator");
        _;
    }

    /**
     * @dev Initialize PLOT token
     * @param _initialSupply Initial token supply
     * @param _initialTokenHolder Initial token holder address
     */
    constructor(uint256 _initialSupply, address _initialTokenHolder) public {
        _mint(_initialTokenHolder, _initialSupply);
        operator = _initialTokenHolder;
    }

    /**
     * @dev change operator address
     * @param _newOperator address of new operator
     */
    function changeOperator(address _newOperator)
        public
        onlyOperator
        returns (bool)
    {
        require(_newOperator != address(0), "New operator cannot be 0 address");
        operator = _newOperator;
        return true;
    }

    /**
     * @dev burns an amount of the tokens of the message sender
     * account.
     * @param amount The amount that will be burnt.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Burns a specific amount of tokens from the target address and decrements allowance
     * @param from address The address which you want to send tokens from
     * @param value uint256 The amount of token to be burned
     */
    function burnFrom(address from, uint256 value) public {
        _burnFrom(from, value);
    }

    /**
     * @dev function that mints an amount of the token and assigns it to
     * an account.
     * @param account The account that will receive the created tokens.
     * @param amount The amount that will be created.
     */
    function mint(address account, uint256 amount)
        public
        onlyOperator
        returns (bool)
    {
        
        _mint(account, amount);
        return true;
    }

    /**
     * @dev Transfer token for a specified address
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint256 the amount of tokens to be transferred
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        _transferFrom(from, to, value);
        return true;
    }
}
