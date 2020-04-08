//
//  TableTabbedViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit

// This class populates student coordinate information on to a table view.

class TableTabbedViewController: UITableViewController {
    
    // MARK:- View methods

    // The GET request is in viewWillAppear so that it is refreshed whenever the view appears, rather than loads.
    // The view remains loaded in the stack as the posting views are presented modally.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Run the GET request for the student locations.
        
        NetworkGetRequests.requestStudentLocation(completionHandler: handleStudentLocationResponse(success:location:error:))
        
    }

    // MARK: - IBActions
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        
        // Refresh the mapView by requesting the GET request again.
        
        NetworkGetRequests.requestStudentLocation(completionHandler: handleStudentLocationResponse(success:location:error:))
        
    }
    
    // MARK: Response handling
    // This method handles the completionHandler from the GET request.
    
    func handleStudentLocationResponse(success: Bool, location: [Locations], error: Error?) {
        
        // If the GET request is successful, the student locations are saved to the struct and the table view is reloaded. See table view methods for further information.
        
        if success {
            
            StudentLocations.studentLocations = location
            
            self.tableView.reloadData()
            
        } else {
            
            // If an error occurs on the GET request. An AlertViewController is presented.
            // A customised error is passed through the network logic.
            
            showLogicFailure(title: "Retrieving information failed", message: error?.localizedDescription ?? "")
            
        }
        
    }

    // MARK:- TableView methods
    
    // This method defines the number of sections in the table view.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    // This method defines the number of rows in the table view. This will be equivalent to the number of student locations pulled from the network. This is by default equal to 100.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocations.studentLocations.count
        
    }

    // This method defines the composition of the cells in each row.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Define the cell as detailed in the TableTabbedViewCell class.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableTabbedViewCell", for: indexPath) as! TableTabbedViewCell

        // Extract information from the StudentLocations struct.
        
        let location = StudentLocations.studentLocations[indexPath.row]
        
        // Define what is shown in the cell.
        
        cell.studentNameLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.mediaURLLabel?.text = "\(location.mediaURL)"

        return cell
    }
    
    // This method defines the action on when a specific cell is tapped.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Extract information from the StudentLocations struct.
     
        let location = StudentLocations.studentLocations[indexPath.row]
        
        // Define the URL extracted and open it in the browser.
        
        let studentURL = URL(string: location.mediaURL)
        
        // If the studentURL specified is nil, no action is called.
        
        if studentURL != nil {
            UIApplication.shared.open(studentURL!)
            
        }
            else {
                return
            
            }
        
    }
    
    // This method ends the current session and logs the user out.
    
    @IBAction func logoutTapped(_ sender: Any) {
        NetworkDeleteRequests.logout {
                self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
