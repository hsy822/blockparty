contract SingerList{

    mapping(address => string) singerList;

    // address[] public checkList;

    function getSingerName(address _singer) public view returns(string singerName) {
        return singerList[_singer];
    }

    function addSinger(address _singer, string _singerName) public {
       // require(!checkSinger(_singer));
        singerList[_singer] = _singerName;
       // checkList.push(_singer);
    }

    function checkSinger(address _singer) public returns(bool){

       /* for(var i =0; i<checkList.length; i++){
            if(checkList[i] == _singer){
                return true;
            }
        }*/

        return false;

    }

}
