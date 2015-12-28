//
//  HomeViewController.swift
//  EmergencyApp
//
//  Created by Shah, Chintan on 12/22/15.
//  Copyright © 2015 Shah, Chintan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class HomeViewController: UIViewController, AVAudioPlayerDelegate, CLLocationManagerDelegate {

    var audioPlayer: AVAudioPlayer!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPlayer()
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("locationServicesEnabled.. in app ")
            locationManager.startUpdatingLocation()
        }
        
        
        let defaults = NSUserDefaults.init(suiteName: "group.sirius.demos.emergencyapp")
//        standardUserDefaults()
        
        if let test = defaults!.objectForKey("prefs")    {
            print("******* WORKING locationServicesEnabled.. in app: prefs : ", test)
        }else{
            print("******* NOT WORKING ")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func panicAction(sender: AnyObject) {
        self.audioPlayer.play()
    }
    
    @IBAction func callAction(sender: AnyObject) {
        
//        if let url = NSURL(string: "tel://9884265337") {
//            UIApplication.sharedApplication().openURL(url)
//        }
        
        if let currentLocation = locationManager.location{
            print("#### CURRENT LOCATION : longitude: \(currentLocation.coordinate.longitude) latitude: \(currentLocation.coordinate.latitude)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations from app = \(locValue.latitude) \(locValue.longitude)")
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let dict = ["Latitude": locValue.latitude, "Longitude": locValue.longitude, "Source": "App", "Time": timestamp]
        
        let locations = defaults.objectForKey("Locations")?.mutableCopy()
        
        if(locations != nil){
            
            let locationsArray = locations as! NSMutableArray
            locationsArray.addObject(dict)
            defaults.setObject(locationsArray, forKey: "Locations")
            
            print("\n\n\n\n\n\n ############ locations ############\n\n\n\n\n", locations)
        }else{
            
            print("Locations prefs null")
            
            let array = NSMutableArray(object: dict)
            defaults.setObject(array, forKey: "Locations")
            
            print("Locations prefs created")
        }
        
        
    }
    
    func initPlayer() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "wav")!))
            
        } catch {
            print("Error")
        }
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        print("path: ", path)
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }

}
