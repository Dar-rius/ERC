pragma solidity 0.8.18;

contract ERC721{
    //Variables
    //renvoi le nombre de token que contient une adresse
    mapping (address => uint256) private balance;
    //renvoi l'adresse du proprietaire d toke
    mapping (uint256 => address) private owner;
    //renvoi l'adresse du compte tiers disposant de tokens
    mapping (uint256 => address) private totalApprovals;
    //renvoi depuis le proprietaite l'adresse de l'operateurs autorise
    mapping (address => mapping(address => bool)) private opperatorApprovals;

    //Evenements
    //Event pour les transfert d'adresse
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenID);
    //Event pour le transfert de token avec un cpmpte tiers
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenID);
    //Event sur l'activation ou la desactivation d'un operateurs
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    //Les fonctions
    //fonction permet voir le nombre de token que dispose l'adresse
    function balanceOf(address _owner) external view returns(uint256) {
        require(_owner != address(0));
        return balance[_owner];
    }
    
    //Fonction qui retourne l'adresse du detenteur du token
    function ownerOf(uint256 _tokenID) external view returns(address){
        require(owner[_tokenID] != address(0));
        return owner[_tokenID];
    }

    // Cette fonction transfert le token vers le destinataire
    function safeTransferFrom(address _from, address _to, uint256 _tokenID) external payable{
        require(_from != address(0));
        require(owner[_tokenID] == _from, "C'est pas la bonne adresse");
        require(_to != address(0));
        
        delete owner[_tokenID];
        balance[_from] -= 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }

    //Cette fonction fait la meme chose que la precedente
    function safeTransferFrom(address _from, address _to, uint256 _tokenID, bytes memory _data) external payable {
        require(_from != address(0));
        require(owner[_tokenID] == _from, "C'est pas la bonne adresse");
        require(_to != address(0));

        delete owner[_tokenID];
        balance[_from] -= 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }
    
    // cette fonction permet a l'adresse _from de transferer la propriete du token a l'adresse tokenID
    function transferFrom(address _from, address _to, uint256 _tokenID) external payable{
        require(_from != address(0));
        require(owner[_tokenID] == _from, "C'est pas la bonne adresse");        
        require(_to != address(0));

        delete owner[_tokenID];
        balance[_from] -= 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);       
    }

    // Cette fonction permet a une adresse tiers d'etre affirmer pour la gestion d'un token 
    function approve(address _approved, uint _tokenID) external {
        require(msg.sender == owner[_tokenID], "C'est pas la bonne adresse");
        require(_approved != totalApprovals[_tokenID], "Cette adresse detient deja ce token");
        require(_approved != address(0));

        totalApprovals[_tokenID] = _approved;
        emit Approval(msg.sender, _approved, _tokenID);
    }

    //Cette fonction permet a un operateur d'etre approver entre true/false
    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0));
        require(msg.sender != _operator);
        
        opperatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    } 


    //Cette fonction retourne l'adresse approuver pour la gestion du token
    function getApprovalForAll(uint256 _tokenID) external view returns(address){
        require(owner[_tokenID] != address(0), "Ce token n'existe pas");
        require(totalApprovals[_tokenID] != address(0), "Ce token n'existe pas parmis les approbations");
        return totalApprovals[_tokenID];
    } 

    //Cette fonction rentourne si un adresse est approuver
    function isApprovalAll(address _owner, address _operator) external view returns(bool){
        require(_owner != address(0));
        require(_operator != address(0));
        require(opperatorApprovals[_owner][_operator], "Cet addresse n'est pas autoriser");
        return opperatorApprovals[_owner][_operator];
    }

    //Fonction pour l'emission de nouveaux token
    function _mint(uint _tokenID, address _to) internal{
        require(owner[_tokenID] == address(0));
        require(_to != address(0));
        owner[_tokenID] = _to;
        balance[_to] +=1;
        emit Transfer(address(0),_to, _tokenID);
    }
}