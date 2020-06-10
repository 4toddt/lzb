/*global TestCase: true,
 expectAsserts: true,
 assertEquals: true,
 expectAsserts: true,
 assertTrue: true,
 assertFalse: true,
 assertNull: true,
 LZB: true,
 Mediator: true*/
/*jslint sloppy: true, newcap: true*/

//https://code.google.com/p/js-test-driver/wiki/TestCase
var ProfileTest = TestCase("ProfileTest"),
    config,
    profileData,
    initializedSubscriber,
    profileSubscriber,
    errorSubscriber;


ProfileTest.prototype.setUp = function () {
	jstestdriver.console.log('setUp');

  initializedSubscriber = LZB.mediator.subscribe("profile/initialized", function (obj) {
    jstestdriver.console.log('initialized');
    config = obj;
  });

  errorSubscriber = LZB.mediator.subscribe("profile/error",function(){
    jstestdriver.console.log('error from profile request');
  });
};

ProfileTest.prototype.tearDown = function () {
	jstestdriver.console.log('tearDown');

  LZB.mediator.unsubscribe("profile/initialized", initializedSubscriber);
  LZB.mediator.unsubscribe("profile/profile response", profileSubscriber);
  LZB.mediator.unsubscribe("profile/error", errorSubscriber);

  config = null;
  profileData = null;

};

ProfileTest.prototype["test profile is not public"] = function () {
	/**
	 * good citizen, don't pollute global
	 * don't extend LZB
	 */
	//assertTrue(profile === undefined);
	assertTrue(LZB.profile === undefined);
};

ProfileTest.prototype["test profile can initialize given config"] = function () {
	var fakes = {
		test : true
	};

	assertEquals("initial configuration is null", null, config);
  LZB.mediator.publish("profile/init")(fakes);
	assertEquals("profile config updated", fakes, config);

};

ProfileTest.prototype["test bad profile request"] = function () {
	var testBadConfig = {
		profileServiceUrl : "wrong url"
  };

  LZB.mediator.publish("profile/init")(testBadConfig);
  LZB.mediator.publish("profile/profile request");
	profileSubscriber = LZB.mediator.subscribe("profile/profile response", function(obj){
		profileData = obj;
		assertEquals("profile is unset", undefined, profileData);
	});
};

 ProfileTest.prototype["test good profile request"] = function () {
 var  testProfile = {
   profileServiceUrl : "../test/profile.json"
 };

 LZB.mediator.publish("profile/init")(testProfile);
 LZB.mediator.publish("profile/profile request");

	 profileSubscriber = LZB.mediator.subscribe("profile/profile response", function(obj){
		 profileData = obj;
		 assertEquals("profile is set.", "Marco", profileData.firstName);
	 });

 };



