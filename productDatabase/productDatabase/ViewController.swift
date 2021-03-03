
import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var EdtBtn: UIButton!
    @IBOutlet var Searchfield: UITextField!
    @IBOutlet var namefield: UITextField!
    
    @IBOutlet var IDfield: UITextField!
    
    @IBOutlet var pricefield: UITextField!
    
    @IBOutlet var categoryfield: UITextField!
    
    @IBOutlet var SearchDisplay: UITextView!
    
    @IBOutlet var UpdBtn: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchDisplay.isHidden = true
        UpdBtn.isHidden = true
        EdtBtn.isHidden = true

    }


    @IBAction func saveBTN(_ sender: Any) {
        
        
        let newproduct = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context)
        newproduct.setValue(namefield.text, forKey: "product_name")
        newproduct.setValue(IDfield.text, forKey: "product_id")
        newproduct.setValue(pricefield.text, forKey: "product_price")
        newproduct.setValue(categoryfield.text, forKey: "product_category")
        
        do{
            try context.save()
            namefield.text = ""
            IDfield.text = ""
            categoryfield.text = ""
            pricefield.text=""
        }
        catch{
            print("error")
        }
        
    }
    
    @IBAction func DataViewBTN(_ sender: Any) {
        
        let  storybrd = UIStoryboard(name: "Main", bundle: nil)
        let newpage = storybrd.instantiateViewController(withIdentifier: "productdb") as! ProductDB_TBLVC
        self.navigationController?.pushViewController(newpage, animated: true)
    }
    
    @IBAction func SearchBtn(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Products")
        let searchstring = Searchfield.text
        SearchDisplay.isHidden = false
        EdtBtn.isHidden = false
        UpdBtn.isHidden = false
        request.predicate = NSPredicate(format: "product_name == %@", searchstring!)
        var outputLine = ""

        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                
                for product in result{
                    
                    let productname = (product as AnyObject).value(forKey: "product_name") as! String
                    let productid = (product as AnyObject).value(forKey: "product_id") as! String
                    let productprice = (product as AnyObject).value(forKey: "product_price") as! String
                    let productcategory = (product as AnyObject).value(forKey: "product_category") as! String
                    outputLine += "Product name : \(productname) \n product ID : \(productid) \n product price :\(productprice) product category : \(productcategory)"
                }
            }
            else{
                outputLine = "Not Found"
                UpdBtn.isHidden = true
                EdtBtn.isHidden = true
            }
            SearchDisplay.text = outputLine
        }
        catch{
            
            print("Error")
            
        }
        
    }
    
    @IBAction func EditBtn(_ sender: UIButton) {
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Products")
        let searchstring = Searchfield.text
        request.predicate = NSPredicate(format: "product_name == %@", searchstring!)
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                
                for product in result{
                    
                    namefield.text = (product as AnyObject).value(forKey: "product_name") as? String
                    IDfield.text = (product as AnyObject).value(forKey: "product_id") as? String
                    pricefield.text = (product as AnyObject).value(forKey: "product_price") as? String
                    categoryfield.text = (product as AnyObject).value(forKey: "product_category") as? String
                }
    }
        }
        catch{
            print("error")
        }
    }
    @IBAction func UpdateBtn(_ sender: UIButton) {
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Products")
        let updatestr = Searchfield.text
        request.predicate = NSPredicate(format: "product_name == %@", updatestr!)
        do{
            let result = try context.fetch(request)
            for productlist in result{
                (productlist as AnyObject).setValue(namefield.text, forKey: "product_name")
                (productlist as AnyObject).setValue(IDfield.text, forKey: "product_id")
                (productlist  as AnyObject).setValue(categoryfield.text, forKey: "product_category")
                (productlist as AnyObject).setValue(pricefield.text, forKey: "product_price")
                
            }
            do {
               try context.save()
                categoryfield.text = ""
                IDfield.text = ""
                namefield.text = ""
                pricefield.text = ""
                UpdBtn.isHidden = true
                EdtBtn.isHidden = true
                SearchDisplay.isHidden = true
                Searchfield.text = ""
            }
            catch{
                print("error")
            }
        }
        catch{
            print("error")
        }
    }
    
    
}




