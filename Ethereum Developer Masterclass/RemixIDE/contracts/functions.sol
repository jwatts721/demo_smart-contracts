// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract FunctionBasics {
    int public value1 = 10;
    int public value2 = 20;
    int public sum;
    string public name;

    string[] public students = ["John", "Jack"];

    mapping(string => bool) public map;

    // Enums
    //enum Cities { NewYork, LosAngeles, WashingtonDC }

    struct Student {
        string name;
        bool attendance;
        int rollNo;
        int marks;
    }

    Student public student1;
    Student public student2;

    function multiply(int _val1, int _val2) public {
        sum = _val1 * _val2;
    }

    function setSum() public {
        sum = value1 + value2;
    }

    function getSum() view public returns (int) {
        return sum;
    }

    function getValues() view public returns (int, int) {
        return (value1, value2);
    }

    function getNamedValues() view public returns (int balance, int marks) {
        return (value1, value2);
    }

    function update() public returns (int updatedValue) {
        value2 = value2 * 2;
        return value2;
    }

    function getDefaults() pure public returns (int, bool) {
        return (35, true);
    }

    function setName(string memory _name) public {
        name = _name;
    }

    function getName() public view returns (string memory studentName) {
        return name;
    }

    function setVariables() public {
        students.push("Alice"); // Adds value to the end of the array
        students[0] = "Jane"; // Changes the first value of the array 

        map["Base"] = true;
        map["Top"] = false;

        student1.name = "Bob williams";
        student1.rollNo = 15;
        student1.attendance = true;
        student1.marks = 89;

        Student memory tempStudent = Student({ // No gas fee paid on this varialbe
            name: "Jimmy Beans",
            attendance: true,
            rollNo: 99,
            marks: 95
        });
        student1 = tempStudent;

        tempStudent = Student("Jane Washinton", true, 94, 97);
        student2 = tempStudent;
    }
}