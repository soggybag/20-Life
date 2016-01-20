# 20-Life
20 Life is an app to keep score for games like Magic the Gathering, or other similar games. The app was meant to be simple 
and intuitive. The interface is gesture driven and eschews the use of buttons. Swipe up or down to increase or decrease 
your score. Swipe left to reveal the options screen. Double tap to reset your score. 

You can download this app from the app store [here](https://itunes.apple.com/us/app/20-life/id954969580?mt=8&uo=4), or 
visit the web [site](http://webdevils.com/20-life/).

#Info
This app uses UISwipeGestureRecognizer, and UITapGestureRecognizer for handling interaction. Transitions are handled with 
UIView.transitionFromView(_:toView:duration:Options:completion). While the page curl is a little hokey it seemed to fit 
here. 

I used UIAlertView which depracated from iOS 8.0. This should be updated to UIAlertController, I put this on the todo list...

#Screenshots
[Screenshot](http://webdevils.com/20-life/20-Life-Screensot-1.jpg)
