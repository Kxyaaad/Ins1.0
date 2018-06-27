//
//  MeController.swift
//  Ins
//
//  Created by Kxy on 2018/6/20.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class MeController: UICollectionViewController {
    //刷新控件
    var refresh : UIRefreshControl!
    //每页载入帖子的数量
    var page : Int = 12
    var puuidArray = [String]()
    var picArray = [AVFile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("加载成功")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
   
        self.navigationItem.title = AVUser.current()?.object(forKey: "username") as! String
        // Do any additional setup after loading the view.
        //初始化刷新控件
        refresh = UIRefreshControl()
        refresh.contentScaleFactor = 20
        refresh.addTarget(self, action: #selector(refreshfunc), for: UIControlEvents.valueChanged)
        //设置collectionview总是可以反弹，以便在cell数量少的时候也能下拉刷新
        collectionView?.alwaysBounceVertical = true
        self.collectionView?.addSubview(refresh)
        loadpost()

    }
    
    @objc func refreshfunc() {
        refresh.beginRefreshing()
       loadpost()
    }
    
    func loadpost() {
        let quary = AVQuery(className: "Post")
        quary.whereKey("username", equalTo: AVUser.current()?.object(forKey: "username"))
        quary.limit = page
        quary.findObjectsInBackground { (objects:[Any]?, error) in
            if error == nil {
                self.puuidArray.removeAll(keepingCapacity: false)
                self.picArray.removeAll(keepingCapacity: false)
                
                for object in objects! {
                    self.puuidArray.append((object as AnyObject).value(forKey: "puuid") as! String)
                    self.picArray.append((object as AnyObject).value(forKey: "Pic") as! AVFile)
                }
                self.collectionView?.reloadData()
                self.refresh.endRefreshing()
            }else{
                print(error)
            }
        }
       
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return picArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureCell
        picArray[indexPath.row].getDataInBackground { (data, error) in
            if error == nil{
                cell.PicCell.image = UIImage(data: data!)
            }else{
                print(error)
            }
        }
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! HeaderView
        let user = AVUser.current()
        header.username.text = user?.object(forKey: "username") as? String
        let avquery = user?.object(forKey: "image") as! AVFile
        header.img.layer.cornerRadius = 10
        OperationQueue.main.addOperation {
            avquery.getDataInBackground { (data, error) in
                header.img.image = UIImage(data: data!)
            }
        }
        
        print("加载个人资料")
        return header
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
