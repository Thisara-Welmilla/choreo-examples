import ballerina/http;
import wso2/choreo.sendemail;
import ballerina/io;

configurable string clientKey = ?;
configurable string clientSecret = ?;
configurable string inactiveAfter = ?;
configurable string inactiveBefore = ?;

const endpointUrl = "https://dev.api.asgardeo.io/t/testin/api/idle-account-identification/v1/inactive-users?";
const emailSubject = "Next 24H Weather Forecast";
const string emailContent = "Your password has been expired.";

public function main() returns error? {


        http:Client albumClient = check new ("https://dev.api.asgardeo.io/t/testin/oauth2/token",
            auth = {
                tokenUrl: "https://dev.api.asgardeo.io/t/testin/oauth2/token",
                clientId: clientKey,
                clientSecret: clientSecret,
                scopes: "admin"
            }
        );
        string payload = check albumClient->/albums;
        io:println(payload);


}
