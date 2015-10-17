@environments = [

	firefoxdesk = {
		browser: "firefox",
		platform: "desktop",
		type: "computer",
		tag: ":ff_d" 
	},

	
	ios = {
		browser: "browser",
		platform: "andriod",
		type: "mobile",
		tag: ":b_andr",
		desired_caps: {
			caps: {
				platformName: 'Android',
				platformVersion: '5.1',
				deviceName: 'Nexus_5_API_22_x86',
				browserName: 'Browser',
			}
		}

	},

	andriod = {
		browser: "safari",
		platform: "ios",
		type: "mobile",
		tag: ":saf_ios",
		desired_caps: {
			caps: {  
			    platformName: 'iOS',  
			    platformVersion: '8.1',  
			    deviceName: 'iPhone 5s',  
			    browserName: 'Safari',
			}
		}
	} 

]

def self.quotebane
	self.gsub( /\A"/m, "" ).gsub( /"\Z/m, "" )
end