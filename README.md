# sms82

if user have no toke or not authorized
if user have no toke or not authorized
RESPONSE
{
  "detail": "Authentication credentials were not provided."
}

// ===============================================
GET
https://sms82.herokuapp.com/api/message/list

return list of messages of authorized user
[
  {
    "timestamp": "2017-04-21T13:23:22.694139Z",
    "sender": "test_user",
    "receivers": 3,
    "body": "asdf",
    "id": 1
  },
  {
    "timestamp": "2017-04-21T13:50:37.852996Z",
    "sender": "test_user",
    "receivers": 3,
    "body": "asdfdsafsasadf",
    "id": 2
  }
]


// ===============================================

GET
https://sms82.herokuapp.com/api/message/1/

return details of message with id 1
{
  "owner": "test_user",
  "message": "asdf",
  "phones": [
    {
      "number": "123",
      "status": "sending"
    },
    {
      "number": "123",
      "status": "sending"
    },
    {
      "number": "123",
      "status": "sending"
    }
  ]
}



// ===============================================
GET
https://sms82.herokuapp.com/api/message/send/
{
    "balance": 14,
    "allowed_length": 1000
}

POST (body params are "message":"2iu320948239", "phone":"123", "phone":"232", "phone":"22")
RESPONSE
{
  "info": {
    "message_body": "2iu320948239",
    "phones": [
      "123",
      "232",
      "22"
    ]
  },
  "previous_balance": 14,
  "balance": 11,
  "notification": "Messages sent!"
}

