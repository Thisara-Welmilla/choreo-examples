import ballerina/http;
import ballerina/io;
import ballerina/oauth2;

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

        oauth2:ClientOAuth2Provider provider = new({
            tokenUrl: "https://localhost:9445/oauth2/token",
            clientId: "3MVG9YDQS5WtC11paU2WcQjBB3L",
            clientSecret: "9205371918321623741",
            scopes: ["token-scope1", "token-scope2"]
        });

        http:Client albumClient = check new (endpointUrl,
            auth = {
                token: bearerToken
            }
        );
        json[] userList = check albumClient->/(inactiveAfter="2023-09-28");
        io:println(userList);

    foreach var user in userList {
        io:println(user.userId);
        string userid = (check user.userId).toString();

        http:Client albumClientt = check new (scimEndpoint + "/" + userid,
            auth = {
                token: bearerToken
            }
        );
        json[] userListt = check albumClientt->/();
        io:println(userListt);
    }
}
