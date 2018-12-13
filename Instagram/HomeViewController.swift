//
//  HomeViewController.swift
//  Instagram
//
//  Created by Denny Ho on 10/1/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var photoTableView: UITableView!
    var instaPosts: [Post]! = []
    
    @IBAction func onPhotos(_ sender: Any) {
    }
    
    //Logout User
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }
    }
    
    //Load TableView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        photoTableView.rowHeight = 360
        photoTableView.dataSource = self
        photoTableView.delegate = self
        
        self.onTimer()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        photoTableView.insertSubview(refreshControl, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.instaPosts.count != 0{
            return self.instaPosts.count
        }else{
            print("No posts found")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.instagramPost = self.instaPosts[indexPath.row]
        return cell
    }
    
    //Network Request
    func onTimer(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        //query.includeKey("createdAt")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.instaPosts = posts as! [Post]
            } else {
                print(error?.localizedDescription)
            }
            self.photoTableView.reloadData()
        }
    }
    
    //Refresh
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        onTimer()
        refreshControl.endRefreshing()
    }
  
}
