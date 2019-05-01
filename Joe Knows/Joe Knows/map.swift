//
//  map.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/30/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import MapKit

struct map{
   
    var mapView:MKMapView!
    var view : UIView!
    
    init (){
    //This initializes a mapkit object with a compass. It does not however, specify a view in relation to the screen
        
    //creates the view of the mapkit map itself
    mapView = MKMapView()
    mapView.isAccessibilityElement = false
    mapView.mapType = MKMapType.standard
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
    mapView.showsCompass = false
        
    //creates compass on top corner of the screen
    makeCompass()
        
    //centers the view of the map and sends it to the background of the screen
    mapView.center = view.center
    view.addSubview(mapView)
    view.sendSubviewToBack(mapView)
    }
    
    init(actualScreenView: UIView){
        //This initializes a mapkit object that fits within the bounds of the screen and places a compass in the map
        
        //creates the view of the mapkit map itself
        mapView = MKMapView()
        mapView.isAccessibilityElement = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = false
        
         //creates view of the map which is the right size for the screen
        view = actualScreenView
        let leftMargin:CGFloat = 1
        let topMargin:CGFloat = 1
        let mapWidth:CGFloat = view.frame.size.width-6
        let mapHeight:CGFloat = view.frame.size.height-10
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
   
        //creates compass on top corner of the screen
        makeCompass()
        
        //centers the map view on the screen itself and adds it to the background of the screen
        mapView.center = view.center
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
    }
    
    
    func makeCompass(){
        //creates a compass and places it on the top corner of screen
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        mapView.addSubview(compassButton)
        view.bringSubviewToFront(compassButton)
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12).isActive = true
        
    }

}
