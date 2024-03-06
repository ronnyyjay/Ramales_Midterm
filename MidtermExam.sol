  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.0;

  contract GradeContract {

  address public owner;
  string public studentName;
  uint256 public prelimGrade;
  uint256 public midtermGrade;
  uint256 public finalGrade;
  enum GradeStatus { Pass, Fail }
  GradeStatus public overallGradeStatus;

  modifier onlyOwner() {
  require(msg.sender == owner, "Only the owner can call this function");
  _;
  }

  modifier validGrade(uint256 grade) {
  require(grade >= 0 && grade <= 100, "Invalid grade");
  _;
  }

  event GradeComputed(string studentName, uint256 overallGrade, GradeStatus status);

  constructor() {
  owner = msg.sender;
  }

  function setName(string memory _studentName) public onlyOwner {
  studentName = _studentName;
  }

  function setPrelimGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  prelimGrade = _grade;
  }

  function setMidtermGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  midtermGrade = _grade;
  }

  function setFinalGrade(uint256 _grade) public onlyOwner validGrade(_grade) {
  finalGrade = _grade;
  }

  function calcTotalGrades() public onlyOwner {
  uint256 total = (prelimGrade + midtermGrade + finalGrade) / 3;
  if (total >= 60) {
  overallGradeStatus = GradeStatus.Pass;
  } 
  else {
  overallGradeStatus = GradeStatus.Fail;
  }
  emit GradeComputed(studentName, total, overallGradeStatus);
  }
}
