import ballerina/http;
import ballerina/io;

configurable string clientKey = ?;
configurable string clientSecret = ?;
configurable string inactiveAfter = ?;
configurable string inactiveBefore = ?;

const endpointUrl = "https://dev.api.asgardeo.io/t/testin/api/idle-account-identification/v1/inactive-users";
const scimEndpoint = "https://dev.api.asgardeo.io/t/testin/scim2/Users";
const emailSubject = "Reset your password";
const string emailContent = "Your password has been expired.";
const string bearerToken = "395a0182-709c-3da8-adb0-157aac91a8c6";

public function main() returns error? {

        http:Client albumClient = check new (endpointUrl,
            auth = {
                token: bearerToken
            }
        );
        json[] userList = check albumClient->/(inactiveAfter="2023-09-28");
        io:println(userList);

    foreach var user in userList {
        io:println(user.userId);
        string userid = user.userId.toString();

        http:Client albumClientt = check new (scimEndpoint,
            auth = {
                token: bearerToken
            }
        );
        json[] userListt = check albumClientt->/userid;
        io:println(userListt);
    }
}
