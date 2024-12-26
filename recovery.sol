// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EIP712Digest {
    struct TransferMessage {
        uint256 fid;
        address to;
        uint256 deadline;
    }
    

    bytes32 public constant TRANSFER_TYPEHASH = keccak256("TransferMessage(uint256 fid,address to,uint256 deadline)");


    function getTransferDigest(TransferMessage memory msgData) public pure returns (bytes32) {

        bytes32 domainSeparator = keccak256(
            abi.encode(
                keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                keccak256(bytes("Farcaster ID Registry")),
                keccak256(bytes("1")),
                10,
                0x00000000Fc6c5F01Fc30151999387Bb99A9f489b
            )
        );
        
        return keccak256(
            abi.encodePacked(
                domainSeparator,
                keccak256(
                    abi.encode(
                        TRANSFER_TYPEHASH,
                        msgData.fid,
                        msgData.to,
                        msgData.deadline
                    )
                )
            )
        );
    }
}
