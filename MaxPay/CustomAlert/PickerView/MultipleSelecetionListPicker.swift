
import UIKit


@objc protocol CustomListMultipleDelegate {
    
    func GetSelectedMultiplePickerItemIndex(arrIndex:[Bool])
    //@objc optional func ListDidHide()
}

class MultipleSelecetionListPicker: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var myDelegate:CustomListMultipleDelegate?
    //@IBOutlet weak var listPicker:UIPickerView!
    @IBOutlet weak var tblMultipleOption : UITableView!
    var itemsArr = Array<String>()
    var selectedIndex:Int! = 0
    var selectedItems = [Bool]()
    func ReloadPickerView(dataArray:Array<String>,selectedIncludedName:[Bool]) {
        
        tblMultipleOption.delegate = self
        tblMultipleOption.dataSource = self
        itemsArr = dataArray
        selectedItems = selectedIncludedName
        tblMultipleOption.reloadData()
        /*
        for _ in itemsArr {
            selectedItems.append(false)
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = itemsArr[indexPath.row]
        if (selectedItems[indexPath.row]){
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItems[indexPath.row] = !self.selectedItems[indexPath.row]
        tblMultipleOption.reloadData()
    }
    
    @IBAction func barBtnAction(sender:UIBarButtonItem) {
        let index = selectedItems.firstIndex(of: true)
        if sender.tag == 1 && index != nil {
          myDelegate?.GetSelectedMultiplePickerItemIndex(arrIndex:selectedItems)
        }
        //myDelegate?.ListDidHide!()
        MyBasics.hideMultipleListView()
    }
    
}
