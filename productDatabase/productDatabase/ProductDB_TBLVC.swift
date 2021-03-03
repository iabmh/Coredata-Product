

import UIKit




class ProductDB_TBLVC: UITableViewController {
    
    @IBOutlet var tblview: UITableView!
    
    var productlist:[Products] = []

    
    
    func fetchdata()
    {
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do
        {
            productlist = try context.fetch(Products.fetchRequest())
        }
        catch{
            print("Error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        
        
        self.fetchdata()
        self.tblview.reloadData()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productlist.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let allproduct = productlist[indexPath.row]
        cell.textLabel?.text = allproduct.product_name! + " " + allproduct.product_id! + " " + allproduct.product_price! + " " + allproduct.product_category!
        return cell
    }



    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let Deletingproduct = self.productlist[indexPath.row]
            context.delete(Deletingproduct)
            do{
             productlist = try context.fetch(Products.fetchRequest())
            }
            catch{
                print("error")
                
            }
            tblview.reloadData()
        }
    }


}
