import "./musicTokenSale.sol";
import "./singer.sol";

contract MusicList{

    address private tokenAddr = 0x46776ea4284bfe627efdedebaec2afbed03c79f1;

    // address private singerAddr = 0xbce2bdd2b51fbf4476b8af42a819aa96e34ae203;

    address private adminAddr = 0xa2d75031dca7047c458a5a3c8e6e3512ca1c50c7;

    uint internal musicPrice = 100;

    uint internal musicNumber;

    struct MusicInfo{
        string name;
        address singer;
        uint price;
    }

    mapping(uint => MusicInfo) list;

    //mapping(address => mapping(uint => MusicInfo)) singerToMusic;

    event play(address singer, uint price);

    event addedMusic(address singer, uint musicNumber);

    function addMusic(string _name, address _singer) public returns (bool success){
        uint tmpMusicNumber = musicNumber++;
        //check if signer is valid
        // if (!SingerList(singerAddr).checkSinger(msg.sender)){
        //     return false;
        // }
        list[tmpMusicNumber] = MusicInfo(_name, _singer, musicPrice);
        emit addedMusic(_singer, tmpMusicNumber);
        return true;
    }

    function playMusic(uint _musicNumber) public {
        MusicInfo memory info = list[_musicNumber];
        address user = msg.sender;
        address singer = info.singer;
        ERC20Token(tokenAddr).transferFrom(user, singer, musicPrice);
        emit play(info.singer, info.price);
    }

    function getMusicInfo(uint _musicNumber) public view returns(string name, address singer, uint price) {
        MusicInfo memory info = list[_musicNumber];
        return (info.name, info.singer, info.price);
    }

    function getLastMusicNumber() public view returns(uint lastMusicNumber) {
        return musicNumber;
    }
}
