import { ethers } from './node_modules/ethers/dist/ethers.esm.min.js'

const contractAddress = '0x09fBdC0616b34c79B95d0173f93c8747fA8d608c';
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
  const messageInput = document.getElementById('messageInput');
  const updateButton = document.getElementById('updateButton');
  updateButton.addEventListener('click', async () => {
    // Get the message from the input field
    const newMessage = messageInput.value;

    // Check if the message is empty
    if (newMessage === '') {
      alert('Please enter a message.');
      return;
    }

    await simpleContract.updateMessage(newMessage);
    console.log('Message updated successfully');
  });

  // Display the message
  const getButton = document.getElementById('getButton');
  getButton.addEventListener('click', async () => {
    const message = await simpleContract.getMessage();
    
    // Display the message
    const messageElement = document.getElementById('message');
    messageElement.innerHTML = message;
  });
});
