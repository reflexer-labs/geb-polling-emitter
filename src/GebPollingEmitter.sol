pragma solidity ^0.6.7;

contract GebPollingEvents {
    event PollCreated(
        address indexed creator,
        uint256 blockCreated,
        uint256 indexed pollId,
        uint256 startDate,
        uint256 endDate,
        string multiHash,
        string url
    );

    event PollWithdrawn(
        address indexed creator,
        uint256 blockWithdrawn,
        uint256 pollId
    );

    event Voted(
        address indexed voter,
        uint256 indexed pollId,
        uint256 indexed optionId
    );
}

contract GebPollingEmitter is GebPollingEvents {
    uint256 public npoll;

    function createPoll(uint256 startDate, uint256 endDate, string calldata multiHash, string calldata url)
        external
    {
        uint256 startDate_ = startDate > now ? startDate : now;
        require(endDate > startDate_, "GebPollingEmitter/polling-invalid-poll-window");
        emit PollCreated(
            msg.sender,
            block.number,
            npoll,
            startDate_,
            endDate,
            multiHash,
            url
        );
        require(npoll < uint(-1), "GebPollingEmitter/polling-too-many-polls");
        npoll++;
    }

    function withdrawPoll(uint256 pollId)
        external
    {
        emit PollWithdrawn(msg.sender, block.number, pollId);
    }

    function vote(uint256 pollId, uint256 optionId)
        external
    {
        emit Voted(msg.sender, pollId, optionId);
    }

    function withdrawPoll(uint256[] calldata pollIds)
        external
    {
        for (uint i = 0; i < pollIds.length; i++) {
            emit PollWithdrawn(msg.sender, pollIds[i], block.number);
        }
    }

    function vote(uint256[] calldata pollIds, uint256[] calldata optionIds)
        external
    {
        require(pollIds.length == optionIds.length, "GebPollingEmitter/non-matching-length");
        for (uint i = 0; i < pollIds.length; i++) {
            emit Voted(msg.sender, pollIds[i], optionIds[i]);
        }
    }
}
