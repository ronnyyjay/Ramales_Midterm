  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.0;

  contract GradeContract {
  // State variables
  address public owner;
  string public studentName;
  uint256 public prelimGrade;
  uint256 public midtermGrade;
  uint256 public finalGrade;
  enum GradeStatus { Pass, Fail }
  GradeStatus public overallGradeStatus;

  // Modifier to restrict access to the owner
  modifier onlyOwner() {
  require(msg.sender == owner, "Only the owner can call this function");
  _;
  }

  // Modifier to validate grade range (0 to 100)
  modifier validGrade(uint256 grade) {
  require(grade >= 0 && grade <= 100, "Invalid grade");
  _;
  }

  // Event emitted upon grade calculation
  event GradeComputed(string studentName, uint256 overallGrade, GradeStatus status);

  // Constructor: Set the owner
  constructor() {
  owner = msg.sender;
  }

  // Set student's name
  function setName(string memory _studentName) public onlyOwner {
  studentName = _studentName;
  }

  // Set preliminary grade
  function setPrelimGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  prelimGrade = _grade;
  }

  // Set midterm grade
  function setMidtermGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  midtermGrade = _grade;
  }

  // Set final grade
  function setFinalGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  finalGrade = _grade;
  }

  // Calculate overall grade
  function calcTotalGrades() public onlyOwner {
  uint256 total = (prelimGrade + midtermGrade + finalGrade) / 3;
  if (total >= 60) {
  overallGradeStatus = GradeStatus.Pass;
  } else {
  overallGradeStatus = GradeStatus.Fail;
  }
  emit GradeComputed(studentName, total, overallGradeStatus);
  }
  }
