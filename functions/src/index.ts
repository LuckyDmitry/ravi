import * as functions from "firebase-functions";

exports.sendCode = functions.https.onCall(async (data, context) => {
  return "This is a response from CHATGPT";
});
