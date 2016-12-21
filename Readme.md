# AdColony iOS module for Godot

## TMO Games. José M. Pan
#### _December, 2016_

---

Hi! I've made this module to show AdColony video ads in [Godot](http://www.godotengine.org)
It uses AdColony SDK 3.0+ for iOS, I'll try to implement it for Android, but feel free to add it if you want, :)
Only interstitials are supported. However, I'm planning to add video rewards.


### Setup

1. Add the folder tm_adcolony to the *modules* folder in Godot source
2. Add the [AdColony framework](https://github.com/AdColony/AdColony-iOS-SDK-3) to the *lib* folder
3. Compile Godot

### Using AdColony
1. Setup and initialize the singleton ("TMAdColony"):

    ```
    var adcolony = Global.has_singleton("TMAdColony")
    adcolony.setup("appid", "zoneid")
    ```
    
2. Request interstitial:

    ```
    adcolony.request_interstitial()
    ```
    
3. Launch the video:

    ```
    adcolony.launch_interstitial()
    ```
    
4. Optionally you can catch the event for the ad finished:

    ```
    adcolony.connect("video_ad_finished", self, "on_ad_finished")
    ```
    
5. And that's it!