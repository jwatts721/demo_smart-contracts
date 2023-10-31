// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract EventsExample {
    // Structs
    struct Student {
        string name;
        bool attendance;
        int rollNo;
        int marks;
    }

    Student public newStudent;

    // Events
    // -- notice that string does not contain the "memory" keyword. This is because 
    // -- the value is not being dynamically allocated here
    event studentRegistered (string name, bool attendance, int rollNo, int marks);

    function payToContract() public payable {
    }

    function registerStudent(
        string memory _name, 
        bool _attendance, 
        int _rollNo,
        int _marks
    ) public {
        newStudent.name = _name;
        newStudent.attendance = _attendance;
        newStudent.rollNo = _rollNo;
        newStudent.marks = _marks;
        // Triggers the event to send back data to the user
        emit studentRegistered(_name, _attendance, _rollNo, _marks);
    }

    receive () external payable {}
    fallback () external payable {
        msg.sender.transfer(msg.value); // Optional
    }
}