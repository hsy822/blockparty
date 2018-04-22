import "browser/ERC20Token.sol";
import "browser/SingerList.sol";

contract MusicList{

    address private tokenAddr = 0x13317c25d423ebe044d2396a6964083712490a41;

    address private singerAddr = 0x25fc347f30e16e154bcc2036434a47b63e7078fe;

    address private adminAddr = 0x4f5e411205ce8fbf63fb7fd20589306e08cec1f5;

    uint internal musicPrice = 100;

    uint internal givePrice = 40;

    uint internal musicNumber;

    struct MusicInfo{
        string name;
        address singer;
        uint price;
        uint coin;
    }

    mapping(uint => MusicInfo) list;

    //mapping(address => mapping(uint => MusicInfo)) singerToMusic;

    event play(address singer, uint coin);

    event addedMusic(address singer, uint musicNumber);

    function addMusic(string _name) public returns (bool success){
        uint tmpMusicNumber = musicNumber++;
        //check if signer is valid
        if (!SingerList(singerAddr).checkSinger(msg.sender)){
            return false;
        }
        list[tmpMusicNumber] = MusicInfo(_name, msg.sender, musicPrice, 0);
        emit addedMusic(msg.sender, tmpMusicNumber);
        return true;
    }

    function playMusic(uint _musicNumber) public {
        MusicInfo storage info = list[_musicNumber];
        info.coin += givePrice;
        address user = msg.sender;
        address singer = info.singer;
        ERC20Token(tokenAddr).transferFrom(user, singer, givePrice);
        ERC20Token(tokenAddr).transferFrom(user, adminAddr, musicPrice-givePrice);
        emit play(info.singer, info.coin);
    }

    function getMusicInfo(uint _musicNumber) public view returns(string name, address singer, uint price) {
        MusicInfo storage info = list[_musicNumber];
        return (info.name, info.singer, info.price);
    }

    function getMusicDetailInfo(uint _musicNumber) public view returns(string name, address singer, uint price, uint coin) {
        MusicInfo storage info = list[_musicNumber];
        return (info.name, info.singer, info.price, info.coin);
    }

    function getLastMusicNumber() public view returns(uint lastMusicNumber) {
        return musicNumber;
    }
}
