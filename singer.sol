contract SingerList{

    mapping(address => string) singerList;

    function getSingerName(address _singer) public view returns(string singerName) {
        return singerList[_singer];
    }

    function addSinger(address _singer, string _singerName) public {
        singerList[_singer] = _singerName;
    }

    function checkSinger(address _singer) public returns(bool){
        if (bytes(singerList[_singer]).length == 0){
            return false;
        }
        else{
            return true;
        }
    }

}
