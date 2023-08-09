import ballerina/http;
import ballerina/io;

configurable string clientKey = ?;
configurable string clientSecret = ?;
configurable string inactiveAfter = ?;
configurable string inactiveBefore = ?;

const endpointUrl = "https://dev.api.asgardeo.io/t/testin/api/idle-account-identification/v1/inactive-users?";
const emailSubject = "Reset your password";
const string emailContent = "Your password has been expired.";

public function main() returns error? {

        http:Client albumClient = check new ("https://dev.api.asgardeo.io/t/testin/api/idle-account-identification/v1/inactive-users",
            auth = {
                tokenUrl: "https://dev.api.asgardeo.io/t/testin/oauth2/token",
                clientId: clientKey,
                clientSecret: clientSecret,
                scopes: "SYSTEM"
            }
        );
        json[] userList = check albumClient->/(inactiveAfter="2023-09-28");
        io:println(userList);

    foreach var user in userList {
        io:println(user.username);
    }
}
