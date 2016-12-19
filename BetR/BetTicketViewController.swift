import UIKit

class BetTicketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    static weak var activeText: UITextField!
    var textFieldEditing:Bool = false
    
    var category: BetCategory? {
        didSet {
            for game in GameTrakTableViewCell.sharedGames {
                gamesArray.append(game)
            }
        }
    }
    
    var gamesArray: [GameTrakSelections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BetTicketViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gamesArray[(indexPath as NSIndexPath).row]
        
        // set the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BetTicketTableViewCell
        cell.teamLabel.text = game.Team
        cell.versusLabel.text = game.Versus
        cell.gameDateLabel.text = game.GameDate
        cell.dataPieceLabel.text = game.Data
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 61.0 / 255, green: 66.0 / 255, blue: 77.0 / 255, alpha: 1.0)
        
        let label = UILabel()
        label.text = "Straight Wagers"
        label.textColor = UIColor.white
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        } else {
            label.font = UIFont.systemFont(ofSize: 17)
        }
        label.sizeToFit()
        label.frame.origin = CGPoint(x: 18, y: 13)
        
        view.addSubview(label)
        
        return view
    }
    
    func keyboardWillShow(note: NSNotification) {
        
        //set flag = true
        
        if textFieldEditing == false {
            
            textFieldEditing = true
            if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                var frame = tableView.frame
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationBeginsFromCurrentState(true)
                UIView.setAnimationDuration(0.3)
                frame.size.height -= keyboardSize.height
                tableView.frame = frame
                if BetTicketViewController.activeText != nil {
                    let rect = tableView.convert(BetTicketViewController.activeText.bounds, from: BetTicketViewController.activeText)
                    tableView.scrollRectToVisible(rect, animated: false)
                }
                
                UIView.commitAnimations()
            }
        }
    }
    
    func keyboardWillHide(note: NSNotification) {
        
        textFieldEditing = false
        
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = tableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height += keyboardSize.height
            tableView.frame = frame
            UIView.commitAnimations()
        }
    }


}

class BetTicketTableViewCell: UITableViewCell, UITextFieldDelegate  {
    
    @IBOutlet weak var txtJuice: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var versusLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    @IBOutlet weak var dataPieceLabel: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        txtAmount.delegate = self
        txtJuice.delegate = self
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        BetTicketViewController.activeText = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        BetTicketViewController.activeText = nil
    }
    

}
