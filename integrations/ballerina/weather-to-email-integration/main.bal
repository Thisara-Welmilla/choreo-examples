import ballerina/http;
import ballerina/auth;
import wso2/choreo.sendemail;
import ballerina/io;

configurable string clientKey = ?;
configurable string clientSecret = ?;
configurable string inactiveAfter = ?;
configurable string inactiveBefore = ?;

const emailSubject = "Next 24H Weather Forecast";
const string emailContent = "Your password has been expired.";

public function main() returns error? {

    // Create http client
    http:Client basicAuthClient = new({
        auth: {
            scheme: http:AUTHENTICATION_BASIC,
            username: clientKey,
            password: clientSecret
        }
    });

    http:Request request = new;
    request.url = "https://dev.api.asgardeo.io/t/testin/api/idle-account-identification/v1/inactive-users?";
    request.method = http:GET;
    request.setJsonPayload = "grant_type=client_credentials&scope=SYSTEM";

    // Create a new email client
    sendemail:Client emailClient = check new ();

    // Get the weather forecast for the next 24H
    http:Response response = check basicAuthClient->send(request);
    io:println("Successfully fetched the weather forecast data.");

    // Get the json payload from the response
    json jsonResponse = check response.getJsonPayload();
    io:println(jsonResponse);

    // Convert the json payload to a WeatherRecordList
    WeatherRecordList jsonList = check jsonResponse.cloneWithType();
    io:println("Converted the json payload to a WeatherRecordList.");


}
