//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Terry Harmer on 23/01/2016.
//  Copyright © 2016 Terry Harmer. All rights reserved.
//  My Concrete Subclass of Abstract class UIViewController

import UIKit

class ToDoListViewController: UIViewController,  UITableViewDataSource,  AddItemViewControllerProtocol {
    
    let cacheKey = "CacheKey"
    let cellIdentifier = "CellIdetifier"
    
    @IBOutlet weak var tableView: UITableView?
    
    var items = NSMutableArray()
    var cache: CacheProtocol = KeyedArchiverCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        // Load persisted data if exists
        self.load()
        
        
        self.title = "ToDo List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAdd:")
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.tableView?.dataSource = self
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier : self.cellIdentifier)
    
        
    }
    
    //MARK: AddItemViewControllerProtocol
    
    func addItem(item: String) {
        print(item)
        
        //Add new item to items array
        self.items.insertObject(item, atIndex: 0)
    
        //Modify tableview  to display new item
        //self.tableView?.reloadData()
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        
        //Save current data to disk
        self.save()
        
    }
    
    override func setEditing(editing: Bool, animated: Bool)
    
    {
        //print("Edit")
            super.setEditing(editing, animated: animated)
            self.tableView?.setEditing(editing, animated: animated)
            self.navigationItem.rightBarButtonItem?.enabled = !editing
        
    }
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)!
        let item = self.items[indexPath.row] as! String
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            
         self.items.removeObjectAtIndex(indexPath.row)
         self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            //save data to disk
            self.save()
            
        }
        
    }
    
    
      //MARK: Actions
    func didTapAdd(sender: UIBarButtonItem)
    {
        
        let viewController = AddItemViewController() //concrete subclass of abstract UIViewController class
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.view.backgroundColor = UIColor.whiteColor()
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }
    
    
    //MARK: Cache Actions
    
    func load() {
       // print("load")
        let object = self.cache.loadObjectForKey(cacheKey)
        if let items = object as? NSArray{
            self.items = NSMutableArray(array: items)        }
    }
    
    func save() {
      //  print("save")
        self.cache.saveObject(self.items, key: cacheKey)
    }
    

}
