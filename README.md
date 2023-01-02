# Solidity-Crowdfunding
### A small testing project to get started with solidity
<br>

This smart contract implements a crowdfunding platform that allows multiple backers to contribute funds to a project. The contract includes a struct to store information about each backer and a struct to store information about each project. It also includes a mapping to store all of the projects in the contract, and a variable to keep track of the number of projects in the contract.

The contract has two functions: createProject, which allows a user to create a new project, and contribute, which allows a user to contribute to an existing project. If the contribution brings the total contribution for a project to its fundraising goal, the contract will emit the FundingGoalReached event and automatically distribute the funds to the project creator.