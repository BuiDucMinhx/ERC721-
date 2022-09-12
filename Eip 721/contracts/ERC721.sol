//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;
// event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
// event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
// event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
// function balanceOf(address _owner) external view returns (uint256);
// function ownerOf(uint256 _tokenId) external view returns (address);
// function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
// function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
// function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
// function approve(address _approved, uint256 _tokenId) external payable;
// function setApprovalForAll(address _operator, bool _approved) external;
// function getApproved(uint256 _tokenId) external view returns (address);
// function isApprovedForAll(address _owner, address _operator) external view returns (bool);


contract ERC721{
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovals;

    // Trả về số lượng NFT của người dùng
    function balanceOf(address owner) external view returns (uint256){
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    // Trả về người sở hữu của 1 NFT truyền vào
    function ownerOf(uint256 tokenId) public view returns (address){
        address owner = _owners[tokenId];
        require(owner != address(0), "Token Id does not exist");
        return owner;
    }

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // Enable or Disable an operator
    function setApprovalForAll(address operator, bool approved) external{
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }    

    // Check: address is "operator for another address"
    function isApprovedForAll(address owner, address operator) public view returns (bool){
        return _operatorApprovals[owner][operator];
    }

    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    // Cập nhật địa chỉ đã approve cho NFT
    function approve(address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "msg.sender is not the owner of the approved operator");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // Get địa chỉ đã approve cho NFT
    function getApproved(uint256 tokenId) public view returns (address){
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenApprovals[tokenId];
    }

    // Chuyển nhượng quyền sở hữu của 1 NFT 
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    // Chuyển NFT từ from sang to bằng transferFrom function
    function transferFrom(address from, address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner ||
            getApproved(tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or approved for transfer"
        );
        require(owner == from, "from address is not the owner");
        require(to != address(0), "Address is the zero address");
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }

    // Safe transferfrom || Standard transferfrom
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public payable{
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implememented");

    }

    // Kiểm tra NFT Reveiver 
    function _checkOnERC721Received() private pure returns(bool){
        return true;
    }

    //  Standard transferFrom
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable{
        safeTransferFrom(from, to, tokenId, "");
    }

    // Điều kiện cần khi 1 contract implement a interface
    function supportInterface(bytes4 interfaceID) public pure virtual returns(bool){
        return interfaceID == 0x80ac58cd;

    }

}