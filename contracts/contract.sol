pragma solidity ^0.8.17;

contract Crowdfunding {

  // Define the struct "Backer" to store information about each backer
  struct Backer {
    // The backer's address
    address addr;
    // The amount of ether the backer has contributed
    uint contribution;
  }

  // Define the struct "Project" to store information about each project
  struct Project {
    // The project creator's address
    address creator;
    // The project's fundraising goal
    uint goal;
    // The total amount of ether that has been contributed to the project
    uint totalContribution;
    // The array of backers for this project
    Backer[] backers;
  }

  // Define the mapping "projects" to store all of the projects in the contract
  mapping(uint => Project) public projects;

  // Define the variable "projectCount" to keep track of the number of projects in the contract
  uint public projectCount;

  // Define the event "FundingGoalReached" to be emitted when a project's funding goal is reached
  event FundingGoalReached(uint projectId);

  // Define the function "createProject" to allow a user to create a new project
  function createProject(uint _goal) public {
    // Increment the project count
    projectCount++;
    // Create a new project and store it in the mapping
    projects[projectCount] = Project(msg.sender, _goal, 0, new Backer[](0));
  }

  // Define the function "contribute" to allow a user to contribute to a project
  function contribute(uint _projectId, uint _contribution) public payable {
    // Get the project from the mapping
    Project storage project = projects[_projectId];
    // Check that the contribution is greater than 0
    require(_contribution > 0);
    // Check that the project exists
    require(_projectId <= projectCount);
    // Check that the project has not already reached its goal
    require(project.totalContribution + _contribution <= project.goal);
    // Increment the total contribution for the project
    project.totalContribution += _contribution;
    // Add the backer to the project's array of backers
    project.backers.push(Backer(msg.sender, _contribution));
    // If the project has reached its goal, distribute the funds to the project creator
    if (project.totalContribution == project.goal) {
      emit FundingGoalReached(_projectId);
      address payable creator = payable(project.creator);
      creator.transfer(project.totalContribution);
    }
  }
}
