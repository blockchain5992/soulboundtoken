// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulBoundToken is ERC721, ERC721URIStorage, Ownable {
    uint256 private _count;

    constructor() ERC721("SoulBoundToken", "SBT") {}

    function safeMint(address to, string memory uri) external onlyOwner {
        uint256 tokenId = _count;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _count++;
    }

    function bulkMint(
        address[] calldata to,
        string[] calldata uris
    ) external onlyOwner {
        require(to.length == uris.length, "length are not equal");
        uint256 index = _count;
        for (uint256 i; i < to.length; i++) {
            uint256 tokenId = index;
            _safeMint(to[i], tokenId);
            _setTokenURI(tokenId, uris[i]);
            index++;
        }
        _count += index;
    }

    // The following functions are overrides required by Solidity.

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal virtual override {
        require(from == address(0), "SBT: token transfer is BLOCKED");
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}
