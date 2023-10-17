const { ethers } = require('hardhat');

async function main() {
  const NFTCollection = await ethers.getContractFactory('NFTCollection');
  const nftCollection = await NFTCollection.deploy('NFTCollection', 'NFTC', 'https://api.example.com/metadata/');
  await nftCollection.deployed();

  // Mint an NFT
  const [owner, recipient] = await ethers.getSigners();
  await nftCollection.connect(owner).mint(owner.address);

  // Get the tokenId of the minted NFT
  const tokenId = await nftCollection.tokenOfOwnerByIndex(owner.address, 0);

  // Replace the NFT ownership
  await nftCollection.connect(owner).replaceNFT(owner.address, tokenId, recipient.address);

  console.log('NFT replaced successfully!');
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
