// SPDX-License-Identifier: MIT

//Pragma: used to enable certain compiler features or checks
//annotated with a version pragma to reject compilation with future
// compiler versions that might introduce compiler changes

//TASK 1-SET VERSION TO ^0.8.17;
pragma solidity ^0.8.17;


contract SocialETH {

    struct UserStruct {
        //Structs: allow you to define your own data types which group together related data
        string username;
        uint age;
        bool isUser;

    }

// TASK 2
//CREATE A STRUCT THAT HAS AS ATTRIBUTES: title, body, time
    struct Post {
     
     string title;
     uint time;
     string body;

    }

//TASK 3
//CRAETE A MAPPING called "users" that has keys of type "address", and values of type "UserStruct"


    mapping (address => Post[]) posts;
    mapping (address => UserStruct) users;
    uint userCount;


//TASK 4
//COMPLETE THE RETURN STATEMENT
    function getUser (address _userAddress) public view returns (UserStruct memory){
    
       return users[_userAddress];
    }

//TASK 5
//INSTANTIATE username, age, isUser
    function craeteUser (address _userAddress, string memory _username, uint _age) public returns (bool success){

        UserStruct memory user;

        user.username = "test-user";
        user.age =10;
        user.isUser = true;

        users[_userAddress] = user;
        userCount ++;
        return true;
    }

//TASK 6
//RETURN THE TOTAL NUMBER OF USERS (userCount)
    function getTotalUsers () public view returns (uint) {
        return userCount;
    }


    function craetePost (
        address _userAddress,
        string memory _title,
        string memory _body
    ) 
    public returns (bool) {

        
        Post memory newPost;
//TASK 7
//INSTANTIATE title, body, and time (Hint: for time you can use'timestamp' transaction property from 'block')
 //...

        newPost.title = _title;
        newPost.body = _body;
        newPost.time = block.timestamp;


        posts[_userAddress].push(newPost);
        return true;
    }
//TASK 8
//RETURN THE POSTS CORRESPONDING TO A GIVEN ADDRESS
    function getPosts(address _userAddress) public view returns (Post[] memory) {
      return posts[_userAddress];
    }
//TASK 9
// In getUser(): check if the user exists, otherwise throw "User does not exist"

//TASK 10
// In createPost(): check if user is registered, otherwise throw "User not registered"



//TASK 11
// In createPost(): check if user only posts on their behalf, otherwise throw "You can only post on your behalf"


}