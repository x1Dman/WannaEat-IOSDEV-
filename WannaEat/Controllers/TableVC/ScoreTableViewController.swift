//
//  ScoreTableViewController.swift
//  WannaEat
//
//  Created by Apple on 20/03/2010.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

extension String {
	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
}

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	var abc: Receipts = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("LOADED")
		collectionView?.backgroundColor = .black
		self.collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "myCell")
	}
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print(abc.count)
		return abc.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 300, height: 300)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let deque = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
		guard let cell = deque as? CollectionCell else {
			return UICollectionViewCell()
		}
		let receipt = abc[indexPath.row]
//		cell.layer.shouldRasterize = true
//		cell.layer.rasterizationScale = UIScreen.main.scale
		cell.image.downloaded(from: "http://127.0.0.1:8000\(receipt.image)")
		print("http://127.0.0.1:8000\(receipt.image)")
		cell.layer.cornerRadius = min(cell.frame.size.height, cell.frame.size.width) / 2.0
		cell.layer.masksToBounds = true
		return cell
	}
	
	// MARK: - Table view data source
	
	//    override func numberOfSections(in tableView: UITableView) -> Int {
	//        // #warning Incomplete implementation, return the number of sections
	//        return 1
	//    }
	//
	//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	//        // #warning Incomplete implementation, return the number of rows
	//        return abc.count
	//    }
	//
	//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	//        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
	//        let currentText = miniParse(str: abc[indexPath.row].title!)
	//        print(indexPath.row,"-",currentText)
	//        if  currentText != "" {
	//            cell.textLabel?.text = currentText
	//        }else{
	//            cell.textLabel?.text = "Undefined food"
	//        }
	//        cell.textLabel?.textColor = .white
	//        if abc[indexPath.row].thumbnail! != "" {
	//            let url = URL(string: miniParse(str: abc[indexPath.row].thumbnail!))
	//            let data = try? Data(contentsOf: url!)
	//            cell.imageView?.image = UIImage(data: data!)
	//        }else{
	//            cell.imageView?.image = UIImage(named: "rest")
	//        }
	//        cell.backgroundColor = .black
	//        return cell
	//    }
	//
	//    // Override to support conditional editing of the table view.
	//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	//        // Return false if you do not want the specified item to be editable.
	//        return false
	//    }
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		//        (segue.destination as? InfoViewController)?.urlPhoto = abc[(tableView.indexPathForSelectedRow?.row)!].thumbnail
		//        (segue.destination as? InfoViewController)?.receipt = abc[(tableView.indexPathForSelectedRow?.row)!].ingredients
		//        (segue.destination as? InfoViewController)?.href = abc[(tableView.indexPathForSelectedRow?.row)!].href
	}
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
