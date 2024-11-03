// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract VariableBasics {
    int public a  = 5;
    int8 public b = 127;
    int16 public c = 2689;

    uint public d = 14;

    string public name = "John";

    bool public transactionComplete = false;

    // Reference the characters at asciitable.com
    bytes public bytesSample = "abc"; //0x616263
    bytes public bytesSample2 = "ABC";

    // Arrays
    string[] public students = ["John", "Jake", "Jane"]; // <-- dynamic array
    string[3] public students2; // <-- dynamic or fixed array
    int[] public numbers = [1, 2, 3, 4, 5];
        // push, pop, length are methods that apply to arrays

    // Mapping
    mapping(string => bool) public map;
    mapping(int => string) public map2;

    // Enums
    enum Cities { NewYork, LosAngeles, WashingtonDC }

        // Can refererence the custom type
    Cities public c1 = Cities.LosAngeles;
    Cities public c2 = Cities.NewYork;

    // Structs
    struct Student {
        string name;
        bool attendance;
        int rollNo;
        int marks;
    }

    Student public student1;
    Student public student2;
}