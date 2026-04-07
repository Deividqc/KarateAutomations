function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
	  apiURL: 'https://conduit-api.bondaracademy.com/api/'
  }
  
  if (env == 'dev') {
    config.userEmail = 'jesus.quispe@globant.com';
    config.userPassword='Gabylu212208.';
  } else if (env == 'qas') {
    config.userEmail = 'mimivel@nethome.com';
    config.userPassword='LucyGaby2026.';
  }

  // AuthToken is coming from the CreateToken.feature 
  // Set a variable when calling this feature, so it can be used by anyone who wants to run the tests without the need to change the email and password in the CreateToken.feature
  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken;
  karate.configure('headers', { Authorization: 'Token ' + accessToken });

  return config;
}
