
pragma solidity >=0.4.22 <0.6.0; 
 
contract FirstTask{ 
 
   struct  Student{
       
       int rollno;
       string name;
       string email;
       string gender;
       
   }
   
   Student[] private studentsData;
   
   constructor  ()  public{
       
       Student memory s1 = Student(1,"asim","abc@gmail.com","male");
       Student memory s2 = Student(1,"khaliq","xyz@gmail.com","male");
       studentsData.push(s1);
       studentsData.push(s2);
       
   }
   
   function setStudent(int id,string memory name,string memory email,string memory gender) public{

       Student memory s1 = Student(id,name,email,gender);
       studentsData.push(s1);
       
   }
   
   function getdata() public view returns(int,string memory,string memory,string memory){
       return (studentsData[1].rollno,studentsData[1].name,studentsData[1].email,studentsData[1].gender);
   }
   
   function searchStudent(string memory mail) public view returns(int,string memory name,string memory email,string memory gender) {
       
       for(uint8 i = 0;i<studentsData.length;i++){
           
           if(keccak256(bytes(studentsData[i].email)) == keccak256(bytes(mail)) ){
              
               return (studentsData[i].rollno,studentsData[i].name,studentsData[i].email,studentsData[i].gender);
              
           }
           
       }
   }
   

       
   
     
}
