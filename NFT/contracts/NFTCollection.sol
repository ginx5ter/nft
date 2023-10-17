// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTCollection is ERC721Enumerable {
    string private baseURI;
    uint256 private nextTokenId;

    constructor(string memory _name, string memory _symbol, string memory _baseURI_) ERC721(_name, _symbol) {
        baseURI = _baseURI_;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory newBaseURI) external {
        baseURI = newBaseURI;
    }

    function _mintNFT(address to) internal {
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(to, tokenId);
    }

    function mint(address to) external {
        require(totalSupply() < 1000, "Max supply reached");
        _mintNFT(to);
    }

    function replaceNFT(address owner, uint256 tokenId, address recipient) external {
        require(_isApprovedOrOwner(owner, tokenId), "Not approved to transfer");
        _transfer(owner, recipient, tokenId);
    }

    function _isApprovedOrOwner(address owner, uint256 tokenId) internal view returns (bool) {
        return (owner == ownerOf(tokenId) || getApproved(tokenId) == owner || isApprovedForAll(owner, owner));
    }
}
