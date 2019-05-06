# Joe Knows
![logo](https://github.com/maiam6242/E4H/blob/master/Joe%20Knows/Joe%20Knows/Images/JKLogo167.png "Logo for Joe Knows")

### Joe Knows is a beacon-driven app and sensor system which enables visually impaired individuals to navigate public transit safely and effectively.

## Table of Contents
- [Introduction](#Introduction "Introduction")  
- [Motivation](#Motivation "Motivation")  
- [Features](#Features "Features") 
- [Requirements](#Requirements "Requirements") 
- [Feedback](#Feedback "Feedback") 
- [Installation](#Installation "Installation")  
- [Deployment](#Deployment "Deployment")
- [Team](#Team "Team")  
- [Acknowledgments](#Acknowledgments "Acknowledgments") 

## Introduction
This is a beacon and iOS app system for users of the Metro West Regional Transit Authority (MWRTA) who are visually impaired. The system guides users to various stations which are closest to them, first using audio direction feedback, then upon getting closer to the desired destination, vibration feedback based on proximity. The app is screen reader accessible and high contrast to make it easy to use for users who are visually impaired. 

## Motivation
The MWRTA currently lacks a tool to empower its community members who are blind or visually impaired. The RIDE, the MWRTA's door-to-door paratransit service, offers a solution to people who can’t drive but is still inconvenient for those who wish to travel independently. This system is named Joe Knows, after Joe Weisse, a visually impaired commuter who often travels into Boston. It was created to enable Joe and others like him to accurately and safely navigate to various public transit stops without the aid of others.

## Features

- Determine a user's current location and visualize it on a map  
- Display closest transit stops to a user  
- Navigate to given location to within a foot of actual transit stop destination (as opposed to the typical 30 foot radius from GPS navigation)  
- Navigate to the user's home to within a foot of intended destination 

![screenshots](https://github.com/maiam6242/Joe-Knows/blob/master/READMEResources/JoeKnowsMockup.png "Screenshots of Joe Knows app")

## Requirements
- iOS 8.0+
- XCode 10.2.1

## Installation


## Deployment
This system is built to be used with Adafruit Feather 32u4 Bluefruit LE beacons, although with a very small amount of modification can be adapted to be used with any BLE emitting devices. Any devices must be added to the fillMap method of the Beacon Set class (shown below) with a location name, unique identifier and longitude and latitude coordinates.

``` Swift
static func fillMap(){
        BeaconSet.beacon["Adafruit Bluefruit LE 3A6A"] = beaconData(n: "Kansas Street and Route 27 Bus Stop", a: "3A6A", c: -71.356469, f: 42.292805)
        BeaconSet.beacon["Adafruit Bluefruit LE 3A92"] = beaconData(n: "Natick Center Commuter Rail", a: "3A92", c: -71.347075, f: 42.285806)
        BeaconSet.beacon["Adafruit Bluefruit LE 321C"] = beaconData(n: "Natick Common Bus Stop", a: "321C", c: -71.347132, f: 42.284214)
        BeaconSet.beacon["Adafruit Bluefruit LE 84BA"] = beaconData(n: "Moran Park/Downtown Bus Stop", a: "84BA", c: -71.347826, f: 42.285716)
        BeaconSet.beacon["Adafruit Bluefruit LE 0703"] = beaconData(n: "Coolidge Gardens Bus Stop", a: "0703", c: -71.347077, f: 42.280864)
        BeaconSet.beacon["Adafruit Bluefruit LE 9851"] = beaconData(n: "Senior Center Bus Stop", a: "9851", c: -71.337094, f: 42.287485)
        BeaconSet.beacon["Adafruit Bluefruit LE 6E45"] = beaconData(n: "Joe's House", a: "6E45", c: -71.353893, f: 42.282489)
            
        }
 ```

Once these values are changed or values are added, the software will change to provide directions to the specified new beacon locations. 

It is also important to note that we powered the beacons with 500 mAh Li-Polymer Batteries. These batteries are durable and can operate within a temperature range of -20 degrees Celcius to 60 degrees Celcius. Each battery can also power a beacon for a few years.

Said beacons and batteries can be placed in [these enclosures](INSERT ENCLOSURE LINK HERE). These enclosures serve to provide a friendly and fairly weatherproof exterior. They are 3D printed from black PLA filament. For extra protection, we also placed the beacons and batteries in small plastic bags inside of these enclosures.


## Feedback
We would love to hear feedback on this project! Feel free to [email us](mailto:mmaterman@olin.edu "mmaterman@olin.edu") or [submit an issue](https://github.com/maiam6242/Joe-Knows/issues/new "New Issue Request"). If you are interested in contributing to this project or chatting about it in general, please don't hesitate to [email us](mailto:mmaterman@olin.edu "mmaterman@olin.edu") here!

## Team
Maia Materman [@maiam6242](https://github.com/maiam6242 "Maia's GitHub")    
Annie Tor [@ator1](https://github.com/ator1 "Annie's GitHub")  
Corey Cochran-Lepiz [@coreyacl](https://github.com/coreyacl "Corey's GitHub")  

## Acknowledgments
Thanks to Caitrin Lynch and Ela Ben-Ur for their support throughout this process. Also thank you to Paul Ruvolo for helping us navigate Swift. Most importantly, thank you to Joe Weisse for co-designing this system with us and giving us feedback throughout this project.

