//
//  TodayViewController.swift
//  EmergencyWidget
//
//  Created by Shah, Chintan on 12/22/15.
//  Copyright © 2015 Shah, Chintan. All rights reserved.
//

import UIKit
import NotificationCenter
import AudioToolbox
import AVFoundation
import CoreLocation

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    
    let locationManager = CLLocationManager()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(320, 50)
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("locationServicesEnabled.. in extension ")
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

        completionHandler(NCUpdateResult.NewData)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations from extension = \(locValue.latitude) \(locValue.longitude)")
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let dict = ["Latitude": locValue.latitude, "Longitude": locValue.longitude, "Source": "Extension", "Time": timestamp]
        
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
            
            let path = NSBundle.mainBundle().pathForResource("alarm", ofType: "wav")
            print("path inside target: ", path)
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!))
        } catch {
            print("Error")
        }
    }
    
    
    @IBAction func panicAction(sender: AnyObject) {
        print("inside EXTENSION panic action")
        initPlayer()
        self.audioPlayer.play()
        
//        AudioServicesPlaySystemSound(1151); //1304
        
    }
    
    @IBAction func callAction(sender: AnyObject) {
        print("inside EXTENSION call action")
//        extensionContext?.openURL(NSURL(string: "tel://9884265337")!, completionHandler: nil)
        
        if let currentLocation = locationManager.location{
            print("#### CURRENT LOCATION : longitude: \(currentLocation.coordinate.longitude) latitude: \(currentLocation.coordinate.latitude)")
        }
        
        
    }

    @IBAction func alertAction(sender: AnyObject) {
        
        let defaults = NSUserDefaults.init(suiteName: "group.sirius.demos.emergencyapp")
        defaults!.setObject("Test", forKey: "prefs")

    }
    
}
