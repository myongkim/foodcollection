//
//  CollectionViewController.swift
//  FoodCollection
//
//  Created by Isaac Kim on 9/1/17.
//  Copyright © 2017 Isaac Kim. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    @IBAction func addButtonTapped(_ sender: Any) {
        
        let item = DataItem(title: "New Item", kind: .American, imageName: "images/images/goodtime.jpg")
        let index = allItems[0].count
        allItems[0].append(item)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.insertItems(at: [indexPath])
        
    }
    
    
    
    var asiaDataItems = [DataItem]()
    var americanDataItems = [DataItem]()
    var allItems = [[DataItem]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let width = collectionView!.frame.width / 2
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
   // list of the images using for loop
        for i in 1...12 {
            if i > 9 {
                asiaDataItems.append(DataItem(title: "Title #\(i)", kind: Kind.Asian, imageName: "images/images/asianfood\(i).jpg"))
            } else {
                asiaDataItems.append(DataItem(title: "Title #0\(i)", kind: Kind.Asian, imageName: "images/images/asianfood0\(i).jpg"))
            }
        }
        for i in 1...12 {
            if i > 9 {
                americanDataItems.append(DataItem(title: "Another Title #\(i)", kind: Kind.American, imageName: "images/images/americanfood\(i).jpg"))
            } else {
                americanDataItems.append(DataItem(title: "Another Title #0\(i)", kind: Kind.American, imageName: "images/images/americanfood0\(i).jpg"))
            }
        }
        
        allItems.append(asiaDataItems)
        allItems.append(americanDataItems)

    
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
        return allItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = allItems[indexPath.section][indexPath.row]
        cell.dataItem = dataItem
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! DataItemHeader
        
        var title = ""
        if let kind = Kind(rawValue: indexPath.section){
            title = kind.description()
            
        }
        sectionHeader.title = title
        
        return sectionHeader
    }
   
    // delete the image
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func showAlert(title: String) {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "yes", style: .destructive, handler: { action in collectionView.performBatchUpdates({
                Void in
                self.allItems[indexPath.section].remove(at: indexPath.row)
                self.collectionView?.deleteItems(at: [indexPath])
                
            }, completion: nil) }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        let item = allItems[indexPath.section][indexPath.row]
        showAlert(title: "Delete '\(item.title)'?")
    }
    
    // move around the item
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = allItems[sourceIndexPath.section][sourceIndexPath.row]
        
        allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        if sourceIndexPath.section == destinationIndexPath.row {
            
            
            allItems[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
            
        } else {
            
            allItems[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
            
            if destinationIndexPath.section == 0 {
                itemToMove.kind = Kind.Asian
        
            } else {
                itemToMove.kind = Kind.American
            }
            
            
        }
        collectionView.reloadData()
    }

    
}
