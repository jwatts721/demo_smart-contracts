import { ethers } from './node_modules/ethers/dist/ethers.esm.min.js'

const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
const contractABI = [
  // Add the ABI of your SimpleContract here
  'function getMessage() view returns (string)',
  'function updateMessage(string newMessage)',
];

window.addEventListener('load', async () => {
  // Connect to the provider
  if (window.ethereum) {
    await window.ethereum.request({ method: 'eth_requestAccounts' });
    window.provider = new ethers.providers.Web3Provider(window.ethereum);
  } else {
    alert('Please install MetaMask to use this application.');
    return;
  }

  // Get the signer and the contract instance
  window.signer = window.provider.getSigner();
  const simpleContract = new ethers.Contract(contractAddress, contractABI, window.signer);

  // Update the message when the button is clicked
  const updateButton = document.getElementById('updateButton');
  updateButton.addEventListener('click', async () => {
    const newMessage = 'New message from the web3 app';
    await simpleContract.updateMessage(newMessage);
    console.log('Message updated successfully');
  });
});
